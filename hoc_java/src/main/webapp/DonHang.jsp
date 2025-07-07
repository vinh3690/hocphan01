<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn Hàng Của Tôi</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body {
            background-color: #f5f5f5;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .order-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            padding: 20px;
            transition: transform 0.2s;
        }
        .order-card:hover {
            transform: translateY(-5px);
        }
        .order-header {
            background: #007bff;
            color: white;
            padding: 10px 15px;
            border-radius: 8px 8px 0 0;
            font-weight: bold;
        }
        .order-item {
            border-bottom: 1px solid #eee;
            padding: 10px 0;
            align-items: center;
        }
        .order-item:last-child {
            border-bottom: none;
        }
        .btn-delete {
            background: #dc3545;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            transition: background 0.3s;
        }
        .btn-delete:hover {
            background: #c82333;
        }
        .container {
            max-width: 1200px;
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        .product-img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 5px;
            margin-right: 15px; /* Thêm khoảng cách bên phải */
        }
        .order-info {
            font-size: 0.9em;
            color: #555;
            margin-top: 10px;
        }
    </style>
</head>
<body>
<jsp:include page="Header.jsp" />
    <div class="container" style="margin-top: 100px;">
        <h1><i class="fas fa-shopping-bag"></i> Đơn Hàng Của Tôi</h1>
        
        <c:if test="${empty ct}">
            <div class="alert alert-info text-center">
                Bạn chưa có đơn hàng nào.
            </div>
        </c:if>

        <c:forEach items="${ct}" var="donHang">
            <div class="order-card" id="donhang-${donHang.id}">
                <div class="order-header">
                    Đơn hàng #DH${donHang.id} - Ngày đặt: 
                    <fmt:formatDate value="${donHang.ngayTao}" pattern="dd/MM/yyyy HH:mm"/>
                </div>
                <c:forEach items="${donHang.chiTietDonHangList}" var="chiTiet" varStatus="loop">
                    <div class="order-item d-flex">
                        <div class="col-md-2">
                            <img src="images/${chiTiet.sanPham.anh}" 
                                 alt="${chiTiet.sanPham.tenSanPham}" 
                                 class="product-img"
                                 onerror="this.src='images/no-image.png'">
                        </div>
                        <div class="col-md-5">
                            <strong>Sản phẩm:</strong> ${chiTiet.sanPham.tenSanPham}<br>
                            <strong>Số lượng:</strong> ${chiTiet.soLuong}<br>
                            <strong>Giá:</strong> 
                            <fmt:formatNumber value="${chiTiet.donGia}" type="number" currencySymbol="VNĐ"/> VNĐ
                        </div>
                        <div class="col-md-3">
                            <strong>Trạng thái:</strong> ${donHang.trangThai}<br>
                            <strong>Hình thức:</strong> ${donHang.hinhThuc}
                        </div>
                        <div class="col-md-2 text-end">
                            <c:if test="${loop.first}">
                                <button class="btn-delete" onclick="confirmDelete('${donHang.id}')">
                                    <i class="fas fa-trash"></i> Xóa
                                </button>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
                <div class="order-info">
                    <strong>Tổng tiền:</strong> 
                    <fmt:formatNumber value="${donHang.tongTien}" type="number" groupingUsed="true" /> VNĐ<br>
                    <strong>Người nhận:</strong> ${donHang.hoTen}<br>
                    <strong>Địa chỉ:</strong> ${donHang.diaChi}<br>
                    <strong>Số điện thoại:</strong> ${donHang.soDienThoai}<br>
                    <strong>Email:</strong> ${donHang.email}<br>
                    <c:if test="${not empty donHang.ghiChu}">
                        <strong>Ghi chú:</strong> ${donHang.ghiChu}<br>
                    </c:if>
                </div>
            </div>
        </c:forEach>
        
    </div>
<jsp:include page="Footer.jsp" />
    <!-- Bootstrap JS and Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(orderId) {
            if (!orderId) {
                alert("Mã đơn hàng không hợp lệ!");
                return;
            }
            if (confirm('Bạn có chắc chắn muốn xóa đơn hàng #' + orderId + '?')) {
                console.log('Xóa đơn hàng:', orderId);
                fetch('XoaDonHang?id=' + encodeURIComponent(orderId), {
                    method: 'GET'
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('HTTP error, status = ' + response.status);
                    }
                    return response.json();
                })
                .then(data => {
                    console.log('Response data:', data);
                    if (data.success) {
                        const orderCard = document.getElementById('donhang-' + orderId);
                        if (orderCard) {
                            orderCard.remove();
                            alert("Đã xóa đơn hàng #" + orderId);
                        } else {
                            console.warn('Không tìm thấy phần tử donhang-' + orderId);
                            alert("Đã xóa đơn hàng #" + orderId + " trong cơ sở dữ liệu, nhưng không tìm thấy trên giao diện.");
                        }
                    } else {
                        alert("Xóa thất bại: " + (data.error || "Lỗi không xác định"));
                    }
                })
                .catch(error => {
                    console.error('Lỗi:', error);
                    alert("Có lỗi xảy ra khi xóa: " + error.message);
                });
            }
        }
        
    </script>
</body>
</html>