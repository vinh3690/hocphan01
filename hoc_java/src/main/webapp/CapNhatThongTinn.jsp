<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cập nhật thông tin cá nhân</title>
<style>
body {
	font-family: Arial, sans-serif;
	max-width: 600px;
	margin: 50px auto;
	padding: 20px;
	background-color: #f4f4f4;
}

h2 {
	text-align: center;
	color: #333;
}

.form-group {
	margin-bottom: 15px;
}

label {
	display: block;
	margin-bottom: 5px;
	font-weight: bold;
}

input[type="text"], input[type="password"], input[type="email"] {
	width: 100%;
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
}

input[type="text"][disabled] {
	background-color: #e9ecef;
}

input[type="submit"] {
	background-color: #4CAF50;
	color: white;
	padding: 10px 15px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	width: 100%;
}

input[type="submit"]:hover {
	background-color: #45a049;
}

.message {
    text-align: center;
    margin-top: 20px;
    color: #4CAF50;
    background-color: #e8f5e9; /* Light green background */
    padding: 10px;
    border-radius: 4px;
}
</style>
</head>
<body>
<%
if (request.getAttribute("message") != null) {
%>
<div class="message"><%=request.getAttribute("message")%></div>
<%
}
%>
	<h2>Cập nhật thông tin cá nhân</h2>
	<form action="SuaThongTinNguoiDung" method="post">
	<input type="hidden" name="id" value="${user.id}">
		<div class="form-group">
			<label for="tenDangNhap">Tên đăng nhập:</label> <input type="text"
				id="tenDangNhap" name="tenDangNhap" value="${user.tenDangNhap}"
				disabled> <input type="hidden" name="tenDangNhap"
				value="${user.tenDangNhap}">
		</div>
		<div class="form-group" style="position: relative;">
			<label for="matKhau">Mật khẩu:</label> <input type="password"
				id="matKhau" name="matKhau" value="${user.matKhau.trim()}" required>
			<span id="togglePassword"
				style="position: absolute; right: 10px; top 32px; cursor: pointer;">
				👁️ </span>
		</div>
		<div class="form-group">
			<label for="hoTen">Họ và tên:</label> <input type="text" id="hoTen"
				name="hoTen" value="${user.hoTen}" required>
		</div>
		<div class="form-group">
			<label for="email">Email:</label> <input type="email" id="email"
				name="email" value="${user.email}" required>
		</div>
		<div class="form-group">
			<label for="phone">Số điện thoại:</label> <input type="text"
				id="phone" name="phone" value="${user.phone}" required>
		</div>
		<div class="form-group">
			<label for="diaChi">Địa chỉ:</label> <input type="text" id="diaChi"
				name="diaChi" value="${user.diaChi}" required>
		</div>
		<input type="submit" value="Cập nhật">
	</form>
	<% if (request.getAttribute("message") != null) { %>
    <div class="alert alert-success message" style="text-align: center;">
        <%= request.getAttribute("message") %>
    </div>

    <script>
        // Chờ 3 giây rồi chuyển hướng
        setTimeout(function () {
            window.location.href = "sanPhamController"; // Đổi thành URL phù hợp
        }, 3000);
    </script>
<% } %>

</body>

<script>
    const togglePassword = document.getElementById("togglePassword");
    const passwordField = document.getElementById("matKhau");

    togglePassword.addEventListener("click", () => {
        const type = passwordField.getAttribute("type") === "password" ? "text" : "password";
        passwordField.setAttribute("type", type);
        togglePassword.textContent = type === "password" ? "👁️" : "🙈";
    });
</script>
</html>