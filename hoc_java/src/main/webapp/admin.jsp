<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<fmt:setLocale value="vi_VN" />
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Quản Lý Admin</title>
<!-- Bootstrap 5 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome for icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<style>
body {
	background-color: #f8f9fa;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.sidebar {
	min-height: 100vh;
	background-color: #6f42c1;
	padding-top: 20px;
	position: fixed;
	width: 250px;
	color: white;
}

.sidebar a {
	color: #ffffff;
	padding: 15px;
	display: block;
	text-decoration: none;
	transition: background 0.3s;
}

.sidebar a:hover {
	background-color: #5a32a3;
}

.sidebar a.active {
	background-color: #5a32a3;
}

.content {
	margin-left: 250px;
	padding: 20px;
}

.card {
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	margin-bottom: 20px;
}

.btn-primary {
	background-color: #6f42c1;
	border: none;
	transition: background 0.3s;
}

.btn-primary:hover {
	background-color: #5a32a3;
}

.table {
	border-radius: 8px;
	overflow: hidden;
}

.table th {
	background-color: #6f42c1;
	color: white;
}

.form-control, .form-select {
	border-radius: 5px;
}

.tab-content {
	display: none;
}

.tab-content.active {
	display: block;
}

.alert {
	margin-bottom: 20px;
}

@media ( max-width : 768px) {
	.sidebar {
		width: 100%;
		position: relative;
	}
	.content {
		margin-left: 0;
	}
}
</style>
</head>
<body>
	<!-- Sidebar -->



	<!-- Main Content -->
	<div class="content">
		<!-- Quản Lý Sản Phẩm -->
		<div id="product" class="tab-content">
			<div class="card p-4">
				<h3 class="mb-4">Quản Lý Sản Phẩm</h3>
				<!-- Display success or error message for products -->
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
				<form action="sanPhamController" method="post">
					<input type="hidden" name="action" value="them">
					<div class="mb-3">
						<label for="tenSanPham" class="form-label">Tên Sản Phẩm</label> <input
							type="text" class="form-control" id="tenSanPham"
							name="tenSanPham" required>
					</div>
					<div class="mb-3">
						<label for="gia" class="form-label">Giá</label> <input
							type="number" step="0.01" class="form-control" id="gia"
							name="gia" required>
					</div>
					<div class="mb-3">
						<label for="moTa" class="form-label">Mô Tả</label>
						<textarea class="form-control" id="moTa" name="moTa"></textarea>
					</div>
					<div class="mb-3">
						<label for="anh" class="form-label">Ảnh</label> <input type="file"
							class="form-control" id="anh" name="anh" accept="image/*">
					</div>
					<div class="mb-3">
						<label for="danhMuc_id" class="form-label">Danh Mục</label> <select
							class="form-select" id="danhMuc_id" name="danhMuc_id">
							<option value="">Chọn danh mục</option>
							<!-- Danh mục sẽ được load động từ database -->
						</select>
					</div>
					<div class="mb-3">
						<label for="soLuong" class="form-label">Số Lượng</label> <input
							type="number" class="form-control" id="soLuong" name="soLuong"
							required>
					</div>
					<button type="submit" class="btn btn-primary">
						<i class="fas fa-plus me-2"></i> Thêm Sản Phẩm
					</button>
				</form>
			</div>
			<div class="card">
				<div class="card-body">
					<table class="table table-hover table-bordered">
						<thead class="table-primary">
							<tr>
								<th>Tên Sản Phẩm</th>
								<th style="width: 150px;">Giá</th>
								<th style="width: 500px;">Mô Tả</th>
								<th>Ảnh</th>
								<th>Tên Danh Mục</th>
								<th>Số Lượng</th>
								<th>Hành Động</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="sp" items="${sanPham}">
								<tr>
									<td>${sp.tenSanPham}</td>
									<td><fmt:formatNumber value="${sp.gia}" type="number" groupingUsed="true" pattern="#,##0" /> VND</td>
									<td style="word-break: break-word;">${sp.moTa}</td>
									<td><img
										src="${pageContext.request.contextPath}/images/${sp.anh}"
										alt="Ảnh sản phẩm" style="width: 100px;"></td>
									<td>${sp.danhMuc_id}</td>
									<td>${sp.soLuong}</td>
									<td><button type="button" class="btn btn-sm btn-primary"
        data-id="${sp.id}"
        data-ten="${sp.tenSanPham}"
        data-gia="${sp.gia}"
        data-mota="${sp.moTa}"
        data-anh="${sp.anh}"
        data-danhmuc="${sp.danhMuc_id}"
        data-soluong="${sp.soLuong}"
        onclick="prepareEdit(this)"
        data-bs-toggle="modal"
        data-bs-target="#editModal">Sửa</button>
									
									
									
									 <form action="sanPhamController" method="post" onsubmit="return confirm('Xóa sản phẩm này?')">
										<input type="hidden" name="action" value="xoa">
    <input type="hidden" name="id" value="${sp.id}">
    <button type="submit" class="btn btn-sm btn-danger">Xóa</button>
