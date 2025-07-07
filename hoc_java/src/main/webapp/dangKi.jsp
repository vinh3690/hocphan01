<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng Ký - Cửa Hàng Hoa Quả Tươi</title>
    <link rel="stylesheet" href="dangKi1.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <div class="container">
        <div class="register-box">
            <div class="frame">
                <div class="logo">
                    <img src="logo.png" alt="Fruit Shop Logo">
                    <h2>Đăng Ký Tài Khoản</h2>
                </div>
                <form action="dangKiController" method="post">
                    <div class="textbox">
                        <label for="fullname"><i class="fas fa-user"></i> Họ và tên</label>
                        <input type="text" id="fullname" placeholder="Nhập họ và tên" name="fullname" required>
                    </div>
                    <div class="textbox">
                        <label for="diaChi"><i class="fas fa-envelope"></i>Địa chỉ</label>
                        <input type="text" id="diaChi" placeholder="Nhập địa chỉ" name="diaChi" required>
                    </div>
                    <div class="textbox">
                        <label for="email"><i class="fas fa-envelope"></i> Email</label>
                        <input type="email" id="email" placeholder="Nhập email" name="email" required>
                    </div>
                    <div class="textbox">
                        <label for="phone"><i class="fas fa-phone"></i> Số điện thoại</label>
                        <input type="tel" id="phone" placeholder="Nhập số điện thoại" name="phone" pattern="[0-9]{10}" required>
                    </div>
                    <div class="textbox">
                        <label for="username"><i class="fas fa-user-circle"></i> Tên đăng nhập</label>
                        <input type="text" id="username" placeholder="Nhập tên đăng nhập" name="username" required>
                    </div>
                    <div class="textbox">
                        <label for="password"><i class="fas fa-lock"></i> Mật khẩu</label>
                        <input type="password" id="password" placeholder="Nhập mật khẩu" name="password" required>
                    </div>
                    <div class="textbox">
                        <label for="confirm_password"><i class="fas fa-lock"></i> Xác nhận mật khẩu</label>
                        <input type="password" id="confirm_password" placeholder="Xác nhận mật khẩu" name="confirm_password" required>
                    </div>
                    <button type="submit" class="btn">Đăng Ký</button>
                    <p class="login-link">Đã có tài khoản? <a href="login.jsp">Đăng nhập ngay</a></p>
                </form>
                <% 
                    String error = (String) request.getAttribute("mess");
                    if (error != null) {
                %>
                    <p class="error"><i class="fas fa-exclamation-circle"></i> <%= error %></p>
                <% } %>
            </div>
        </div>
    </div>
</body>
</html>