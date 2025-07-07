<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Giới thiệu về GreenMart - Cửa hàng hoa quả sạch 4 mùa, cung cấp trái cây tươi ngon, an toàn và chất lượng cao quanh năm.">
    <meta name="keywords" content="GreenMart, hoa quả sạch, trái cây 4 mùa, thực phẩm sạch, trái cây nhập khẩu, cửa hàng trái cây">
    <meta name="author" content="GreenMart">
    <meta name="robots" content="index, follow">
    <title>Giới thiệu - GreenMart</title>
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

        /* About Section */
        .about-section {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            margin-bottom: 3rem;
            transition: transform 0.3s ease;
        }

        .about-section:hover {
            transform: translateY(-5px);
        }

        .about-section h1 {
            font-size: 2.5rem;
            color: #4CAF50;
            margin-bottom: 1.5rem;
            text-align: center;
        }

        .about-section p {
            font-size: 1.1rem;
            margin-bottom: 1rem;
            text-align: justify;
        }

        .about-section .highlight {
            color: #4CAF50;
            font-weight: 600;
        }

        /* Features Section */
        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .feature-item {
            background: white;
            padding: 1.5rem;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.3s ease;
        }

        .feature-item:hover {
            transform: translateY(-5px);
        }

        .feature-item i {
            color: #4CAF50;
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }

        .feature-item h3 {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 0.8rem;
        }

        .feature-item p {
            font-size: 1rem;
            color: #666;
        }

        /* Image Section */
        .image-section {
            margin-top: 3rem;
            text-align: center;
        }

        .image-section img {
            max-width: 100%;
            height: auto;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .about-section h1 {
                font-size: 2rem;
            }

            .about-section p {
                font-size: 1rem;
            }

            .features {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 1.5rem;
            }

            .about-section {
                padding: 1.5rem;
            }

            .feature-item {
                padding: 1rem;
            }
        }
    </style>
</head>
<body>
<jsp:include page="Header.jsp" />
    <div class="container" style="margin-top: 100px;">
        <div class="about-section">
            <h1>Giới thiệu về GreenMart</h1>
            <p>Chào mừng bạn đến với <span class="highlight">GreenMart</span> - điểm đến lý tưởng cho những ai yêu thích hoa quả sạch và tươi ngon quanh năm! Chúng tôi tự hào là cửa hàng cung cấp trái cây chất lượng cao, được chọn lọc kỹ lưỡng từ những nông trại uy tín trong nước và nhập khẩu từ các quốc gia nổi tiếng về nông sản.</p>
            <p>Tại GreenMart, sứ mệnh của chúng tôi là mang đến cho khách hàng những loại hoa quả <span class="highlight">tươi sạch 4 mùa</span>, đảm bảo an toàn, không hóa chất độc hại, và giữ trọn hương vị tự nhiên. Từ những trái táo giòn ngọt, xoài thơm lừng, đến các loại trái cây nhập khẩu cao cấp như cherry, nho mẫu đơn, hay kiwi vàng, chúng tôi cam kết mang đến sự tươi ngon và chất lượng vượt trội.</p>
            <p>Với đội ngũ nhân viên tận tâm và quy trình kiểm soát chất lượng nghiêm ngặt, GreenMart không chỉ là nơi mua sắm mà còn là nơi bạn có thể tin tưởng để chăm sóc sức khỏe gia đình qua những sản phẩm trái cây sạch, bổ dưỡng.</p>
        </div>

        <div class="features">
            <div class="feature-item">
                <i class="fas fa-leaf" aria-hidden="true"></i>
                <h3>Hoa quả sạch</h3>
                <p>100% trái cây tươi sạch, không chất bảo quản, đạt tiêu chuẩn an toàn thực phẩm.</p>
            </div>
            <div class="feature-item">
                <i class="fas fa-globe" aria-hidden="true"></i>
                <h3>Đa dạng 4 mùa</h3>
                <p>Cung cấp trái cây quanh năm với nguồn cung từ trong nước và nhập khẩu.</p>
            </div>
            <div class="feature-item">
                <i class="fas fa-truck" aria-hidden="true"></i>
                <h3>Giao hàng nhanh</h3>
                <p>Dịch vụ giao hàng tận nơi, đảm bảo trái cây tươi ngon đến tay bạn.</p>
            </div>
            <div class="feature-item">
                <i class="fas fa-heart" aria-hidden="true"></i>
                <h3>Chăm sóc khách hàng</h3>
                <p>Hỗ trợ tận tình, đổi trả dễ dàng, đặt sự hài lòng của bạn lên hàng đầu.</p>
            </div>
        </div>

        <div class="image-section">
            <img src="https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1300&q=80" alt="Hoa quả tươi sạch tại GreenMart" loading="lazy">
        </div>
    </div>
</body>
</html>