<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
        <h2>Liên Hệ Với Chúng Tôi</h2>
        <form method="post" action="hocServlet">
            <div class="form-group">
                <label for="name">Họ và Tên:</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="message">Nội dung:</label>
                <textarea id="message" name="message" rows="5" required></textarea>
            </div>
            <button type="submit">Gửi Liên Hệ</button>
        </form>
    </div>
</body>
</html>