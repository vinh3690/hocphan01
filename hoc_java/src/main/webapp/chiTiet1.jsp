<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="entity.*"%>
<%@ page import="java.util.List" %>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Tùng La Hán - Green Mona</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

body {
	background-color: #f5f5f5;
}

.container {
	display: flex;
	padding: 40px;
	max-width: 1200px;
	margin: auto;
}

.sidebar {
	width: 25%;
	background: white;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
}

.sidebar h3 {
	margin-bottom: 20px;
	font-size: 18px;
	border-bottom: 2px solid #a4cf31;
	padding-bottom: 8px;
}

.sidebar ul {
	list-style: none;
}

.sidebar li {
	display: flex;
	align-items: center;
	gap: 10px;
	margin-bottom: 15px;
	border-bottom: 1px solid #eee;
	padding-bottom: 10px;
	transition: all 0.3s ease;
}

.sidebar li:hover {
	background: #f0f9e9;
	border-radius: 6px;
	padding: 10px;
}

.sidebar img {
	width: 60px;
	height: 60px;
	border-radius: 6px;
	object-fit: cover;
}

.main-content {
	width: 75%;
	padding-left: 40px;
}

.main-content img {
	width: 100%;
	max-width: 500px;
	border-radius: 12px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.product-title {
	font-size: 30px;
	font-weight: bold;
	margin: 25px 0 10px;
	color: #333;
}

.price {
	font-size: 24px;
	color: #ff6600;
	margin-bottom: 20px;
}

.quantity {
	display: flex;
	align-items: center;
	gap: 10px;
	margin-bottom: 20px;
	font-size: 16px;
	color: #444;
}

.quantity label {
	white-space: nowrap;
}

.quantity-box {
	display: flex;
	align-items: center;
	gap: 5px;
}

.qty-btn {
	width: 32px;
	height: 32px;
	background: #a4cf31;
	color: white;
	font-size: 20px;
	font-weight: bold;
	border: none;
	border-radius: 6px;
	cursor: pointer;
	transition: background 0.3s ease;
	display: flex;
	align-items: center;
	justify-content: center;
}

.qty-btn:hover {
	background: #8ab222;
}

#quantityInput {
	width: 50px;
	height: 32px;
	text-align: center;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 6px;
}

