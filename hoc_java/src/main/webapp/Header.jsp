<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.List"%>
<%@ page import="entity.SanPham"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<meta charset="UTF-8">
<title>Vườn Cây Xanh</title>
<style>
.container {
	max-width: 1200px;
	margin: 0 auto;
	padding: 0 20px;
}

header {
	background-color: #2d6a4f;
	color: white;
	padding: 12px 0;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	z-index: 1000;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

header .container {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

header .logo a {
	color: white;
	font-size: 28px;
	font-weight: bold;
	text-decoration: none;
}

header nav ul {
	list-style: none;
	display: flex;
	align-items: center;
}

header nav ul li {
	margin-left: 30px;
}

header nav ul li a {
	color: white;
	text-decoration: none;
	font-size: 16px;
	transition: color 0.3s;
}

header nav ul li a:hover {
	color: #a8dadc;
}

.cart {
	position: relative;
	display: flex;
	align-items: center;
}

.cart a {
	display: flex;
	align-items: center;
	text-decoration: none;
	color: white;
}

.cart img {
	width: 24px;
	height: 24px;
	margin-right: 8px;
	filter: invert(100%); /* Make icon white */
}

.cart-count {
	position: absolute;
	top: -8px;
	right: -8px;
	background-color: #ff6600;
	color: white;
	border-radius: 50%;
	padding: 2px 6px;
	font-size: 12px;
}
/* Dropdown container */
.dropdown {
	position: relative;
	display: inline-block;
}

/* Dropdown button (icon) */
.dropbtn img {
	filter: invert(1); /* nếu nền tối */
}

/* Dropdown content (hidden by default) */
.dropdown-content {
	display: none;
	position: absolute;
	right: 0;
	background-color: white;
	min-width: 160px;
	box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
	z-index: 1;
}

/* Dropdown links */
.dropdown-content a {
	color: black;
	padding: 10px 16px;
	text-decoration: none;
	display: block;
}

/* Hover effect */
.dropdown-content a:hover {
	background-color: #f1f1f1;
}

/* Show the dropdown on hover */
.dropdown:hover .dropdown-content {
	display: block;
}
</style>
</head>
<body>
	<header>
		<div class="container">
			<div class="logo">
				<a href="sanPhamController"> <img src="images/logo.png"
					alt="Fruit Shop Logo" width="100" style="border-radius: 10px;">
				</a>


			</div>
			<nav>
				<ul>
					<c:if test="${not empty sessionScope.user}">
						<li class="hello" style="font-weight: bold; color: #ffffff;">
							Xin chào, ${fn:escapeXml(sessionScope.user.hoTen)}</li>
					</c:if>
					 <c:if test="${sessionScope.user.phanQuyen == 1}">
						<li><a href="quanLiSanPhamController">Quản lí</a></li>
					 </c:if>
					<li><a href="LichSuMuaHang">Lịch sử mua hàng</a></li>
					<li><a href="GioiThieu.jsp">Giới Thiệu</a></li>
					<li><a href="thanhYou.jsp">Liên Hệ</a></li>
					<li><a href="sanPhamController"> <i class="fas fa-home"></i>
					</a></li>
					<li class="dropdown"><a href="#" class="dropbtn"> <img
							src="https://img.icons8.com/ios-filled/20/settings.png"
							alt="Cài đặt" style="vertical-align: middle;">
					</a>
						<div class="dropdown-content">
							<a href="CapNhatThongTinn.jsp">Chỉnh sửa thông tin</a> <a
								href="dangXuat">Đăng xuất</a>
						</div></li>

					<%
					List<SanPham> cart = (List<SanPham>) session.getAttribute("cart");
					int cartSize = 0;
					if (cart != null) {
					    for (SanPham sp : cart) {
					        cartSize += sp.getSoLuong();
					    }
					}
					%>

					<li class="cart"><a href="gioHang.jsp"> <img
							src="https://img.icons8.com/ios-glyphs/30/shopping-cart.png"
							alt="Cart"> <span class="cart-count"><%=cartSize%></span>
					</a></li>
				</ul>
				<div id="mini-cart"></div>
			</nav>
		</div>
	</header>
</body>
</html>
