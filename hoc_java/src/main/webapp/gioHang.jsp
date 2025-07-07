<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ Hàng</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .container {
        	
            padding: 20px;
        }
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .table {
            border-radius: 8px;
            overflow: hidden;
        }
        .table th {
            background-color: #007bff;
            color: white;
        }
        .btn-primary, .btn-danger, .btn-success {
            border-radius: 5px;
            transition: background 0.3s;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-danger:hover {
            background-color: #c82333;
        }
        .btn-success:hover {
            background-color: #218838;
        }
        .total-section {
            font-size: 1.2rem;
            font-weight: bold;
        }
        .input-quantity {
            width: 80px;
            text-align: center;
        }
        .product-img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 5px;
        }
        @media (max-width: 576px) {
            .table-responsive {
                font-size: 0.9rem;
            }
            .input-quantity {
                width: 60px;
            }
            .product-img {
                width: 60px;
                height: 60px;
            }
        }
    </style>
</head>
<body>

<div class="container" style="margin-top: 100px;">
    <h1 class="mb-4">Giỏ Hàng Của Bạn</h1>

    <div class="card p-4">
        <!-- Lấy giỏ hàng từ session -->
        <c:set var="cartItems" value="${sessionScope.cart}" />

        <!-- Kiểm tra nếu giỏ hàng rỗng -->
        <c:if test="${empty cartItems}">
            <div class="alert alert-info">Giỏ hàng của bạn đang trống. <a href="sanPhamController" class="alert-link">Tiếp tục mua sắm</a>.</div>
        </c:if>

        <!-- Nếu giỏ hàng có sản phẩm -->
        <c:if test="${not empty cartItems}">
            <!-- Tính tổng tiền -->
            <c:set var="totalAmount" value="0" />
            <c:forEach var="item" items="${cartItems}">
                <c:set var="totalAmount" value="${totalAmount + item.gia * item.soLuong}" />
            </c:forEach>

            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Ảnh</th>
                            <th>Sản Phẩm</th>
                            <th>Giá</th>
                            <th>Số Lượng</th>
                            <th>Tổng</th>
                            <th>Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${cartItems}">
                            <tr data-price="${item.gia}">
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty item.anh}">
                                            <img src="images/${item.anh}" alt="${item.tenSanPham}" class="product-img">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="images/default-product.jpg" alt="Sản phẩm mặc định" class="product-img">
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${item.tenSanPham}</td>
                                <td>
                                    <fmt:setLocale value="vi_VN"/>
                                    <fmt:formatNumber value="${item.gia}" type="currency" currencySymbol="₫"/>
                                </td>
                                <td>
                                    <!-- Quantity Adjustment -->
                                    <div class="quantity-control d-flex align-items-center">
                                        <!-- Decrease Quantity -->
                                        <button class="btn btn-secondary btn-sm decrease-quantity" 
                                                data-product-id="${item.id}" 
                                                data-quantity="${item.soLuong - 1}" 
                                                ${item.soLuong <= 1 ? 'disabled' : ''}>
                                            <i class="fas fa-minus"></i>
                                        </button>
                                        
                                        <!-- Current Quantity -->
                                        <input type="number" 
                                               class="form-control form-control-sm d-inline quantity-input" 
                                               style="width: 60px;" 
                                               value="${item.soLuong}" 
                                               min="1" 
                                               data-product-id="${item.id}" />
                                        
                                       <!-- Increase Quantity -->
                                        <button class="btn btn-secondary btn-sm increase-quantity" 
                                                data-product-id="${item.id}" 
                                                data-quantity="${item.soLuong + 1}">
                                            <i class="fas fa-plus"></i>
                                        </button>
                                    </div>
                                </td>
                                <td class="price-total">
                                    <fmt:setLocale value="vi_VN"/>
                                    <fmt:formatNumber value="${item.gia * item.soLuong}" type="currency" currencySymbol="₫"/>
                                </td>
                                <td>
                                    <!-- Remove Item -->
                                    <button class="btn btn-danger btn-sm remove-item" 
                                            data-product-id="${item.id}">
                                        <i class="fas fa-trash"></i> Xóa
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="mt-4 total-section">
                <p>Tổng tiền: <span class="text-primary total-amount">
                    <fmt:setLocale value="vi_VN"/>
                    <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="₫"/>
                </span></p>
            </div>

            <form action="ThanhToanController" method="post">
                <!-- Thêm trường hidden để gửi giá trị totalAmount -->
                <input type="hidden" name="totalAmount" value="${totalAmount}" />
                <div class="d-flex justify-content-between mt-4">
                    <a href="sanPhamController" class="btn btn-primary"><i class="fas fa-arrow-left me-2"></i> Tiếp Tục Mua Sắm</a>
                    <button type="submit" class="btn btn-success"><i class="fas fa-check me-2"></i> Thanh Toán</button>
                </div>
            </form>
        </c:if>
    </div>
