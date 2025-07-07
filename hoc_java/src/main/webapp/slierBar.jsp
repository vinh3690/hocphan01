<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sidebar - Danh mục quản lý</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body {
	margin: 0;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background-color: #f8f9fa;
}

.sidebar {
	width: 250px;
	height: 100vh;
	position: fixed;
	background-color: #343a40;
	color: white;
	padding-top: 20px;
	box-shadow: 2px 0 8px rgba(0, 0, 0, 0.1);
}

.sidebar ul {
	list-style: none;
	padding: 0;
	margin: 0;
}

.sidebar ul li {
	margin: 5px 0;
}

.sidebar ul li a i {
	margin-right: 10px;
}

.sidebar p {
	color: #ffc107;
	font-weight: bold;
	padding-left: 20px;
	margin-bottom: 20px;
}

.sidebar ul li a {
	display: block;
	padding: 12px 20px;
	text-decoration: none;
	color: #ffffff;
	transition: all 0.3s ease;
	border-left: 4px solid transparent;
}

.sidebar ul li a:hover {
	background-color: #495057;
	color: #ffc107;
	border-left: 4px solid #ffc107;
}

.sidebar ul li a.active {
	background-color: #495057;
	border-left: 4px solid #0d6efd;
}
</style>

</head>
<body>

	<!-- views/layout/danhmuc.jsp -->
	<div class="sidebar">
		<p>
			<i class="fas fa-user"></i> Chúc mừng bạn trở lại
		</p>
		
		<ul>
		<li><a href="sanPhamController"><i class="fas fa-home"></i> Trang chủ</a></li>
		
			<li><a href="quanLiSanPhamController" class="active"><i
					class="fas fa-box"></i> Quản lý sản phẩm</a></li>
			<li><a href="danhMucController"><i class="fas fa-list-alt"></i>Danh
					mục sản phẩm</a></li>
			<li><a href="PhanTrangNguoiDung"><i class="fas fa-users"></i>Quản
					lý người dùng</a></li>
			<li><a href="quanLiDonHang"><i class="fas fa-receipt"></i>
					Quản lý Đơn hàng</a></li>
			<li><a href="ThongKe"><i
					class="fas fa-chart-line"></i> Quản lý thống kê</a></li>
			<li><a href="quanLiDanhGia"><i class="fas fa-comments"></i>
					Quản lý đánh giá</a></li>

		</ul>
	</div>


</body>
</html>
