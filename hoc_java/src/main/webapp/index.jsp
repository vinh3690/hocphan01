<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ page import="java.util.List" %>
<%@ page import="entity.*" %>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<fmt:setLocale value="vi_VN" />

<title>Vườn Cây Xanh - Mua Cây Cảnh Online</title>
<style>
/* Reset CSS */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    padding-top: 80px; /* Adjusted for fixed header */
}

/* Container for consistent width and centering */


/* Search Form */
.search-container {
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 15px 0;
    background-color: #fff;
    margin-bottom: 20px;
}

.search-form {
    width: 100%;
    max-width: 400px;
    display: flex;
    justify-content: center;
}

.input-group {
    display: flex;
    align-items: center;
    border: 1px solid #ccc;
    border-radius: 20px; /* Rounded corners */
    overflow: hidden;
    background-color: #fff;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.search-input {
    border: none;
    padding: 10px 15px;
    font-size: 14px;
    outline: none;
    flex-grow: 1;
    border-radius: 20px 0 0 20px;
    background: transparent;
}

.search-input::placeholder {
    color: #888;
}

.btn-orange {
    background-color: #ff6600;
    color: white;
    border: none;
    padding: 8px 15px;
    font-size: 14px;
    font-weight: 500;
    border-radius: 0 20px 20px 0;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.btn-orange:hover {
    background-color: #e65c00;
}

/* Category Section */
.category-section {
    padding: 40px 0;
    background-color: #f4f4f4;
}

.category-list {
    display: flex;
    justify-content: center;
    gap: 20px;
    overflow: hidden;
    position: relative;
    height: 120px;
}

.category-item {
    flex: 0 0 200px;
    display: none;
    align-items: center;
    justify-content: center;
    background-color: #2d6a4f;
    border-radius: 10px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    transition: all 0.3s ease-in-out;
    padding: 15px;
    text-align: center;
}

.category-item.active {
    display: flex;
    transform: scale(1.05);
}

.category-item.left {
    display: flex;
    opacity: 0.7;
    transform: translateX(-220px) scale(0.9);
}

.category-item.right {
    display: flex;
    opacity: 0.7;
    transform: translateX(220px) scale(0.9);
}

.category-content {
    color: white;
}

.category-content h3 {
    font-size: 18px;
    margin-bottom: 10px;
    text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.5);
}

.category-content .btn-orange {
    padding: 6px 12px;
    font-size: 13px;
    border-radius: 20px;
}

/* Category Navigation */
.category-nav {
    display: flex;
    justify-content: center;
    gap: 20px;
    margin-top: 20px;
}

.category-nav button {
    background-color: #3498db;
    color: white;
    border: none;
    padding: 10px 20px;
    font-size: 14px;
    border-radius: 25px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.category-nav button:hover {
    background-color: #2980b9;
}

.category-nav button:disabled {
    background-color: #bdc3c7;
    cursor: not-allowed;
    opacity: 0.6;
}

/* Hero Section */
.hero {
    position: relative;
    width: 100%;
    height: 500px;
    overflow: hidden;
}

.slider {
    position: relative;
    width: 100%;
    height: 100%;
}

.slide {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-size: cover;
    background-position: center;
    opacity: 0;
    transition: opacity 0.5s ease-in-out;
    filter: brightness(70%);
}

.slide.active {
    opacity: 1;
}

.hero-content {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    color: white;
    text-align: center;
    z-index: 1;
}

.hero-content h1 {
    font-size: 48px;
    margin-bottom: 20px;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
}

.hero-content p {
    font-size: 20px;
    margin-bottom: 30px;
    text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.3);
}