</div>
<jsp:include page="Footer.jsp" />
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Bootstrap 5 JS and Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Custom Script -->
<script>
$(document).ready(function () {
    // Handle Increase/Decrease buttons
    $('.decrease-quantity, .increase-quantity').click(function (e) {
        e.preventDefault();
        var productId = $(this).data('product-id');

        // Tìm input trong cùng hàng
        var row = $(this).closest('tr');
        var input = row.find('.quantity-input');
        var currentQuantity = parseInt(input.val());

        // Xác định hành động
        if ($(this).hasClass('decrease-quantity')) {
            if (currentQuantity > 1) {
                currentQuantity -= 1;
            }
        } else {
            currentQuantity += 1;
        }

        // Cập nhật số lượng trong input (UI)
        input.val(currentQuantity);

        // Gửi AJAX cập nhật
        updateQuantity(productId, currentQuantity, row);
    });
    $('.quantity-input').change(function () {
        var productId = $(this).data('product-id');
        var newQuantity = parseInt($(this).val());
        if (isNaN(newQuantity) || newQuantity < 1) {
            newQuantity = 1;
            $(this).val(1);
        }

        updateQuantity(productId, newQuantity, $(this).closest('tr'));
    });
    // Handle Remove Item
    $('.remove-item').click(function(e) {
        e.preventDefault();
        var productId = $(this).data('product-id');
        var $row = $(this).closest('tr');
        
        $.ajax({
            url: 'QuanLiGioHang',
            type: 'POST',
            data: {
                action: 'remove',
                productId: productId
            },
            success: function(response) {
                // Remove the row from the table
                $row.remove();
                // Update total cart price
                updateCartTotal();
            },
            error: function(xhr, status, error) {
                alert('Lỗi khi xóa sản phẩm: ' + error);
            }
        });
    });

    // Function to Update Quantity
    function updateQuantity(productId, newQuantity, $row) {
        $.ajax({
            url: 'QuanLiGioHang',
            type: 'POST',
            data: {
                action: 'updateQuantity',
                productId: productId,
                quantity: newQuantity
            },
            success: function(response) {
                // Update quantity input
                $row.find('.quantity-input').val(newQuantity);
                
                // Update decrease button state
                if (newQuantity <= 1) {
                    $row.find('.decrease-quantity').prop('disabled', true);
                } else {
                    $row.find('.decrease-quantity').prop('disabled', false);
                }
                
                // Update price total for the row
                var pricePerItem = parseFloat($row.data('price'));
                var newTotal = pricePerItem * newQuantity;
                $row.find('.price-total').html(new Intl.NumberFormat('vi-VN', {
                    style: 'currency',
                    currency: 'VND'
                }).format(newTotal));
                
                // Update total cart price
                updateCartTotal();
            },
            error: function(xhr, status, error) {
                alert('Lỗi khi cập nhật số lượng: ' + error);
            }
        });
    }

    // Function to Update Total Cart Price
    function updateCartTotal() {
        var total = 0;
        $('.price-total').each(function() {
            var priceText = $(this).text().replace('₫', '').replace(/\./g, '');
            total += parseInt(priceText) || 0; // Handle potential NaN
        });
        // Update total price element
        $('.total-amount').text(new Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND'
        }).format(total));
    }
});
</script>
</body>
</html>