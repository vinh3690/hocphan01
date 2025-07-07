<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng Nhập - Cửa Hàng Hoa Quả Tươi</title>
    <link rel="stylesheet" href="login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
	<!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	
</head>
<body>
    <div class="container">
        <div class="login-box">
            <div class="logo">
                <img src="images/logo.png" alt="Fruit Shop Logo" style="border-radius: 10px;">
                
                <h2>Đăng Nhập</h2>  
            </div>
            <form action="dangNhap" method="post">
                <div class="textbox">
                    <i class="fas fa-user"></i>
                    <input type="text" placeholder="Tên đăng nhập" name="username" required>
                </div>
                <div class="textbox">
                    <i class="fas fa-lock"></i>
                    <input type="password" placeholder="Mật khẩu" name="password" required>
                </div>
                <button type="submit" class="btn">Đăng Nhập</button>
                <p class="register-link">Chưa có tài khoản? <a href="dangKi.jsp">Đăng ký ngay</a></p>
            </form>
            <% 
                String error = (String) request.getAttribute("error");
                if (error != null) {
            %>
                <p class="error"><i class="fas fa-exclamation-circle"></i> <%=  error %></p>
            <% } %>
       <c:if test="${param.error == 'login_required'}">
    <div class="alert alert-danger" role="alert">
        Vui lòng đăng nhập để tiếp tục thanh toán.
    </div>
</c:if>
       
            
        </div>
    </div>
</body>
</html>