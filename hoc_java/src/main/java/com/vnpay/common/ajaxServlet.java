package com.vnpay.common;

import entity.DonHang;
import entity.NguoiDung;
import model.DonHangDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet("/payment")
public class ajaxServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession ses = req.getSession();
        float amountFloat = Float.parseFloat(req.getParameter("totalAmount"));
        long amount = (long) (amountFloat * 100); // Nhân với 100 cho VNPay

        NguoiDung acc = (NguoiDung) ses.getAttribute("user");
        int uid = acc.getId();
        String ten = req.getParameter("hoTen");
        String diaChi = req.getParameter("diaChi");
        String sdt = req.getParameter("soDienThoai");
        String email = req.getParameter("email");
        String ghiChu = req.getParameter("ghiChu");
        DonHang donHang = new DonHang();
        donHang.setNguoiDungId(uid);
        donHang.setHoTen(ten);
        donHang.setEmail(email);
        donHang.setNgayTao(new Timestamp(System.currentTimeMillis()));
        donHang.setDiaChi(diaChi);
        donHang.setSoDienThoai(sdt);
        donHang.setHinhThuc("VNpay");
        donHang.setGhiChu(ghiChu);
        donHang.setTongTien(amount/100);
        donHang.setTrangThai("Đang xử lí");
        int donHangId = 0;
        try {
            donHangId = DonHangDao.insertVnpay(donHang);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        String vnp_Version = "2.1.0";
        String vnp_Command = "pay";
        String orderType = "other";
        String bankCode = req.getParameter("bankCode");

        String vnp_TxnRef = String.valueOf(donHangId);
        String vnp_IpAddr = Config.getIpAddress(req);

        // Kiểm tra vnp_TmnCode
        if (Config.vnp_TmnCode == null || Config.vnp_TmnCode.isEmpty()) {
            throw new IllegalStateException("vnp_TmnCode is not configured");
        }
        String vnp_TmnCode = Config.vnp_TmnCode;

        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", vnp_Version);
        vnp_Params.put("vnp_Command", vnp_Command);
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(amount));
        vnp_Params.put("vnp_CurrCode", "VND");

        if (bankCode != null && !bankCode.isEmpty()) {
            vnp_Params.put("vnp_BankCode", bankCode);
        }
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang:" + vnp_TxnRef);
        vnp_Params.put("vnp_OrderType", orderType);

        String locate = req.getParameter("language");
        if (locate != null && !locate.isEmpty()) {
            vnp_Params.put("vnp_Locale", locate);
        } else {
            vnp_Params.put("vnp_Locale", "vn");
        }
        vnp_Params.put("vnp_ReturnUrl", Config.vnp_ReturnUrl);
        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

        cld.add(Calendar.MINUTE, 15);
        String vnp_ExpireDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

        List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        Iterator<String> itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = itr.next();
            String fieldValue = vnp_Params.get(fieldName);
            if (fieldValue != null && !fieldValue.isEmpty()) {
                hashData.append(fieldName).append('=').append(URLEncoder.encode(fieldValue, StandardCharsets.UTF_8.toString()));
                query.append(URLEncoder.encode(fieldName, StandardCharsets.UTF_8.toString())).append('=').append(URLEncoder.encode(fieldValue, StandardCharsets.UTF_8.toString()));
                if (itr.hasNext()) {
                    query.append('&');
                    hashData.append('&');
                }
            }
        }

        String queryUrl = query.toString();
        String vnp_SecureHash = Config.hmacSHA512(Config.secretKey, hashData.toString());
        if (vnp_SecureHash == null || vnp_SecureHash.isEmpty()) {
            throw new IllegalStateException("Failed to generate vnp_SecureHash");
        }
        queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;

        String paymentUrl = Config.vnp_PayUrl + "?" + queryUrl;

        // Log để debug
        System.out.println("Hash Data: " + hashData.toString());
        System.out.println("Query URL: " + queryUrl);
        System.out.println("Payment URL: " + paymentUrl);

        // Thêm CSP header
        resp.setHeader("Content-Security-Policy", 
            "default-src 'self'; style-src 'self' 'unsafe-inline' https://sandbox.vnpayment.vn; script-src 'self' 'unsafe-inline'; img-src 'self' https://sandbox.vnpayment.vn; connect-src 'self' https://sandbox.vnpayment.vn; frame-ancestors 'none'");

        resp.sendRedirect(paymentUrl);
    }
}