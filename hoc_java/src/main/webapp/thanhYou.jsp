<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Liên hệ GreenMart - Cửa hàng hoa quả tươi sạch, sấy khô và nhập khẩu chất lượng cao. Gửi thắc mắc hoặc đặt hàng ngay hôm nay!">
    <meta name="keywords" content="GreenMart, liên hệ GreenMart, hoa quả tươi, trái cây nhập khẩu, cửa hàng trái cây, thực phẩm sạch">
    <meta name="author" content="GreenMart">
    <meta name="robots" content="index, follow">
    <title>Liên hệ - GreenMart</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f7f5;
            color: #333;
            line-height: 1.6;
            overflow-x: hidden;
        }

        /* Container */
        .container {
            max-width: 1300px;
            margin: 0 auto;
            padding: 3rem 1rem;
        }

        .contact-section {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 3rem;
            margin-top: 2rem;
            align-items: start;
        }

        /* Contact Info */
        .contact-info {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .contact-info:hover {
            transform: translateY(-5px);
        }

        .contact-info h2 {
            font-size: 2rem;
            color: #4CAF50;
            margin-bottom: 1.5rem;
        }

        .contact-info p {
            font-size: 1.1rem;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
        }

        .contact-info i {
            color: #4CAF50;
            margin-right: 0.8rem;
            font-size: 1.3rem;
        }

        .social-links {
            margin-top: 1.5rem;
            display: flex;
            gap: 1rem;
        }

        .social-links a {
            color: #4CAF50;
            font-size: 1.5rem;
            transition: color 0.3s;
        }

        .social-links a:hover {
            color: #2e7d32;
        }

        /* Contact Form */
        .contact-form {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .contact-form:hover {
            transform: translateY(-5px);
        }

        .contact-form h2 {
            font-size: 2rem;
            color: #4CAF50;
            margin-bottom: 1.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: #333;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 0.9rem;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 1rem;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            border-color: #4CAF50;
            box-shadow: 0 0 8px rgba(76, 175, 80, 0.2);
            outline: none;
        }

        .form-group textarea {
            resize: vertical;
            min-height: 120px;
        }

        .form-group input[type="submit"] {
            background: linear-gradient(135deg, #4CAF50, #2e7d32);
            color: white;
            border: none;
            padding: 1rem 2rem;
            cursor: pointer;
            font-size: 1.1rem;
            border-radius: 6px;
            transition: background 0.3s, transform 0.2s;
        }

        .form-group input[type="submit"]:hover {
            background: linear-gradient(135deg, #45a049, #2e7d32);
            transform: translateY(-2px);
        }

        .form-group input[type="submit"]:disabled {
            background: #cccccc;
            cursor: not-allowed;
            transform: none;
        }

        /* Map */
        .map {
            margin-top: 3rem;
            text-align: center;
        }

        .map h2 {
            font-size: 2rem;
            color: #4CAF50;
            margin-bottom: 1.5rem;
        }

        .map iframe {
            width: 100%;
            height: 450px;
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        /* Message */
        .message {
            text-align: center;
            margin-top: 1.5rem;
            font-size: 1.1rem;
            padding: 1rem;
            border-radius: 6px;
            animation: fadeIn 0.5s ease-in;
        }

        .message.success {
            color: #4CAF50;
            background: #e8f5e9;
        }

        .message.error {
            color: #d32f2f;
            background: #ffebee;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .contact-section {
                grid-template-columns: 1fr;
            }

            .map iframe {
                height: 300px;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 1.5rem;
            }

            .contact-info, .contact-form {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
 <jsp:include page="Header.jsp" />
    <div class="container" style="margin-top: 100px;">
        <div class="contact-section">

            <div class="contact-form">
                <h2>Gửi tin nhắn cho chúng tôi</h2>
                <form action="SendContact" method="post" id="contactForm" novalidate>
                    <div class="form-group">
                        <label for="hoTen">Họ và tên <span aria-hidden="true">*</span></label>
                        <input type="text" id="hoTen" name="hoTen" required aria-required="true">
                    </div>
                    <div class="form-group">
                        <label for="email">Email <span aria-hidden="true">*</span></label>
                        <input type="email" id="email" name="email" required aria-required="true">
                    </div>
                    <div class="form-group">
                        <label for="phone">Số điện thoại <span aria-hidden="true">*</span></label>
                        <input type="tel" id="phone" name="phone" required aria-required="true">
                    </div>
                    <div class="form-group">
                        <label for="message">Tin nhắn <span aria-hidden="true">*</span></label>
                        <textarea id="message" name="message" required aria-required="true"></textarea>
                    </div>
                    <div class="form-group">
                        <input type="submit" value="Gửi liên hệ" id="submitBtn">
                    </div>
                </form>
                <%
                String message = (String) request.getAttribute("message");
                String messageType = (String) request.getAttribute("messageType");
                if (message != null) {
                %>
                <div class="message <%= messageType != null ? messageType : "success" %>">
                    <%= message %>
                </div>
                <%
                }
                %>
            </div>
        </div>
    </div>
     <jsp:include page="Footer.jsp" />

    <script>
        document.getElementById('contactForm').addEventListener('submit', function(event) {
            event.preventDefault();
            const submitBtn = document.getElementById('submitBtn');
            submitBtn.disabled = true;

            const hoTen = document.getElementById('hoTen').value.trim();
            const email = document.getElementById('email').value.trim();
            const phone = document.getElementById('phone').value.trim();
            const message = document.getElementById('message').value.trim();
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            const phoneRegex = /^[0-9]{10,11}$/;

            if (!hoTen) {
                alert('Vui lòng nhập họ và tên!');
                submitBtn.disabled = false;
                return;
            }

            if (!emailRegex.test(email)) {
                alert('Vui lòng nhập email hợp lệ!');
                submitBtn.disabled = false;
                return;
            }

            if (!phoneRegex.test(phone)) {
                alert('Vui lòng nhập số điện thoại hợp lệ (10-11 chữ số)!');
                submitBtn.disabled = false;
                return;
            }

            if (!message) {
                alert('Vui lòng nhập tin nhắn!');
                submitBtn.disabled = false;
                return;
            }

            // If all validations pass, submit the form
            this.submit();
        });

        // Reset form after successful submission
        <% if (request.getAttribute("message") != null && "success".equals(request.getAttribute("messageType"))) { %>
            document.getElementById('contactForm').reset();
        <% } %>
    </script>
</body>
</html>