.btn {
    display: inline-block;
    padding: 15px 30px;
    background: linear-gradient(to right, #ffa600, #ff6600);
    color: white;
    text-decoration: none;
    font-weight: bold;
    border-radius: 30px;
    transition: all 0.3s ease;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
}

.btn:hover {
    background: linear-gradient(to right, #ff8800, #e65300);
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
}

/* Slider Navigation */
.slider-nav {
    position: absolute;
    top: 50%;
    width: 100%;
    display: flex;
    justify-content: space-between;
    transform: translateY(-50%);
    z-index: 2;
    padding: 0 20px;
}

.slider-nav button {
    background: rgba(0, 0, 0, 0.5);
    border: none;
    color: white;
    font-size: 18px;
    padding: 10px 20px;
    cursor: pointer;
    border-radius: 5px;
    transition: background 0.3s;
}

.slider-nav button:hover {
    background: rgba(0, 0, 0, 0.8);
}

/* Dots Navigation */
.dots {
    position: absolute;
    bottom: 20px;
    left: 50%;
    transform: translateX(-50%);
    display: flex;
    gap: 10px;
    z-index: 2;
}

.dot {
    width: 10px;
    height: 10px;
    background: rgba(255, 255, 255, 0.5);
    border-radius: 50%;
    cursor: pointer;
    transition: background 0.3s;
}

.dot.active {
    background: white;
}

/* Products Section */
.products {
    padding: 60px 0;
    background-color: #d3d3d3;
}

.products .container {
    text-align: center;
}

.products .section-title {
    font-size: 32px;
    color: #2d6a4f;
    margin-bottom: 40px;
}

.products .product-grid {
    display: flex;
    flex-wrap: nowrap;
    gap: 30px;
    margin: 0 auto;
    justify-content: center;
}

.product-item {
    display: none;
    flex-direction: column;
    align-items: center;
    text-align: center;
    width: 270px;
    padding: 20px;
    border: 1px solid #ddd;
    border-radius: 10px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    background-color: #fff;
    transition: opacity 0.3s ease, transform 0.3s ease;
    opacity: 0;
    transform: translateY(10px);
}

.product-item.show {
    display: flex;
    opacity: 1;
    transform: translateY(0);
}

.products .product-item:hover {
    transform: translateY(-10px);
}

.products .product-item img {
    width: 100%;
    height: 200px;
    object-fit: cover;
    border-radius: 10px;
}

.products .product-item h3 {
    margin: 15px 0;
    font-size: 18px;
}

.products .product-item p {
    font-size: 16px;
    color: #007a4d;
}

.products .product-item .btn {
    background-color: red;
    color: white;
    padding: 10px 20px;
    border-radius: 5px;
    text-decoration: none;
    font-weight: bold;
    transition: background-color 0.3s;
    display: inline-block;
    margin-top: 10px;
    font-size: 15px;
}

.products .product-item .btn:hover {
    background-color: #32cd32;
}

/* Pagination */
.pagination {
    display: flex;
    justify-content: center;
    gap: 20px;
    margin-top: 30px;
}

.pagination .btn {
    padding: 10px 24px;
    font-size: 16px;
    font-weight: 500;
    background-color: #3498db;
    color: white;
    border: none;
    border-radius: 25px;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    display: inline-block;
}

.pagination .btn:hover {
    background-color: #2980b9;
    transform: scale(1.05);
}

.pagination .btn:disabled {
    background-color: #bdc3c7;
    cursor: not-allowed;
    transform: none;
    opacity: 0.6;
}

/* Footer */
footer {
    background-color: #2d6a4f;
    color: white;
    padding: 20px 0;
    text-align: center;
}

/* Mini-cart */
#mini-cart {
    min-width: 320px;
    max-height: 400px;
    overflow-y: auto;
    background: #ffffff;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    padding: 15px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    font-family: 'Arial', sans-serif;
    z-index: 999;
    position: absolute;
    right: 10px;
    top: 50px;
    display: none;
}

.mini-cart-content {
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.mini-cart-item {
    display: flex;
    align-items: center;
    padding: 10px;
    background: #f9f9f9;
    border-radius: 6px;
    transition: background 0.2s ease;
}

.mini-cart-item:hover {
    background: #f1f1f1;
}

.mini-cart-item img {
    width: 50px;
    height: 50px;
    object-fit: cover;
    border-radius: 4px;
    margin-right: 12px;
}

.item-details {
    flex-grow: 1;
    font-size: 14px;
    color: #333;
}

.item-details .name {
    font-weight: 600;
    font-size: 15px;
    margin-bottom: 4px;
    color: #222;
}

.item-details .quantity-price {
    font-size: 13px;
    color: #666;
}

.remove-item {
    background: none;
    border: none;
    color: #888;
    font-size: 18px;
    cursor: pointer;
    padding: 5px;
    transition: color 0.2s ease;
}

.remove-item:hover {
    color: #ff4444;
}

.total {
    font-size: 16px;
    font-weight: 700;
    text-align: right;
    margin: 12px 0;
    color: #222;
}

.mini-cart-buttons {
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.view-cart-btn,
.checkout-btn {
    display: block;
    padding: 12px;
    text-align: center;
    color: #fff;
    text-decoration: none;
    font-weight: 600;
    font-size: 14px;
    border-radius: 6px;
    transition: background 0.2s ease;
}

.view-cart-btn {
    background-color: #28a745;
}

.view-cart-btn:hover {
    background-color: #218838;
}

.checkout-btn {
    background-color: #ff6200;
}

.checkout-btn:hover {
    background-color: #e55b00;
}

/* Responsive Design */
@media (max-width: 768px) {
    .products .product-grid {
        flex-wrap: wrap;
        justify-content: center;
    }
    .product-item {
        width: 200px;
        height: auto;
    }
    .products .product-item img {
        height: 160px;
    }
    header .container {
        flex-direction: column;
        align-items: flex-start;
    }
    header nav ul {
        flex-direction: column;
        align-items: flex-start;
    }
    header nav ul li {
        margin: 10px 0;
    }
    .search-container {
        padding: 10px 10px;
    }
    .search-form {
        max-width: 90%;
    }
    .search-input {
        padding: 8px 12px;
        font-size: 13px;
    }
    .btn-orange {
        padding: 6px 12px;
        font-size: 13px;
    }
    /* Category Responsive */
    .category-list {
        height: 100px;
    }
    .category-item {
        flex: 0 0 150px;
    }
    .category-item.left {
        transform: translateX(-170px) scale(0.85);
    }
    .category-item.right {
        transform: translateX(170px) scale(0.85);
    }
    .category-content h3 {
        font-size: 16px;
    }
    .category-content .btn-orange {
        padding: 5px 10px;
        font-size: 12px;
    }
}
</style>
</head>
<body>
<jsp:include page="Header.jsp" />

    <!-- Search Form (Centered with rounded corners) -->
    <div class="search-container">
        <form action="timKiemController" method="GET" class="search-form">
            <div class="input-group">
                <input type="text" name="query" class="search-input" placeholder="Tìm kiếm hoa quả..." aria-label="Tìm kiếm">
                <button type="submit" class="btn-orange">Tìm kiếm</button>
            </div>
        </form>
    </div>

    <!-- Hero Section -->
    <section class="hero" id="heroSection">
        <div class="slider">
            <div class="slide" style="background-image: url('images/banner.png');">
                <div class="hero-content">
                    <h1>Chào Mừng Đến Với Hoa Quả Tươi</h1>
                    <p>Trái cây ngon lành, bổ dưỡng cho sức khỏe.</p>
                    <a href="#products" class="btn">Khám Phá Ngay</a>
                </div>
            </div>
            <div class="slide" style="background-image: url('https://images.pexels.com/photos/1352243/pexels-photo-1352243.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2');">
                <div class="hero-content">
                    <h1>Hoa Quả Nhập Khẩu</h1>
                    <p>Chất lượng cao, giao hàng tận nơi.</p>
                    <a href="#products" class="btn">Khám Phá Ngay</a>
                </div>
            </div>
            <div class="slide" style="background-image: url('https://images.pexels.com/photos/61127/pexels-photo-61127.jpeg?auto=compress&cs=tinysrgb&w=1200&h=500&dpr=2');">
                <div class="hero-content">
                    <h1>Ưu Đãi Đặc Biệt</h1>
                    <p>Giảm giá hoa quả tươi mỗi ngày.</p>
                    <a href="#products" class="btn">Khám Phá Ngay</a>
                </div>
            </div>
        </div>
        <div class="slider-nav">
            <button id="prevSlideBtn">Previous</button>
            <button id="nextSlideBtn">Next</button>
        </div>
        <div class="dots"></div>
    </section>

    <!-- Category Section -->
    <section class="category-section">
        <div class="container">
            <h2 class="section-title">Danh Mục Sản Phẩm</h2>
            <div class="category-list">
                <c:forEach var="dm" items="${danhMuc}">
                    <div class="category-item">
                        <div class="category-content">
                            <h3>${dm.tenDanhMuc}</h3>
                            <a href="danhMucSanPhamController?Madanhmuc=${dm.id}" class="btn-orange">Xem ngay</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="category-nav">
                <button id="prevCategoryBtn">Previous</button>
                <button id="nextCategoryBtn">Next</button>
            </div>
        </div>
    </section>


<section id="products" class="products">
    <div class="container">
        <h2 class="section-title">Sản Phẩm Hoa Quả</h2>
        <div class="product-grid">
            <c:choose>
                <c:when test="${not empty sanPham}">
                    <c:forEach var="sp" items="${sanPham}">
    <div class="product-item">
        <a href="chiTietSanPham?id=${sp.id}">
            <img src="${pageContext.request.contextPath}/images/${sp.anh}" alt="${sp.tenSanPham}">
        </a>
        <h3>${sp.tenSanPham}</h3>
        <p>
            Giá:
            <fmt:formatNumber value="${sp.gia}" type="number" groupingUsed="true" />
            VNĐ
        </p>

        <c:choose>
            <c:when test="${sp.soLuong > 0}">
                <a href="javascript:void(0)" class="btn add-to-cart"
                   data-id="${sp.id}"
                   data-name="${sp.tenSanPham}"
                   data-price="${sp.gia}"
                   data-anh="${fn:escapeXml(sp.anh)}">
                    Thêm vào giỏ hàng
                </a>
            </c:when>
            <c:otherwise>
                <button class="btn disabled" disabled style="background-color: #ccc; cursor: not-allowed;">
                    Hết hàng
                </button>
            </c:otherwise>
        </c:choose>
    </div>
</c:forEach>

                </c:when>
                <c:otherwise>
                    <p>Không có sản phẩm nào.</p>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="pagination">
            <button id="prevBtn" class="btn">Previous</button>
            <button id="nextBtn" class="btn">Next</button>
        </div>
    </div>
</section>


    <section id="products1" class="products">
        <div class="container">
            <h2 class="section-title">Sản Phẩm Bán Chạy</h2>
            <div class="product-grid">
                <c:forEach var="sp" items="${sanPham1}">
    <div class="product-item">
        <a href="chiTietSanPham?id=${sp.id}">
            <img src="${pageContext.request.contextPath}/images/${sp.anh}" alt="${sp.tenSanPham}">
        </a>
        <h3>${sp.tenSanPham}</h3>
        <p>
            Giá:
            <fmt:formatNumber value="${sp.gia}" type="number" groupingUsed="true" />
            VNĐ
        </p>

        <c:choose>
            <c:when test="${sp.soLuong > 0}">
                <a href="javascript:void(0)" class="btn add-to-cart"
                   data-id="${sp.id}"
                   data-name="${sp.tenSanPham}"
                   data-price="${sp.gia}"
                   data-anh="${fn:escapeXml(sp.anh)}">
                    Thêm vào giỏ hàng
                </a>
            </c:when>
            <c:otherwise>
                <button class="btn disabled" disabled style="background-color: #ccc; cursor: not-allowed;">
                    Hết hàng
                </button>
            </c:otherwise>
        </c:choose>
    </div>
</c:forEach>

            </div>
            <div class="pagination">
                <button id="prevBtn1" class="btn">Previous</button>
                <button id="nextBtn1" class="btn">Next</button>
            </div>
        </div>
    </section>

 <jsp:include page="Footer.jsp" />

    <script>
        // Category Carousel Logic
        function setupCategoryCarousel() {
            const categoryItems = document.querySelectorAll('.category-item');
            const prevCategoryBtn = document.getElementById('prevCategoryBtn');
            const nextCategoryBtn = document.getElementById('nextCategoryBtn');
            let currentIndex = 0;

            function updateCarousel() {
                categoryItems.forEach((item, index) => {
                    item.classList.remove('active', 'left', 'right');
                    if (index === currentIndex) {
                        item.classList.add('active');
                    } else if (index === (currentIndex - 1 + categoryItems.length) % categoryItems.length) {
                        item.classList.add('left');
                    } else if (index === (currentIndex + 1) % categoryItems.length) {
                        item.classList.add('right');
                    }
                });

                prevCategoryBtn.disabled = false;
                nextCategoryBtn.disabled = false;
            }

            nextCategoryBtn.addEventListener('click', () => {
                currentIndex = (currentIndex + 1) % categoryItems.length;
                updateCarousel();
            });

            prevCategoryBtn.addEventListener('click', () => {
                currentIndex = (currentIndex - 1 + categoryItems.length) % categoryItems.length;
                updateCarousel();
            });

            updateCarousel();
        }

        // Slider and Product Pagination Logic
        function setupProductSlider(containerId, prevBtnId, nextBtnId, productsPerPage = 4) {
            const container = document.getElementById(containerId);
            const products = container.querySelectorAll('.product-item');
            const prevBtn = document.getElementById(prevBtnId);
            const nextBtn = document.getElementById(nextBtnId);
            let currentIndex = 0;

            prevBtn.style.display = 'inline-block';
            nextBtn.style.display = 'inline-block';

            function showProducts(index) {
                products.forEach(p => {
                    p.classList.remove('show');
                    p.style.display = 'none';
                });

                for (let i = index; i < index + productsPerPage && i < products.length; i++) {
                    products[i].style.display = 'flex';
                    setTimeout(() => products[i].classList.add('show'), 10);
                }

                prevBtn.disabled = index === 0;
                nextBtn.disabled = index + productsPerPage >= products.length;
            }

            nextBtn.addEventListener('click', () => {
                if (currentIndex + 1 < products.length) {
                    currentIndex += 1;
                    showProducts(currentIndex);
                }
            });

            prevBtn.addEventListener('click', () => {
                if (currentIndex > 0) {
                    currentIndex -= 1;
                    showProducts(currentIndex);
                }
            });

            showProducts(currentIndex);
        }

        document.addEventListener('DOMContentLoaded', () => {
            setupCategoryCarousel();
            setupProductSlider('products', 'prevBtn', 'nextBtn');
            setupProductSlider('products1', 'prevBtn1', 'nextBtn1');

            const slides = document.querySelectorAll('.hero .slide');
            const prevBtn = document.getElementById('prevSlideBtn');
            const nextBtn = document.getElementById('nextSlideBtn');
            const dotsContainer = document.querySelector('.dots');
            let currentSlide = 0;
            let slideInterval;

            slides.forEach((_, index) => {
                const dot = document.createElement('div');
                dot.classList.add('dot');
                dot.addEventListener('click', () => {
                    currentSlide = index;
                    showSlide(currentSlide);
                    resetInterval();
                });
                dotsContainer.appendChild(dot);
            });

            function updateDots() {
                document.querySelectorAll('.dot').forEach((dot, index) => {
                    dot.classList.toggle('active', index === currentSlide);
                });
            }

            function showSlide(index) {
                slides.forEach((slide, i) => {
                    slide.classList.toggle('active', i === index);
                });
                updateDots();
            }

            function nextSlide() {
                currentSlide = (currentSlide + 1) % slides.length;
                showSlide(currentSlide);
            }

            function prevSlide() {
                currentSlide = (currentSlide - 1 + slides.length) % slides.length;
                showSlide(currentSlide);
            }

            function startSlider() {
                slideInterval = setInterval(nextSlide, 4000);
            }

            function resetInterval() {
                clearInterval(slideInterval);
                startSlider();
            }

            prevBtn.addEventListener('click', () => {
                prevSlide();
                resetInterval();
            });

            nextBtn.addEventListener('click', () => {
                nextSlide();
                resetInterval();
            });

            document.querySelector('.hero').addEventListener('mouseenter', () => clearInterval(slideInterval));
            document.querySelector('.hero').addEventListener('mouseleave', startSlider);

            showSlide(currentSlide);
            startSlider();
        });

        $(document).ready(function() {
            $('.add-to-cart').click(function() {
                var id = $(this).data('id');
                var name = $(this).data('name');
                var price = $(this).data('price');
                var anh = $(this).data('anh');

                // AJAX gửi dữ liệu thêm vào giỏ hàng
                $.ajax({
                    url: 'gioHangController',
                    type: 'GET',
                    data: {
                        id: id,
                        name: name,
                        price: price,
                        anh: anh
                    },
                    success: function(response) {
                        var cartCount = response.cartCount;
                        $('.cart-count').text(cartCount); // Cập nhật số lượng sản phẩm
                    },
                    error: function(xhr, status, error) {
                        alert('Có lỗi xảy ra khi thêm vào giỏ hàng!');
                    }
                });
            });
        });
    </script>
</body>
</html>