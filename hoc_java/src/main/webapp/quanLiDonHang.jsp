<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Quản Lý Đơn Hàng</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- DataTables CSS -->
<link
	href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css"
	rel="stylesheet">
<!-- Font Awesome for icons -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
	rel="stylesheet">
<style>
body {
	background-color: #f4f6f9;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.container {
	margin-top: 30px;
	margin-left:250px;
	background-color: #fff;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.table-container {
	margin-top: 20px;
}

.table th, .table td {
	vertical-align: middle;
}

.status-pending {
	color: #ffc107;
	font-weight: bold;
}

.status-completed {
	color: #28a745;
	font-weight: bold;
}

.status-cancelled {
	color: #dc3545;
	font-weight: bold;
}

.btn-action {
	margin-right: 5px;
}

h2 {
	color: #343a40;
	font-weight: 600;
}
</style>
</head>
<body>
<jsp:include page="slierBar.jsp" />
	<div class="container">
		<h2 class="text-center mb-4">Quản Lý Đơn Hàng</h2>
		<c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
		<div class="table-container">
			<table id="orderTable" class="table table-striped table-bordered">
				<thead class="table-dark">
					<tr>
						<th>ID</th>
						<th>Tên Khách Hàng</th>
						<th>Tổng Tiền</th>
						<th>Trạng Thái</th>
						<th>Địa Chỉ</th>
						<th>Số Điện Thoại</th>
						<th>Ghi Chú</th>
						<th>Hình Thức</th>
						<th>Email</th>
						<th>Hành Động</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="order" items="${dh}">
						<tr>
							<td>${order.id}</td>
							<td>${order.hoTen}</td>
							<td><fmt:formatNumber value="${order.tongTien}"
									type="number" groupingUsed="true" /> ₫</td>
							<td
								class="
                                <c:choose>
                                    <c:when test="${order.trangThai == 'Đang xử lí'}">status-pending</c:when>
                                    <c:when test="${order.trangThai == 'Đã thanh toán'}">status-completed</c:when>
                                    <c:when test="${order.trangThai == 'Đã hủy'}">status-cancelled</c:when>
                                </c:choose>">
								${order.trangThai}</td>
							<td>${order.diaChi}</td>
							<td>${order.soDienThoai}</td>
							<td>${order.ghiChu}</td>
							<td>${order.hinhThuc}</td>
							<td>${order.email}</td>
							<td>
								<button class="btn btn-sm btn-primary btn-action"
									onclick="openEditModal(${order.id}, '${order.hoTen}', ${order.tongTien}, '${order.trangThai}', '${order.diaChi}', '${order.soDienThoai}', '${order.ghiChu}', '${order.hinhThuc}', '${order.email}')"
									data-bs-toggle="modal" data-bs-target="#editOrderModal">
									<i class="fas fa-edit"></i> Sửa
								</button> <button class="btn btn-sm btn-danger btn-action" 
        onclick="deleteOrder(${order.id}, this)">
    <i class="fas fa-trash"></i> Xóa
</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>

	<!-- Modal Chỉnh Sửa Đơn Hàng -->
	<div class="modal fade" id="editOrderModal" tabindex="-1"
		aria-labelledby="editOrderModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="editOrderModalLabel">Chỉnh Sửa Đơn
						Hàng</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="editOrderForm" action="QuanLioDonHang1" method="POST">
						<input type="hidden" id="orderId" name="id">
						<div class="mb-3">
							<label for="hoTen" class="form-label">Tên Khách Hàng</label> <input
								type="text" class="form-control" id="hoTen" name="hoTen"
								required>
						</div>
						<div class="mb-3">
							<label for="tongTien" class="form-label">Tổng Tiền</label> <input
								type="number" class="form-control" id="tongTien" name="tongTien"
								required>
						</div>
						<div class="mb-3">
							<label for="trangThai" class="form-label">Trạng Thái</label> <select
								class="form-select" id="trangThai" name="trangThai" required>
								<option value="Đang xử lí">Đang xử lí</option>
								<option value="Đã thanh toán">Đã thanh toán</option>
							</select>
						</div>
						<div class="mb-3">
							<label for="diaChi" class="form-label">Đùi Chỉ</label> <input
								type="text" class="form-control" id="diaChi" name="diaChi"
								required>
						</div>
						<div class="mb-3">
							<label for="soDienThoai" class="form-label">Số Điện Thoại</label>
							<input type="text" class="form-control" id="soDienThoai"
								name="soDienThoai" required>
						</div>
						<div class="mb-3">
							<label for="ghiChu" class="form-label">Ghi Chú</label>
							<textarea class="form-control" id="ghiChu" name="ghiChu"></textarea>
						</div>
						<div class="mb-3">
							<label for="hinhThuc" class="form-label">Hình thức</label> <select
								class="form-select" id="hinhThuc" name="hinhThuc" required>
								<option value="COD">COD</option>
								<option value="VNpay">VNpay</option>
							</select>
						</div>

						<div class="mb-3">
							<label for="email" class="form-label">Email</label> <input
								type="email" class="form-control" id="email" name="email"
								required>
						</div>
						<button type="submit" class="btn btn-primary">Lưu Thay
							Đổi</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap JS and Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- DataTables JS -->
	<script
		src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
	<script
		src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
	<script>
        $(document).ready(function() {
            $('#orderTable').DataTable({
                language: {
                    url: '//cdn.datatables.net/plug-ins/1.13.4/i18n/vi.json'
                },
                pageLength: 10,
                lengthMenu: [5, 10, 25, 50],
                order: [[0, 'desc']],
                columnDefs: [{
                    orderable: false,
                    targets: 9
                }]
            });
        });

        function openEditModal(id, hoTen, tongTien, trangThai, diaChi, soDienThoai, ghiChu, hinhThuc, email) {
            // Điền dữ liệu vào form modal
            document.getElementById('orderId').value = id;
            document.getElementById('hoTen').value = hoTen;
            document.getElementById('tongTien').value = tongTien;
            document.getElementById('trangThai').value = trangThai;
            document.getElementById('diaChi').value = diaChi;
            document.getElementById('soDienThoai').value = soDienThoai;
            document.getElementById('ghiChu').value = ghiChu || ''; // Nếu ghiChu là null/undefined
            document.getElementById('hinhThuc').value = hinhThuc;
            document.getElementById('email').value = email;
        }
        function deleteOrder(orderId, button) {
            if (confirm('Bạn có chắc muốn xóa đơn hàng này?')) {
                $.ajax({
                    url: 'QuanLioDonHang1',
                    type: 'GET',
                    data: { id: orderId },
                    success: function(response) {
                        // Assuming the server returns a JSON response with a 'success' field
                        if (response.success) {
                            // Remove the table row
                            $(button).closest('tr').remove();
                            // Optionally show a success message
                            showSuccessMessage();
                        } else {
                            alert('Xóa đơn hàng thất bại: ' + (response.message || 'Lỗi không xác định'));
                        }
                    },
                    error: function(xhr, status, error) {
                        alert('Lỗi khi xóa đơn hàng: ' + error);
                    }
                });
            }
        }

        function showSuccessMessage(message) {
            // Add a temporary success message to the page
            const alertHtml = `
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    Xóa đơn hàng thành công
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>`;
            $('.container').prepend(alertHtml);
            // Auto-remove the alert after 3 seconds
            setTimeout(() => {
                $('.alert').alert('close');
            }, 3000);
        }
    </script>
</body>
</html>