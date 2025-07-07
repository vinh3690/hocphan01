<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Quản Lý Đánh Giá - GreenMart</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<!-- Add jQuery library -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
/* Your existing CSS remains unchanged */
* {
	box-sizing: border-box;
}

body {
	font-family: 'Poppins', sans-serif;
	background-color: #f5f5f5;
	margin: 0;
}

.main-container {
	display: flex;
	min-height: 100vh;
}

.sidebar {
	width: 250px;
	background: #1a3c34;
	color: white;
	position: fixed;
	height: 100%;
	transition: transform 0.3s ease;
}

.sidebar .nav-link {
	color: white;
	transition: background 0.3s;
}

.sidebar .nav-link:hover {
	background: rgba(255, 255, 255, 0.1);
	border-radius: 5px;
}

.content {
	margin-left: 250px;
	padding: 20px;
	width: calc(100% - 250px);
	transition: margin-left 0.3s ease, width 0.3s ease;
}

h2 {
	color: #1a3c34;
	text-align: center;
	margin-bottom: 30px;
}

.table-container {
	background: white;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	overflow-x: auto;
}

table {
	width: 100%;
	border-collapse: collapse;
	background: #ffffff;
	border-radius: 8px;
	overflow: hidden;
}

th, td {
	padding: 12px 15px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

th {
	background: linear-gradient(135deg, #34c759, #2a9d8f);
	color: #ffffff;
	font-weight: 600;
	white-space: nowrap;
}

td img {
	max-width: 60px;
	height: auto;
	border-radius: 8px;
}

tr:nth-child(even) {
	background-color: #f9f9f9;
}

tr:hover {
	background-color: rgba(52, 199, 89, 0.1);
}

.no-data {
	text-align: center;
	color: #666;
	padding: 20px;
}

.action-buttons a {
	display: inline-block;
	margin-right: 8px;
	padding: 6px 10px;
	border-radius: 5px;
	text-decoration: none;
	font-size: 13px;
	white-space: nowrap;
}

.edit-btn {
	background-color: #007bff;
	color: white;
}

.edit-btn:hover {
	background-color: #0056b3;
}

.delete-btn {
	background-color: #dc3545;
	color: white;
}

.delete-btn:hover {
	background-color: #b02a37;
}

/* Modal Styling */
.modal-content {
	border-radius: 8px;
}

.modal-header {
	background: linear-gradient(135deg, #34c759, #2a9d8f);
	color: white;
}

.modal-body img {
	max-width: 100px;
	height: auto;
	border-radius: 8px;
}

/* Responsive Adjustments */
@media ( max-width : 768px) {
	.sidebar {
		width: 200px;
		transform: translateX(-100%);
	}
	.sidebar.active {
		transform: translateX(0);
	}
	.content {
		margin-left: 0;
		width: 100%;
	}
	.table-container {
		margin-left: 0;
	}
	table {
		min-width: 500px;
	}
	.action-buttons a {
		padding: 5px 8px;
		font-size: 12px;
	}
}

@media ( max-width : 576px) {
	.sidebar {
		position: fixed;
		width: 100%;
		height: auto;
		transform: translateX(-100%);
		z-index: 1000;
	}
	.sidebar.active {
		transform: translateX(0);
	}
	.content {
		margin-left: 0;
		width: 100%;
	}
	.table-container {
		margin-left: 0;
	}
	table {
		min-width: 100%;
	}
	th, td {
		font-size: 14px;
		padding: 8px;
	}
	.action-buttons a {
		padding: 4px 6px;
		font-size: 11px;
	}
}

.sidebar-toggle {
	display: none;
	position: fixed;
	top: 10px;
	left: 10px;
	z-index: 1100;
	background: #1a3c34;
	color: white;
	border: none;
	padding: 8px;
	border-radius: 5px;
}

@media ( max-width : 768px) {
	.sidebar-toggle {
		display: block;
	}
}
</style>
</head>
<body>
	<div class="main-container">
		<!-- Sidebar Toggle Button -->
		<button class="sidebar-toggle" onclick="toggleSidebar()">
			<i class="fas fa-bars"></i>
		</button>

		<!-- Include Sidebar -->
		<div class="sidebar" id="sidebar">
			<jsp:include page="slierBar.jsp" />
		</div>

		<!-- Nội dung chính -->
		<div class="content">
			<h2>Quản Lý Đánh Giá</h2>
			<div id="delete-success-message"
				style="display: none; color: green; font-weight: bold; margin: 10px 0;">
				Xóa đánh giá thành công!</div>

			<c:if test="${not empty message}">
				<div
					class="alert alert-${messageType != null ? messageType : 'success'} alert-dismissible fade show"
					role="alert">
					${message}
					<button type="button" class="btn-close" data-bs-dismiss="alert"
						aria-label="Close"></button>
				</div>
			</c:if>

			<c:choose>
				<c:when test="${empty dg}">
					<div class="no-data">Không có dữ liệu để hiển thị.</div>
				</c:when>
				<c:otherwise>
					<div class="table-container">
						<table>
							<thead>
								<tr>
									<th>ID</th>
									<th>Tên Người Dùng</th>
									<th>Tên Sản Phẩm</th>
									<th>Ảnh</th>
									<th>Điểm</th>
									<th>Bình Luận</th>
									<th>Ngày Đánh Giá</th>
									<th>Hành Động</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="review" items="${dg}">
									<tr>
										<td>${review.id}</td>
										<td>${review.nguoiDung.hoTen}</td>
										<td>${review.sanPham.tenSanPham}</td>
										<td><c:if test="${not empty review.sanPham.anh}">
												<img src="images/${review.sanPham.anh}" alt="Ảnh sản phẩm"
													style="width: 60px; height: auto; border-radius: 8px;">
											</c:if> <c:if test="${empty review.sanPham.anh}">
												<span>Không có ảnh</span>
											</c:if></td>
										<td>${review.diem}</td>
										<td><c:choose>
												<c:when test="${empty review.binhLuan}">Không có bình luận</c:when>
												<c:otherwise>${review.binhLuan}</c:otherwise>
											</c:choose></td>
										<td>${review.ngayDanhGia}</td>
										<td class="action-buttons"><a href="#" class="edit-btn"
											data-bs-toggle="modal" data-bs-target="#editReviewModal"
											data-id="${review.id}"
											data-idNguoiDung="${review.nguoiDungId}"
											data-idSanPham="${review.sanPhamId}"
											data-username="${review.nguoiDung.hoTen}"
											data-product="${review.sanPham.tenSanPham}"
											data-image="${review.sanPham.anh}"
											data-rating="${review.diem}"
											data-comment="${review.binhLuan}"> <i class="fas fa-edit"></i>
												Sửa
										</a> <c:choose>
												<c:when
													test="${not empty review.id and review.id != '0' and review.id != ''}">
													<a href="ChinhSuaDanhGia?id=${review.id}"
														class="delete-btn delete-review-btn"
														onclick="return confirm('Bạn có chắc chắn muốn xóa đánh giá này không?');">
														<i class="fas fa-trash"></i> Xóa
													</a>

												</c:when>
												<c:otherwise>
													<span style="color: red;">ID không hợp lệ</span>
													<script>
                                                        console.warn('ID đánh giá không hợp lệ: ${review.id} cho sản phẩm: ${review.sanPham.tenSanPham}');
                                                    </script>
												</c:otherwise>
											</c:choose></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>

	<!-- Edit Review Modal -->
	<div class="modal fade" id="editReviewModal" tabindex="-1"
		aria-labelledby="editReviewModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="editReviewModalLabel">Sửa Đánh Giá</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="editReviewForm" action="ChinhSuaDanhGia" method="post">
						<input type="hidden" name="id" id="modal-id"> <input
							type="hidden" name="idNguoiDung" id="modal-idNguoiDung">
						<input type="hidden" name="idSanPham" id="modal-idSanPham">
						<div class="mb-3">
							<label for="modal-username" class="form-label">Tên Người
								Dùng</label> <input type="text" class="form-control" id="modal-username"
								disabled>
						</div>
						<div class="mb-3">
							<label for="modal-product" class="form-label">Tên Sản
								Phẩm</label> <input type="text" class="form-control" id="modal-product"
								disabled>
						</div>
						<div class="mb-3">
							<label for="modal-image" class="form-label">Ảnh Sản Phẩm</label>
							<div id="modal-image-container">
								<img id="modal-image" src="" alt="Ảnh sản phẩm"
									style="max-width: 100px; height: auto; border-radius: 8px; display: none;">
								<span id="modal-no-image" style="display: none;">Không có
									ảnh</span>
							</div>
						</div>
						<div class="mb-3">
							<label for="modal-rating" class="form-label">Điểm</label> <input
								type="number" class="form-control" id="modal-rating" name="diem"
								min="1" max="5" required>
						</div>
						<div class="mb-3">
							<label for="modal-comment" class="form-label">Bình Luận</label>
							<textarea class="form-control" id="modal-comment" name="binhLuan"></textarea>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Hủy</button>
							<button type="submit" class="btn btn-primary">Lưu</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('active');
        }

        document.addEventListener('DOMContentLoaded', function () {
            // Populate modal with review data
            const editButtons = document.querySelectorAll('.edit-btn');
            editButtons.forEach(button => {
                button.addEventListener('click', function () {
                    const id = this.getAttribute('data-id');
                    const idNguoiDung = this.getAttribute('data-idNguoiDung');
                    const idSanPham = this.getAttribute('data-idSanPham');
                    const username = this.getAttribute('data-username');
                    const product = this.getAttribute('data-product');
                    const image = this.getAttribute('data-image');
                    const rating = this.getAttribute('data-rating');
                    const comment = this.getAttribute('data-comment');

                    document.getElementById('modal-id').value = id;
                    document.getElementById('modal-idNguoiDung').value = idNguoiDung;
                    document.getElementById('modal-idSanPham').value = idSanPham;
                    document.getElementById('modal-username').value = username;
                    document.getElementById('modal-product').value = product;
                    document.getElementById('modal-rating').value = rating;
                    document.getElementById('modal-comment').value = comment || '';

                    const imageElement = document.getElementById('modal-image');
                    const noImageElement = document.getElementById('modal-no-image');
                    if (image) {
                        imageElement.src = 'images/' + image;
                        imageElement.style.display = 'block';
                        noImageElement.style.display = 'none';
                    } else {
                        imageElement.style.display = 'none';
                        noImageElement.style.display = 'block';
                    }
                });
            });});

            
    </script>
</body>
</html>