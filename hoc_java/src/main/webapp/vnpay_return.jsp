<%@page import="model.DonHangDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.nio.charset.StandardCharsets,javax.crypto.Mac,javax.crypto.spec.SecretKeySpec,java.net.URLEncoder,com.vnpay.common.Config" %>
<%@ page import="entity.ChiTietDonHang" %>
<%@ page import="entity.SanPham" %>
<%@ page import="entity.NguoiDung" %>
<%@ page import="model.ChiTietDonHangDao" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Kết quả thanh toán</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<%
    // Lấy tất cả tham số từ URL
    Map<String, String> vnp_Params = new HashMap<>();
    Enumeration<String> paramNames = request.getParameterNames();
    while (paramNames.hasMoreElements()) {
        String paramName = paramNames.nextElement();
        String paramValue = request.getParameter(paramName);
        vnp_Params.put(paramName, paramValue);
    }

    // Lấy vnp_SecureHash và loại bỏ khỏi map để tính lại hash
    String vnp_SecureHash = vnp_Params.get("vnp_SecureHash");
    vnp_Params.remove("vnp_SecureHash");

    // Sắp xếp tham số theo thứ tự chữ cái
    List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
    Collections.sort(fieldNames);
    StringBuilder hashData = new StringBuilder();
    for (int i = 0; i < fieldNames.size(); i++) {
        String name = fieldNames.get(i);
        String value = vnp_Params.get(name);
        if (value != null && !value.isEmpty()) {
            hashData.append(name).append('=').append(URLEncoder.encode(value, StandardCharsets.UTF_8.toString()));
            if (i < fieldNames.size() - 1) {
                hashData.append('&');
            }
        }
    }

    // Tính lại hash
    String calculatedHash = Config.hmacSHA512(Config.secretKey, hashData.toString());
    List<SanPham> cart = (List<SanPham>) session.getAttribute("cart");
    request.setCharacterEncoding("UTF-8");
    response.setContentType("text/html;charset=UTF-8");


    if (calculatedHash != null && calculatedHash.equals(vnp_SecureHash)) {
        String responseCode = vnp_Params.get("vnp_ResponseCode");

        if ("00".equals(responseCode)) {
            Boolean check = DonHangDao.updateTrangThaiThanhToanThanhCong(Integer.parseInt(vnp_Params.get("vnp_TxnRef")));

            if (check) {
                List<ChiTietDonHang> dsChiTiet = new ArrayList<>();

                for (SanPham sp : cart) {
                    ChiTietDonHang ct = new ChiTietDonHang(
                        Integer.parseInt(vnp_Params.get("vnp_TxnRef")),
                        sp.getId(),
                        sp.getSoLuong(),
                        sp.getGia()
                    );
                    dsChiTiet.add(ct);
                }

                Boolean checkChiTiet = ChiTietDonHangDao.insertChiTietDonHang(dsChiTiet);
                if (checkChiTiet) {
%>
                    <script>
                    <% session.removeAttribute("cart"); %>
                        Swal.fire({
                            icon: 'success',
                            title: 'Thanh toán thành công',
                            text: 'Giao dịch đã được xử lý thành công.',
                            confirmButtonText: 'OK'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                window.location.href = 'sanPhamController';
                            }
                        });
                    </script>
<%
                } else {
%>
                    <script>
                        Swal.fire({
                            icon: 'error',
                            title: 'Cập nhật chi tiết đơn hàng thất bại',
                            text: 'Hệ thống không thể lưu chi tiết đơn hàng.',
                            confirmButtonText: 'OK'
                        });
                    </script>
<%
                }
            } else {
%>
                <script>
                    Swal.fire({
                        icon: 'error',
                        title: 'Cập nhật đơn hàng thất bại',
                        text: 'Hệ thống không thể cập nhật trạng thái đơn hàng.',
                        confirmButtonText: 'OK'
                    });
                </script>
<%
            }
        } else {
%>
            <script>
                Swal.fire({
                    icon: 'error',
                    title: 'Thanh toán thất bại',
                    text: 'Mã phản hồi: <%= vnp_Params.get("vnp_ResponseCode") %>',
                    confirmButtonText: 'OK'
                });
            </script>
<%
        }
    } else {
%>
        <script>
            Swal.fire({
                icon: 'error',
                title: 'Lỗi xác minh dữ liệu',
                text: 'Dữ liệu trả về không hợp lệ (hash không khớp).',
                confirmButtonText: 'OK'
            });
        </script>
<%
    }
%>
</body>
</html>