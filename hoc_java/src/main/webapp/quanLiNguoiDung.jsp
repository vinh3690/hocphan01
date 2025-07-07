<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Quản lý người dùng</title>
<!-- Bootstrap 5 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome for icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
.sidebar {
	padding-left: 0;
	margin-left: 0;
	background-color: #343a40;
	color: white;
	height: 100vh;
	padding: 20px;
}

.sidebar a {
	color: white;
	display: block;
	padding: 10px;
	text-decoration: none;
}

.sidebar a:hover {
	background-color: #495057;
	border-radius: 5px;
}

.content {
	margin-left: 300px;
	padding: 30px;
	background-color: #f8f9fa;
	height: 100vh;
	overflow-y: auto;
}

.table-header {
	background-color: #7b3fe4;
	color: white;
}

.pagination a {
	margin: 0 5px;
	padding: 8px 16px;
	text-decoration: none;
	color: #7b3fe4;
	border: 1px solid #ddd;
	border-radius: 5px;
}

.pagination a.active {
	background-color: #7b3fe4;
	color: white;
	border: 1px solid #7b3fe4;
}

.pagination a:hover:not(.active) {
	background-color: #ddd;
}
</style>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<!-- Sidebar -->
			<jsp:include page="slierBar.jsp" />
			<!-- Nội dung chính -->
			<div class="col-md-9 content">
				<div class="container mt-3">
					<%
					String message = (String) request.getAttribute("message");
					String error = (String) request.getAttribute("error");
					if (message != null) {
					%>
					<div class="alert alert-success" role="alert">
						<%=message%>
					</div>
					<%
					}
					if (error != null) {
					%>
					<div class="alert alert-danger" role="alert">
						<%=error%>
					</div>
					<%
					}
					%>
					<h2 class="text-center">Danh sách Người dùng</h2>
					<!-- Search Input -->
					<div class="d-flex justify-content-center mb-3">
						<input type="text" id="searchInput"
							class="form-control form-control-sm w-50 text-center"
							placeholder="Tìm kiếm người dùng..." oninput="searchUser()">
					</div>
					<!-- Bảng Quản lý Người Dùng -->
					<table class="table table-bordered table-striped" id="userTable">
						<thead class="table-header">
							<tr>
								<th>ID</th>
								<th>Họ tên</th>
								<th>Tài Khoản</th>
								<th>Mật Khẩu</th>
								<th>Địa Chỉ</th>
								<th>Email</th>
								<th>Số Điện Thoại</th>
								<th>Phân Quyền</th>
								<th>Hành Động</th>
							</tr>
						</thead>
						<tbody id="userList">
							<c:forEach var="user" items="${userList}">
								<tr class="user-row">
									<td>${user.id}</td>
									<td class="user-name">${user.hoTen}</td>
									<td class="user-username">${user.tenDangNhap}</td>
									<td>${user.matKhau}</td>
									<td>${user.diaChi}</td>
									<td class="user-email">${user.email}</td>
									<td>${user.phone}</td>
									<td><c:choose>
											<c:when test="${user.phanQuyen == 1}">Admin</c:when>
											<c:otherwise>Người dùng</c:otherwise>
										</c:choose></td>
									<td>
										<button class="btn btn-warning btn-sm btn-edit-user">
											<i class="fas fa-edit"></i> Sửa
										</button> <a href="ChinhSuaNguoiDung?id=${user.id}"
										class="btn btn-danger btn-sm"
										onclick="return confirm('Bạn có chắc chắn muốn xóa?');"> <i
											class="fas fa-trash"></i> Xóa
									</a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<!-- Pagination -->
					<div class="pagination" id="pagination">
						<c:if test="${currentPage > 1}">
							<a href="PhanTrangNguoiDung?page=${currentPage - 1}">« Trước</a>
						</c:if>
						<c:forEach begin="1" end="${totalPages}" var="i">
							<c:choose>
								<c:when test="${i == currentPage}">
									<a class="active">${i}</a>
								</c:when>
								<c:otherwise>
									<a href="PhanTrangNguoiDung?page=${i}">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${currentPage < totalPages}">
							<a href="PhanTrangNguoiDung?page=${currentPage + 1}">Tiếp »</a>
						</c:if>
					</div>
					<!-- Form Thêm Người Dùng -->
					<h3 class="mt-5">Thêm Người Dùng Mới (Admin chỉ có thể thêm
						Admin)</h3>
					<button class="btn btn-primary mb-3" id="toggleFormBtn">Thêm
						Người Dùng</button>
					<div id="addUserForm" class="collapse">
						<form action="ThemAdmin" method="POST">
							<div class="form-group mb-3">
								<input type="hidden" name="action" value="them"> <label
									for="ho_ten" class="form-label">Họ Tên:</label> <input
									type="text" class="form-control" id="ho_ten" name="ho_ten"
									required>
							</div>
							<div class="form-group mb-3">
								<label for="ten_dang_nhap" class="form-label">Tên Đăng
									Nhập:</label> <input type="text" class="form-control"
									id="ten_dang_nhap" name="ten_dang_nhap" required>
							</div>
							<div class="form-group mb-3">
								<label for="mat_khau" class="form-label">Mật Khẩu:</label> <input
									type="password" class="form-control" id="mat_khau"
									name="mat_khau" required>
							</div>
							<div class="form-group mb-3">
								<label for="email" class="form-label">Email:</label> <input
									type="email" class="form-control" id="email" name="email"
									required>
							</div>
							<div class="form-group mb-3">
								<label for="so_dien_thoai" class="form-label">Số Điện
									Thoại:</label> <input type="tel" class="form-control"
									id="so_dien_thoai" name="so_dien_thoai" required>
							</div>
							<div class="form-group mb-3">
								<label for="phan_quyen" class="form-label">Phân Quyền:</label> <input
									type="text" class="form-control" id="phan_quyen"
									name="phan_quyen" value="admin" readonly>
							</div>
							<button type="submit" class="btn btn-success">Thêm Người
								Dùng</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Bootstrap Modal for Editing User -->
	<div class="modal fade" id="editUserModal" tabindex="-1"
		aria-labelledby="editUserModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="editUserModalLabel">Chỉnh sửa
						người dùng</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="editUserForm" action="ChinhSuaNguoiDung" method="post">
						<input type="hidden" id="editUserId" name="id">
						<div class="mb-3">
							<label for="editHoTen" class="form-label">Họ tên</label> <input
								type="text" class="form-control" id="editHoTen" name="hoTen"
								required>
						</div>
						<div class="mb-3">
							<label for="editTenDangNhap" class="form-label">Tên đăng
								nhập</label> <input type="text" class="form-control"
								id="editTenDangNhap" name="tenDangNhap" readonly required>
						</div>


						<div class="mb-3">
							<label for="editMatKhau" class="form-label">Mật khẩu</label> <input
								type="password" class="form-control" id="editMatKhau"
								name="matKhau">
						</div>
						<div class="mb-3">
							<label for="editDiaChi" class="form-label">Địa chỉ</label> <input
								type="text" class="form-control" id="editDiaChi" name="diaChi">
						</div>
						<div class="mb-3">
							<label for="editEmail" class="form-label">Email</label> <input
								type="email" class="form-control" id="editEmail" name="email"
								required>
						</div>
						<div class="mb-3">
							<label for="editPhone" class="form-label">Số điện thoại</label> <input
								type="text" class="form-control" id="editPhone" name="phone"
								required>
						</div>
						<div class="mb-3">
							<label for="editPhanQuyen" class="form-label">Phân quyền</label>
							<select class="form-select" id="editPhanQuyen" name="phanQuyen"
								required>
								<option value="1">Quản trị</option>
								<option value="0">Người dùng</option>
							</select>
						</div>
						<button type="submit" class="btn btn-primary">Lưu thay
							đổi</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- Scripts -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
        const contextPath = '<%=request.getContextPath()%>';
        if (!contextPath || contextPath === '' || contextPath === '/') {
            console.error('contextPath không hợp lệ:', contextPath);
            alert('Lỗi cấu hình context path. Đảm bảo ứng dụng triển khai dưới /hoc_java.');
        } else {
            console.log('contextPath:', contextPath);
        }

        function searchUser() {
            let input = document.getElementById("searchInput").value.toLowerCase();
            let rows = document.querySelectorAll(".user-row");
            rows.forEach(row => {
                let name = row.querySelector(".user-name").textContent.toLowerCase();
                let username = row.querySelector(".user-username").textContent.toLowerCase();
                let email = row.querySelector(".user-email").textContent.toLowerCase();
                row.style.display = (name.includes(input) || username.includes(input) || email.includes(input)) ? "" : "none";
            });
        }

        $(document).ready(function() {
            // Hàm để tải trang người dùng mới
            function loadPage(page) {
                if (!page || isNaN(page) || page < 1) {
                    console.error('Số trang không hợp lệ:', page);
                    alert('Số trang không hợp lệ: ' + page);
                    return;
                }
                console.log('Đang gửi yêu cầu đến:', `${contextPath}/PhanTrangNguoiDung?page=${page}`);
                $.ajax({
                    url: `${contextPath}/PhanTrangNguoiDung`,
                    method: 'GET',
                    data: { page: page },
                    headers: { 'X-Requested-With': 'XMLHttpRequest' },
                    success: function(response) {
                        $('#userTable').html($(response).find('#userTable').html());
                        $('#pagination').html($(response).find('#pagination').html());
                        console.log('Tải trang thành công:', page);
                    },
                    error: function(xhr, status, error) {
                        console.error('Lỗi khi tải trang:', status, error);
                        alert('Đã có lỗi xảy ra: ' + error);
                    }
                });
            }

            // Khi người dùng click vào phân trang
            $(document).on('click', '.pagination a', function(e) {
                e.preventDefault();
                var href = $(this).attr('href');
                var page = href ? href.split('=')[1] : null;
                if (page && !isNaN(page) && page > 0) {
                    console.log('Bấm vào trang:', page);
                    loadPage(page);
                } else {
                    console.error('Số trang không hợp lệ từ href:', href);
                    alert('Số trang không hợp lệ.');
                }
            });

            // Handle click on edit button with event delegation
            $(document).on('click', '.btn-edit-user', function(e) {
                e.preventDefault();
                console.log('Edit button clicked'); // Debugging

                var row = $(this).closest('tr');
                if (!row.length) {
                    console.error('Không tìm thấy hàng chứa nút chỉnh sửa');
                    return;
                }

                // Extract data from the row
                var id = row.find('td').eq(0).text();
                var hoTen = row.find('td').eq(1).text();
                var tenDangNhap = row.find('td').eq(2).text();
                var matKhau = row.find('td').eq(3).text();
                var email = row.find('td').eq(5).text();
                var phone = row.find('td').eq(6).text();
                var phanQuyen = row.find('td').eq(7).text().trim() === 'Admin' ? 1 : 0;
				var diaChi = row.find('td').eq(4).text();
                console.log('User data:', { id, hoTen, tenDangNhap, matKhau, email, phone, phanQuyen });
                // Populate the modal form fields
                $('#editUserId').val(id.trim());
                $('#editHoTen').val(hoTen.trim());
                $('#editTenDangNhap').val(tenDangNhap);
                $('#editMatKhau').val(matKhau.trim());
                $('#editEmail').val(email.trim());
                $('#editPhone').val(phone.trim());
                $('#editPhanQuyen').val(phanQuyen);
                $('#editDiaChi').val(diaChi);
                // Show the modal
                try {
                    $('#editUserModal').modal('show');
                    console.log('Modal should be visible');
                } catch (error) {
                    console.error('Lỗi khi hiển thị modal:', error);
                    alert('Không thể hiển thị modal. Vui lòng kiểm tra console.');
                }
            });

            // Xử lý nút toggle form
            $('#toggleFormBtn').click(function() {
                $('#addUserForm').slideToggle(function() {
                    if ($('#addUserForm').is(':visible')) {
                        $('#toggleFormBtn').text('Hủy');
                    } else {
                        $('#toggleFormBtn').text('Thêm Người Dùng');
                    }
                });
            });

            // Tải trang mặc định khi trang load
            loadPage(1);

            // Log giá trị ban đầu
            console.log('currentPage:', ${currentPage});
            console.log('totalPages:', ${totalPages});
        });
    </script>
</body>
</html>