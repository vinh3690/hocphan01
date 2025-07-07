<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Quản Lý Danh Mục</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
	<!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap 5 JS Bundle (có Popper) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	
<style>
.sidebar {
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
	background-color: #f8f9fa;
	padding: 30px;
	height: 100vh;
	margin-left: 300px;
	overflow-y: auto;
}

.btn-purple {
	background-color: #7b3fe4;
	color: white;
}

.btn-purple:hover {
	background-color: #692dcc;
}

.table-header {
	background-color: #7b3fe4;
	color: white;
}
</style>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<jsp:include page="slierBar.jsp" />

			<!-- Nội dung chính bên phải -->
			<div class="col-md-9 content">
				<h3 class="mb-4">Quản Lý Danh Mục</h3>

				<!-- Hiển thị thông báo -->
				<c:if test="${not empty message}">
					<div class="alert alert-success">${message}</div>
				</c:if>
				<c:if test="${not empty error}">
					<div class="alert alert-danger">${error}</div>
				</c:if>

				<!-- Form thêm danh mục -->
				<form action="danhMucController" method="post" class="mb-4">
					<div class="mb-3">
						<label for="tenDanhMuc" class="form-label">Tên Danh Mục</label> <input
							type="text" class="form-control" id="tenDanhMuc"
							name="tenDanhMuc" required> <input type="hidden"
							name="action" value="them">
					</div>
					<button type="submit" class="btn btn-purple">Thêm Danh Mục</button>
				</form>

				<!-- Danh sách danh mục -->
				<table class="table table-bordered">
					<thead class="table-header">
						<tr>
							<th>Tên Danh Mục</th>
							<th>Hành Động</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="dm" items="${danhMuc}">
							<tr>
								<td>${dm.tenDanhMuc}</td>
								<td>
									<button type="button"
                    class="btn btn-warning btn-edit-category"
                    data-id="${dm.id}"
                    data-name="${dm.tenDanhMuc}"
                    data-bs-toggle="modal"
                    data-bs-target="#categoryModal">
                <i class="fas fa-edit"></i> Sửa
            </button>

									<form action="danhMucController" method="post"
										style="display: inline;"
										onsubmit="return confirm('Bạn có chắc chắn muốn xóa?');">
										<input type="hidden" name="id" value="${dm.id}" /> <input
											type="hidden" name="action" value="xoa">
										<button type="submit" class="btn btn-danger btn-sm">Xóa</button>
									</form>
								</td>

							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<div class="modal fade" id="categoryModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <form action="danhMucController" method="post" class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Sửa Danh Mục</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="categoryId" name="id">

                <div class="mb-3">
                    <label for="categoryName" class="form-label">Tên danh mục</label>
                    <input type="text" id="categoryName" name="tenDanhMuc" class="form-control" required>
                </div>
            </div>
            <div class="modal-footer">
                <button type="submit" name="action" value="sua" class="btn btn-primary">Lưu thay đổi</button>
            </div>
        </form>
    </div>
</div>
		
	</div>
	<script>
    document.querySelectorAll(".btn-edit-category").forEach(function (btn) {
        btn.addEventListener("click", function () {
            document.getElementById("categoryId").value = this.dataset.id;
            document.getElementById("categoryName").value = this.dataset.name;
        });
    });
</script>
	
</body>
</html>