</form>
										</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>

		<!-- Quản Lý Danh Mục -->
		<div id="category" class="tab-content">
			<div class="card p-4">
				<h3 class="mb-4">Quản Lý Danh Mục</h3>
				<!-- Display success or error message for categories -->
				<%
				String messageCategory = (String) request.getAttribute("message");
				String errorCategory = (String) request.getAttribute("error");
				if (messageCategory != null) {
				%>
				<div class="alert alert-success" role="alert">
					<%=messageCategory%>
				</div>
				<%
				}
				if (errorCategory != null) {
				%>
				<div class="alert alert-danger" role="alert">
					<%=errorCategory%>
				</div>
				<%
				}
				%>
				<form action="danhMucController" method="post">
					<input type="hidden" name="action" value="them">
					<div class="mb-3">
						<label for="tenDanhMuc" class="form-label">Tên Danh Mục</label> <input
							type="text" class="form-control" id="tenDanhMuc"
							name="tenDanhMuc" required>
					</div>
					<button type="submit" class="btn btn-primary">
						<i class="fas fa-plus me-2"></i> Thêm Danh Mục
					</button>
				</form>
			</div>
			<div class="card">
				<div class="card-body">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>Tên Danh Mục</th>
								<th>Hành Động</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="dm" items="${danhMuc}">
								<tr>
									<td>${dm.tenDanhMuc}</td>
									<td><a href="editSanPham?id=${dm.id}"
										class="btn btn-sm btn-primary">Sửa</a> <a
										href="deleteSanPham?id=${dm.id}" class="btn btn-sm btn-danger"
										onclick="return confirm('Xóa sản phẩm này?')">Xóa</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>

		<!-- Quản Lý Người Dùng -->
		<div id="user" class="tab-content">
			<div class="card p-4">
				<h3 class="mb-4">Quản Lý Người Dùng</h3>
				<!-- Display success or error message for users -->
				<%
				String messageUser = (String) request.getAttribute("messageUser");
				String errorUser = (String) request.getAttribute("errorUser");
				if (messageUser != null) {
				%>
				<div class="alert alert-success" role="alert">
					<%=messageUser%>
				</div>
				<%
				}
				if (errorUser != null) {
				%>
				<div class="alert alert-danger" role="alert">
					<%=errorUser%>
				</div>
				<%
				}
				%>
				<form action="UserServlet" method="post">
					<div class="mb-3">
						<label for="tenDangNhap" class="form-label">Tên Đăng Nhập</label>
						<input type="text" class="form-control" id="tenDangNhap"
							name="tenDangNhap" required>
					</div>
					<div class="mb-3">
						<label for="matKhau" class="form-label">Mật Khẩu</label> <input
							type="password" class="form-control" id="matKhau" name="matKhau"
							required>
					</div>
					<div class="mb-3">
						<label for="hoTen" class="form-label">Họ Tên</label> <input
							type="text" class="form-control" id="hoTen" name="hoTen" required>
					</div>
					<div class="mb-3">
						<label for="email" class="form-label">Email</label> <input
							type="email" class="form-control" id="email" name="email"
							required>
					</div>
					<div class="mb-3">
						<label for="phone" class="form-label">Số Điện Thoại</label> <input
							type="text" class="form-control" id="phone" name="phone" required>
					</div>
					<button type="submit" class="btn btn-primary">
						<i class="fas fa-plus me-2"></i> Thêm Người Dùng
					</button>
				</form>
			</div>
			<div class="card">
				<div class="card-body">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>Tên Đăng Nhập</th>
								<th>Họ Tên</th>
								<th>Email</th>
								<th>Số Điện Thoại</th>
								<th>Hành Động</th>
							</tr>
						</thead>
						<tbody>
							<!-- Dữ liệu người dùng sẽ được load động từ database -->
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<!-- Edit Modal -->
       <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editModalLabel">Sửa Sản Phẩm</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="sanPhamController" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" id="editId">

                    <div class="mb-3">
                        <label for="editTenSanPham" class="form-label">Tên Sản Phẩm</label>
                        <input type="text" class="form-control" id="editTenSanPham" name="tenSanPham" required>
                    </div>

                    <div class="mb-3">
                        <label for="editGia" class="form-label">Giá</label>
                        <input type="number" class="form-control" id="editGia" name="gia" required>
                    </div>

                    <div class="mb-3">
                        <label for="editMoTa" class="form-label">Mô Tả</label>
                        <textarea class="form-control" id="editMoTa" name="moTa" rows="4"></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="editAnh" class="form-label">Ảnh Sản Phẩm</label>
                        <input type="file" class="form-control" id="editAnh" name="anh">
                    </div>

                    <div class="mb-3">
                        <label for="editDanhMucId" class="form-label">Danh Mục</label>
                        <select class="form-select" id="editDanhMucId" name="danhMuc_id" required>
                            <c:forEach var="dm" items="${danhMucList}">
                                <option value="${dm.id}">${dm.tenDanhMuc}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="editSoLuong" class="form-label">Số Lượng</label>
                        <input type="number" class="form-control" id="editSoLuong" name="soLuong" required>
                    </div>

                    <button type="submit" class="btn btn-primary">Cập Nhật</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                </form>
            </div>
        </div>
    </div>
