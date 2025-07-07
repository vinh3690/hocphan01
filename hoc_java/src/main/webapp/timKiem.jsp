<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="java.util.List"%>
<%@ page import="entity.SanPham"%>
<fmt:setLocale value="vi_VN" />

<!DOCTYPE html>
<html lang="vi">
<head>
<!-- Thêm jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<meta charset="UTF-8">
<title>Green Mona - Cây Cảnh Văn Phòng</title>
<link rel="stylesheet" href="TimKiem2.css">
<style>
.price-filter {
	padding: 10px;
}

.price-filter label {
	font-weight: bold;
	margin-right: 10px;
}

.price-filter input[type="number"] {
	width: 120px;
	padding: 5px;
	margin-right: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.btn-filter {
	background-color: #333;
	color: white;
	border: none;
	padding: 8px 16px;
	cursor: pointer;
	border-radius: 5px;
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
	<!-- Main content -->
	<main class="main-container">
		<!-- Left sidebar -->
		<aside class="sidebar">
			<div class="card shadow-sm border-0 rounded-3">
				<div
					class="card-header bg-gradient bg-primary text-white rounded-top-3">
					<h5 class="mb-0 text-center">Danh Mục Sản Phẩm</h5>
				</div>
				<ul class="list-group list-group-flush">
					<c:forEach var="dm" items="${dm}">
						<li class="list-group-item list-group-item-action category-item">
							<a href="danhMucSanPhamController?Madanhmuc=${dm.id}"
							class="text-decoration-none text-dark d-block">
								${dm.tenDanhMuc} </a>
						</li>
					</c:forEach>
				</ul>
			</div>

			<!-- Price Filter Form -->
			<div class="card shadow-sm border-0 rounded-3 mt-3">
				<div
					class="card-header bg-gradient bg-primary text-white rounded-top-3">
					<h5 class="mb-0 text-center">Lọc Theo Giá</h5>
				</div>
				<div class="card-body price-filter">
					<form action="LocController" method="Post">
						<input type="hidden" name="query" value="${param.query}" /> <label
							for="minPrice">Từ:</label> <input type="number" id="minPrice"
							name="minPrice" min="0" step="1000"> <label
							for="maxPrice">Đến:</label> <input type="number" id="maxPrice"
							name="maxPrice" min="0" step="1000">

						<button type="submit" class="btn-filter">Lọc</button>
					</form>

				</div>
			</div>
		</aside>

		<!-- Product list -->
		<section class="products">
			<c:choose>
				<c:when test="${empty sp}">
					<p>Không có sản phẩm.</p>
				</c:when>
				<c:otherwise>
					<c:forEach var="p" items="${sp}">
						<div class="product-card">
							<a href="chiTietSanPham?id=${p.id}"> <img
								src="${pageContext.request.contextPath}/images/${p.anh}"
								alt="${p.tenSanPham}">
							</a>
							<h4>${p.tenSanPham}</h4>
							<p>
								Giá:
								<fmt:formatNumber value="${p.gia}" type="number"
									groupingUsed="true" />
								VNĐ
							</p>
							<a href="javascript:void(0)" class="btn add-to-cart"
								data-id="${p.id}" data-name="${fn:escapeXml(p.tenSanPham)}"
								data-price="${p.gia}" data-anh="${fn:escapeXml(p.anh)}">
								Thêm vào giỏ hàng </a>
						</div>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</section>
	</main>
	<jsp:include page="Footer.jsp" />
	<script>
		$(document).ready(function() {
			$('.add-to-cart').click(function() {
				var id = $(this).data('id');
				var name = $(this).data('name');
				var price = $(this).data('price');
				var anh = $(this).data('anh');

				$.ajax({
					url : 'gioHangController',
					type : 'GET',
					data : {
						id : id,
						name : name,
						price : price,
						anh : anh
					},
					success : function(response) {
						var cartCount = response.cartCount;
						$('.cart-count').text(cartCount);
					},
					error : function(xhr, status, error) {
						alert('Có lỗi xảy ra khi thêm vào giỏ hàng!');
					}
				});
			});
		});
	</script>
</body>
</html>