.add-to-cart {
	background: linear-gradient(to right, #ffa600, #ff6600);
	color: white;
	border: none;
	padding: 12px 30px;
	font-size: 16px;
	font-weight: bold;
	border-radius: 30px;
	cursor: pointer;
	transition: all 0.3s ease;
	box-shadow: 0 6px 10px rgba(255, 102, 0, 0.2);
}

.add-to-cart:hover {
	background: linear-gradient(to right, #ff8800, #e65300);
	box-shadow: 0 8px 16px rgba(255, 102, 0, 0.3);
}

.price-inline {
	font-weight: bold;
	white-space: nowrap;
	color: #000;
}

.similar-products {
	margin: 40px auto;
	max-width: 1200px;
	padding: 0 40px;
}

.similar-products h3 {
	font-size: 20px;
	margin-bottom: 20px;
	border-bottom: 2px solid #a4cf31;
	padding-bottom: 8px;
}

.similar-products-container {
	width: 100%;
}

.similar-products-list {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 20px;
}

.similar-product-item {
	padding: 10px;
	box-sizing: border-box;
	background: white;
	border-radius: 6px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
	transition: transform 0.3s ease;
}

.similar-product-item:hover {
	transform: translateY(-5px);
}

.similar-product-item img {
	width: 100%;
	height: 150px;
	object-fit: cover;
	border-radius: 6px;
}

.similar-product-item .item-info {
	margin-top: 10px;
	text-align: center;
}

.similar-product-item .item-info div {
	font-size: 14px;
	color: #333;
	margin-bottom: 5px;
}

.similar-product-item .price-inline {
	font-size: 14px;
	color: #ff6600;
}

.search-container {
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 15px 0;
	background-color: #fff;
	margin-top: 60px;
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
	border-radius: 20px;
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

.add-to-cart {
	font-size: 14px;
	padding: 6px 12px;
	background-color: #28a745;
	color: white;
	border: none;
	border-radius: 4px;
	text-decoration: none;
	display: inline-block;
	transition: background-color 0.3s;
}

.add-to-cart:hover {
	background-color: #218838;
	text-decoration: none;
}

.review-section {
	margin: 40px auto;
	max-width: 1200px;
	padding: 0 40px;
}

.review-section h3 {
	font-size: 20px;
	margin-bottom: 20px;
	border-bottom: 2px solid #a4cf31;
	padding-bottom: 8px;
}

.review-form {
	background: white;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
	margin-bottom: 30px;
}

.review-form .star-rating {
  display: flex;
  flex-direction: row-reverse;
  gap: 5px;
}

.review-form .star-rating input {
  display: none;
}

.review-form .star-rating label {
  font-size: 24px;
  color: #ccc;
  cursor: pointer;
  transition: color 0.3s ease;
}

/* Chỉ đổi màu label có for trùng với input checked */
.review-form .star-rating input:checked + label,
.review-form .star-rating input:checked + label ~ label {
  color: #ffcc00;
}

.review-form .star-rating label:hover,
.review-form .star-rating label:hover ~ label {
  color: #ffcc00;
}


.review-form textarea {
	width: 100%;
	height: 100px;
	border: 1px solid #ccc;
	border-radius: 6px;
	padding: 10px;
	font-size: 14px;
	margin-bottom: 15px;
	resize: vertical;
}

.review-form button {
	background: #a4cf31;
	color: white;
	border: none;
	padding: 10px 20px;
	font-size: 14px;
	font-weight: bold;
	border-radius: 6px;
	cursor: pointer;
	transition: background 0.3s ease;
}

.review-form button:hover {
	background: #8ab222;
}

.review-list {
	display: flex;
	flex-direction: column;
	gap: 20px;
}

.review-item {
	background: white;
	padding: 15px;
	border-radius: 6px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
}

.review-item .review-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 10px;
}

.review-item .review-header .reviewer {
	font-weight: bold;
	color: #333;
}

.review-item .review-header .review-date {
	font-size: 12px;
	color: #888;
}

.review-item .review-rating {
	color: #ffcc00;
	margin-bottom: 10px;
}

.review-item .review-comment {
	color: #444;
	font-size: 14px;
	line-height: 1.6;
}

.save-review-btn {
	background: #28a745; /* Màu xanh cho OK */
	color: white;
	border: none;
	padding: 5px 10px;
	border-radius: 4px;
	cursor: pointer;
}

.cancel-review-btn {
	background: #6c757d; /* Màu xám cho Cancel */
	color: white;
	border: none;
	padding: 5px 10px;
	border-radius: 4px;
	cursor: pointer;
}

.notification {
	color: white;
	padding: 10px 20px;
	border-radius: 6px;
	margin-bottom: 20px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.notification-success {
	background: #28a745; /* Màu xanh cho thành công */
}

.notification-error {
	background: #ff4444; /* Màu đỏ cho lỗi */
}

.notification .close-btn {
	background: none;
	border: none;
	color: white;
	font-size: 16px;
	cursor: pointer;
	padding: 0 10px;
}

.notification .close-btn:hover {
	color: #ddd;
}
</style>
</head>
<body>
	<jsp:include page="Header.jsp" />

	<div class="search-container">
		<form action="timKiemController" method="GET" class="search-form">
			<div class="input-group">
				<input type="text" name="query" class="search-input"
					placeholder="Tìm kiếm hoa quả..." aria-label="Tìm kiếm">
				<button type="submit" class="btn-orange">Tìm kiếm</button>
			</div>
		</form>
	</div>

	<div class="container">
		<div class="sidebar">
			<h3>SẢN PHẨM</h3>
			<ul>
				<c:forEach var="product" items="${rd}">
					<li><img src="images/${product.anh}">
						<div class="item-info">
							<div>${product.tenSanPham}</div>
							<p>
            Giá:
            <fmt:formatNumber value="${product.gia}" type="number" groupingUsed="true" />
            VNĐ
        </p>
							

						</div></li>
				</c:forEach>
			</ul>
		</div>


		<div class="main-content">
    <div style="display: flex; gap: 40px; align-items: flex-start;">
        <img src="${pageContext.request.contextPath}/images/${ct.anh}"
             alt="${ct.tenSanPham}"
             style="width: 500px; height: 300px; object-fit: cover; border-radius: 10px;">
        <div>
            <div class="product-title">${ct.tenSanPham}</div>
            <div class="price">
                <fmt:formatNumber value="${ct.gia}" type="number" groupingUsed="true" /> ₫
            </div>

            <c:choose>
                <c:when test="${ct.soLuong > 0}">
                    <div class="quantity">
                      
                        <div class="quantity-box">
                            <button type="button" class="qty-btn" onclick="changeQty(-1)">-</button>
                            <input type="text" id="quantityInput" value="1" readonly>
                            <button type="button" class="qty-btn" onclick="changeQty(1)">+</button>
                        </div>
                    </div>
                    <a href="javascript:void(0)" class="btn add-to-cart"
						data-id="${ct.id}" data-name="${ct.tenSanPham}"
						data-price="${ct.gia}" data-anh="${ct.anh}"> Thêm vào giỏ hàng
					</a>
                </c:when>
                <c:otherwise>
                    <p style="color: red; font-weight: bold;">Sản phẩm đã hết hàng</p>
                    <button class="btn disabled" disabled style="background-color: #ccc; cursor: not-allowed;">
                        Không thể thêm vào giỏ
                    </button>
                </c:otherwise>
            </c:choose>

            <div style="margin-top: 30px; color: #444; line-height: 1.6;">
                <p><strong>${ct.tenSanPham}</strong></p>
                <p>${ct.moTa}</p>
            </div>
        </div>
    </div>
</div>

	</div>

	<div class="similar-products">
		<h3>SẢN PHẨM TƯƠNG TỰ</h3>
		<div class="similar-products-container">
			<div class="similar-products-list" id="similarProductsList">
				<c:forEach var="product" items="${rd1}">
					<div class="similar-product-item">
						<a href="chiTietSanPham?id=${product.id}">
                                <img src="${pageContext.request.contextPath}/images/${product.anh}" alt="${product.tenSanPham}">
                            </a>
						<div class="item-info">
							<div>${product.tenSanPham}</div>
							<p>
            Giá:
            <fmt:formatNumber value="${product.gia}" type="number" groupingUsed="true" />
            VNĐ
        </p>
							
							<p></p>
							<a href="javascript:void(0)" class="btn add-to-cart"
								data-id="${product.id}"
								data-name="${fn:escapeXml(product.tenSanPham)}"
								data-price="${product.gia}"
								data-anh="${fn:escapeXml(product.anh)}"> Thêm vào giỏ hàng </a>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>

	<div class="review-section">
		<h3>ĐÁNH GIÁ SẢN PHẨM</h3>
		<c:if test="${not empty tt}">
			<div
				class="notification ${status == 'success' ? 'notification-success' : 'notification-error'}">
				<span>${fn:escapeXml(tt)}</span>
				<button class="close-btn"
					onclick="this.parentElement.style.display='none'">×</button>
			</div>
		</c:if>
		<div class="review-form">
			<form id="reviewForm" action="DanhGiaController" method="POST">
				<div class="star-rating">
  <input type="radio" name="rating" id="star5" value="5" required>
  <label for="star5">★</label>
  
  <input type="radio" name="rating" id="star4" value="4">
  <label for="star4">★</label>
  
  <input type="radio" name="rating" id="star3" value="3">
  <label for="star3">★</label>
  
  <input type="radio" name="rating" id="star2" value="2">
  <label for="star2">★</label>
  
  <input type="radio" name="rating" id="star1" value="1">
  <label for="star1">★</label>
</div>

				<textarea id="comment" name="comment" placeholder="Viết đánh giá của bạn..." required></textarea>

				<input type="hidden" id="sanPhamId" name="productId"
					value="${ct.id}"> <input type="hidden" name="userId"
					value="${sessionScope.user.getId()}">
				<button id="submitReviewBtn" type="submit">Gửi đánh giá</button>
				<input type="hidden" id="action" name="action" value="">
				<div id="editActionButtons" style="display: none; margin-top: 10px;">
					<button type="button" id="saveReviewBtn" class="btn">OK</button>
					<button type="button" id="cancelReviewBtn" class="btn">Cancel</button>
				</div>
			</form>
		</div>
		<div class="review-list" id="reviewList">
			<c:forEach var="review" items="${dh}">
				<div class="review-item" data-review-id="${review.id}">
					<div class="review-header">
					<c:choose>
    <c:when test="${sessionScope.user.id == review.nguoiDungId}">
        <span class="reviewer" style="font-weight: bold; color: #2b8a3e;">
            ${fn:escapeXml(review.nguoiDung.hoTen)} (Tôi)
        </span>
    </c:when>
    <c:otherwise>
        <span class="reviewer">${fn:escapeXml(review.nguoiDung.hoTen)}</span>
    </c:otherwise>
</c:choose>

						<span class="review-date"> <fmt:formatDate
								value="${review.ngayDanhGia}" pattern="dd/MM/yyyy HH:mm" />
						</span>
					</div>
					<div class="review-rating">
						<c:forEach begin="1" end="${review.diem}">★</c:forEach>
						<c:forEach begin="${review.diem + 1}" end="5">☆</c:forEach>
					</div>
					<div class="review-comment">${fn:escapeXml(review.binhLuan)}</div>
					<c:if
						test="${not empty sessionScope.user and sessionScope.user.id == review.nguoiDungId}">
						<div class="review-actions" style="margin-top: 10px;">
							<button 
    class="edit-review-btn" 
    data-review-id="${review.id}" 
    data-binhluan="${fn:escapeXml(review.binhLuan)}" 
    data-diem="${review.diem}"
    style="background: #a4cf31; color: white; border: none; padding: 5px 10px; border-radius: 4px; cursor: pointer; margin-right: 5px;">
    Sửa
</button>

							<button class="delete-review-btn" data-review-id="${review.id}"
								style="background: #ff4444; color: white; border: none; padding: 5px 10px; border-radius: 4px; cursor: pointer;">Xóa</button>
							<div class="edit-actions" style="display: none;">
								<button class="save-review-btn" data-review-id="${review.id}"
									style="background: #28a745; color: white; border: none; padding: 5px 10px; border-radius: 4px; cursor: pointer; margin-right: 5px;">OK</button>
								<button class="cancel-review-btn" data-review-id="${review.id}"
									style="background: #6c757d; color: white; border: none; padding: 5px 10px; border-radius: 4px; cursor: pointer;">Cancel</button>
							</div>
						</div>
					</c:if>
				</div>
			</c:forEach>
		</div>
	</div>
<jsp:include page="Footer.jsp" />
	<script>
	let maxQty = ${ct.soLuong}; // số lượng tồn từ server

	function changeQty(change) {
		let input = document.getElementById("quantityInput");
		let current = parseInt(input.value);

		if (!isNaN(current)) {
			let newQty = current + change;

			if (newQty < 1) {
				newQty = 1;
			} else if (newQty > maxQty) {
				alert("Số lượng bạn chọn vượt quá số lượng trong kho (" + maxQty + ")");
				newQty = maxQty;
			}

			input.value = newQty;
		}
	}
		$(document).ready(function() {
			$('.add-to-cart').click(function() {
				var id = $(this).data('id');
				var name = $(this).data('name');
				var price = $(this).data('price');
				var anh = $(this).data('anh');
				var quantity = parseInt($('#quantityInput').val()) || 1;
				if(quantity>maxQty){
					alert("Không thể thêm quá số lượng hiện có!");
		            return;
				}		
				$.ajax({
					url : 'gioHangController',
					type : 'GET',
					data : {
						id : id,
						name : name,
						price : price,
						anh : anh,
						quantity : quantity
					},
					success : function(response) {
						if (response.cartCount !== undefined) {
							$('.cart-count').text(response.cartCount);
						}
						$('#quantityInput').val(1);
					},
					error : function() {
						alert('Có lỗi xảy ra khi thêm vào giỏ hàng!');
					}
				});
			});
		});

		$(document).on(
				'click',
				'.star-rating input',
				function() {
					console.log('Star clicked, value:', this.value);
					$('.star-rating label').css('color', '#ccc');
					$(this).next('label').nextAll('label').addBack().css(
							'color', '#ffcc00');
					$(this).prop('checked', true);
				});

		$(document).on('mouseenter', '.star-rating label', function() {
			$(this).nextAll('label').addBack().css('color', '#ffcc00');
		}).on(
				'mouseleave',
				'.star-rating label',
				function() {
					$('.star-rating label').css('color', '#ccc');
					$('.star-rating input:checked').next('label').nextAll(
							'label').addBack().css('color', '#ffcc00');
				});
		$(document)
				.ready(
						function() {
							// Bắt sự kiện khi nút "Xóa" được nhấn
							$(document)
									.on(
											'click',
											'.delete-review-btn',
											function() {
												var $button = $(this); // Lưu tham chiếu đến nút được nhấn
												var reviewId = $button
														.data('review-id'); // Lấy ID của đánh giá

												// Xác nhận người dùng có muốn xóa không
												if (confirm('Bạn có chắc chắn muốn xóa đánh giá này?')) {
													$
															.ajax({
																url : 'quanLiDanhGia', // Đường dẫn đến servlet xử lý xóa
																type : 'POST',
																data : {
																	reviewId : reviewId
																}, // Gửi ID của đánh giá
																dataType : 'json', // Mong đợi phản hồi dạng JSON
																success : function(
																		response) {
																	if (response.success) {
																		alert('Đánh giá đã được xóa!');
																		console
																				.log('Nút Xóa được nhấn');
																		// Tìm phần tử cha có class .review-item và xóa
																		var reviewElement = $button
																				.closest('.review-item');
																		console
																				.log(reviewElement); // Kiểm tra phần tử
																		if (reviewElement.length) {
																			reviewElement
																					.remove(); // Xóa phần tử khỏi DOM
																		} else {
																			console
																					.error('Không tìm thấy phần tử .review-item');
																		}
																	} else {
																		alert('Lỗi: '
																				+ (response.message || 'Xóa thất bại'));
																	}
																},
																error : function(
																		xhr,
																		status,
																		error) {
																	console
																			.error(
																					'Lỗi AJAX:',
																					status,
																					error);
																	alert('Có lỗi xảy ra, không thể xóa đánh giá: '
																			+ error);
																}
															});
												}
											});
						});
			document.addEventListener('DOMContentLoaded', function () {
			    const commentInput = document.getElementById('comment');
			    const ratingInputs = document.querySelectorAll('input[name="rating"]');
			    const submitBtn = document.getElementById('submitReviewBtn');
			    const editActions = document.getElementById('editActionButtons');
			    const saveBtn = document.getElementById('saveReviewBtn');
			    const cancelBtn = document.getElementById('cancelReviewBtn');
			    let editingReviewId = null;
	
			    // Bắt sự kiện nút "Sửa"
			    document.querySelectorAll('.edit-review-btn').forEach(btn => {
			        btn.addEventListener('click', function () {
			            editingReviewId = this.dataset.reviewId;
			            const binhluan = this.dataset.binhluan;
			            const diem = parseInt(this.dataset.diem);
	
			            commentInput.value = binhluan;
	
			            // Chọn đúng rating
			            ratingInputs.forEach(radio => {
			                radio.checked = parseInt(radio.value) === diem;
			            });
	
			            // Ẩn nút submit, hiện OK/Cancel
			            submitBtn.style.display = 'none';
			            editActions.style.display = 'block';
	
			            // Gắn review ID vào button OK
			            saveBtn.setAttribute('data-review-id', editingReviewId);
			        });
			    });
	
			    // Bắt sự kiện nút "Cancel"
			    cancelBtn.addEventListener('click', function () {
			        editingReviewId = null;
			        commentInput.value = '';
			        ratingInputs.forEach(r => r.checked = false);
			        submitBtn.style.display = 'inline-block';
			        editActions.style.display = 'none';
			    });
	
			    // Bắt sự kiện nút "OK"
			    saveBtn.addEventListener('click', function () {
			        const reviewId = this.getAttribute('data-review-id');
			        const comment = commentInput.value;
			        const rating = [...ratingInputs].find(r => r.checked)?.value;
	
			        if (!comment || !rating) {
			            alert("Vui lòng nhập đầy đủ đánh giá và sao.");
			            return;
			        }
	
			        console.log("Sửa đánh giá:", {
			            id: reviewId,
			            binhluan: comment,
			            diem: rating
			        });
	
			        // TODO: Gửi request đến servlet xử lý cập nhật (nếu cần)
			        // Sau khi thành công có thể reload trang hoặc cập nhật giao diện
	
			        // Reset lại
			        editingReviewId = null;
			        submitBtn.style.display = 'inline-block';
			        editActions.style.display = 'none';
			        commentInput.value = '';
			        ratingInputs.forEach(r => r.checked = false);
			    });
			});
			document.getElementById('saveReviewBtn').addEventListener('click', function() {
		        // Set action to 'edit'
		        document.getElementById('action').value = 'edit';
		        // Submit the form
		        document.getElementById('reviewForm').submit();
		    });

	</script>
</body>
</html>