</div>
       
	</div>
	

	<!-- Bootstrap 5 JS and Popper.js -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
        function openTab(tabName) {
            var contents = document.getElementsByClassName("tab-content");
            for (var i = 0; i < contents.length; i++) {
                contents[i].classList.remove("active");
                contents[i].style.display = "none";
            }
            var selectedContent = document.getElementById(tabName);
            selectedContent.classList.add("active");
            selectedContent.style.display = "block";
            var tabs = document.getElementsByTagName("a");
            for (var i = 0; i < tabs.length; i++) {
                tabs[i].classList.remove("active");
                if (tabs[i].getAttribute("href") === "#" + tabName) {
                    tabs[i].classList.add("active");
                }
            }
        }

        function hideAlerts() {
            var successAlerts = document.getElementsByClassName('alert-success');
            var errorAlerts = document.getElementsByClassName('alert-danger');
            for (var i = 0; i < successAlerts.length; i++) {
                successAlerts[i].style.display = 'none';
            }
            for (var i = 0; i < errorAlerts.length; i++) {
                errorAlerts[i].style.display = 'none';
            }
        }

        window.onload = function() {
            <% String activeTab = (String) request.getAttribute("activeTab");
            if (activeTab != null) { %>
                openTab('<%=activeTab%>');
            <% } else { %>
                openTab('product');
            <% } %>
        };
        function prepareEdit(button) {
            document.getElementById('editId').value = button.dataset.id;
            document.getElementById('editTenSanPham').value = button.dataset.ten;
            document.getElementById('editGia').value = button.dataset.gia;
            document.getElementById('editMoTa').value = button.dataset.mota;
            document.getElementById('editDanhMucId').value = button.dataset.danhmuc;
            document.getElementById('editSoLuong').value = button.dataset.soluong;
        }


    </script>
</body>
</html>