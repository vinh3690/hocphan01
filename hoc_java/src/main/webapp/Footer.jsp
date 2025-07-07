<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        footer {
            background: linear-gradient(135deg, #4CAF50, #2e7d32);
            color: white;
            padding: 2rem 0;
            
            font-family: 'Poppins', sans-serif;
            text-align: center;
            margin-top: 2rem;
        }

        .footer-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            gap: 2rem;
            align-items: start;
        }

        .footer-logo {
            font-size: 1.8rem;
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .footer-links {
            display: flex;
            flex-direction: column;
            gap: 0.8rem;
            margin-bottom: 1rem;
        }

        .footer-links a {
            color: white;
            text-decoration: none;
            font-size: 1rem;
            transition: color 0.3s;
        }

        .footer-links a:hover {
            color: #e8f5e9;
        }

        .footer-social {
            display: flex;
            gap: 1.2rem;
            margin-bottom: 1rem;
        }

        .footer-social a {
            color: white;
            font-size: 1.5rem;
            transition: color 0.3s;
        }

        .footer-social a:hover {
            color: #e8f5e9;
        }

        .footer-map {
            text-align: center;
        }

        .footer-map h4 {
            font-size: 1.2rem;
            margin-bottom: 1rem;
        }

        .footer-map iframe {
            width: 100%;
            height: 200px;
            border: none;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .footer-bottom {
            grid-column: span 3;
            font-size: 0.9rem;
            margin-top: 1.5rem;
            opacity: 0.9;
            border-top: 1px solid rgba(255, 255, 255, 0.2);
            padding-top: 1rem;
        }

        @media (max-width: 768px) {
            .footer-container {
                grid-template-columns: 1fr;
                text-align: center;
            }

            .footer-links, .footer-social, .footer-map {
                margin-bottom: 1.5rem;
            }

            .footer-bottom {
                grid-column: span 1;
            }
        }

        @media (max-width: 480px) {
            .footer-logo {
                font-size: 1.5rem;
            }

            .footer-links a {
                font-size: 0.9rem;
            }

            .footer-social a {
                font-size: 1.3rem;
            }

            .footer-map iframe {
                height: 150px;
            }
        }
    </style>
</head>
<body>
    <footer>
    <div class="footer-container">
        <div class="footer-logo-section">
            <div class="footer-logo">GreenMart</div>
            <p style="font-size: 0.9rem; opacity: 0.8;">Cửa hàng hoa quả tươi sạch</p>
        </div>

        <div class="footer-links">
            <a href="Home.jsp">Trang chủ</a>
            <a href="Products.jsp">Sản phẩm</a>
            <a href="About.jsp">Giới thiệu</a>
            <a href="Contact.jsp">Liên hệ</a>
        </div>

        <div class="footer-info">
            <h4>Thông tin liên hệ</h4>
            <p><strong>Cửa hàng:</strong> GreenMart</p>
            <p><strong>Địa chỉ:</strong> 123 Đường Trái Cây, Quận 1, TP.HCM</p>
            <p><strong>Điện thoại:</strong> 0901 234 567</p>
            <p><strong>Email:</strong> support@greenmart.vn</p>
        </div>

        <div class="footer-social">
            <a href="https://facebook.com/greenmart" target="_blank"><i class="fab fa-facebook-f"></i></a>
            <a href="https://instagram.com/greenmart" target="_blank"><i class="fab fa-instagram"></i></a>
            <a href="https://twitter.com/greenmart" target="_blank"><i class="fab fa-twitter"></i></a>
            <a href="https://tiktok.com/greenmart" target="_blank"><i class="fab fa-tiktok"></i></a>
        </div>

        <div class="footer-map">
            <h4>Tìm chúng tôi</h4>
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3919.447013320995!2d106.698755614623!3d10.776695992317!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31752f38d83b264b%3A0x6d3b7b8b76e6b8e6!2sHo%20Chi%20Minh%20City%2C%20Vietnam!5e0!3m2!1sen!2s!4v1635781234567!5m2!1sen!2s" loading="lazy" allowfullscreen></iframe>
        </div>

        <div class="footer-bottom">
            <p>© 2025 GreenMart - Cửa hàng hoa quả tươi sạch. All Rights Reserved.</p>
        </div>
    </div>
</footer>

</body>
</html>