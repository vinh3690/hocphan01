<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<%@ page session="true" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh Toán</title>
    <link rel="stylesheet" href="thanhToan.css">
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
    <div class="container">
        <h2>Thông Tin Thanh Toán</h2>
        <jsp:useBean id="g" class="entity.NguoiDung" scope="session" />

        <c:if test="${not empty message}">
        <% session.removeAttribute("cart"); %>
            <script>
                Swal.fire({
                    icon: 'success',
                    title: 'Thanh toán',
                    text: '${message}',
                    confirmButtonText: 'OK',
                    timer: 3000, // Display for 3 seconds
                    timerProgressBar: true,
                    willClose: () => {
                        window.location.href = "sanPhamController"; // Redirect after alert closes
                    }
                });
            </script>
        </c:if>

        <form id="thanhToanForm" method="post">
            <input type="hidden" name="nguoiDungId" value="${sessionScope.user.id}" />
            <input type="hidden" name="totalAmount" value="${totalAmount}" />

            <div class="form-group">
                <label for="hoTen">Họ và tên:</label>
                <input type="text" id="hoTen" name="hoTen" class="form-control" 
                       value="${sessionScope.user.hoTen}" required>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" class="form-control" 
                       value="${sessionScope.user.email}" required>
            </div>

            <div class="form-group">
                <label for="diaChi">Địa chỉ giao hàng:</label>
                <input type="text" id="diaChi" name="diaChi" class="form-control" value="Vĩnh Phúc" required>
            </div>

            <div class="form-group">
                <label for="soDienThoai">Số điện thoại:</label>
                <input type="tel" id="soDienThoai" name="soDienThoai" class="form-control" 
                       value="${sessionScope.user.phone}" required>
            </div>

            <div class="form-group">
                <label for="ghiChu">Ghi chú:</label>
                <textarea id="ghiChu" name="ghiChu" class="form-control" rows="4"></textarea>
            </div>

            <div class="form-group">
                <label>Tổng tiền:</label>
                <fmt:setLocale value="vi_VN"/>
                <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="₫"/>
            </div>

            <!-- Nút COD / Bank -->
            <button type="button" class="btn btn-success" onclick="confirmAndSubmit('thanhToanController1')">Thanh toán COD/Bank</button>

            <!-- Nút VNPay -->
            <button type="button" class="btn btn-primary" onclick="submitForm('payment')">Thanh toán qua VNPay</button>
        </form>
    </div>

    <script>
        function submitForm(actionUrl) {
            const form = document.getElementById("thanhToanForm");
            form.action = actionUrl;
            form.submit();
        }

        function confirmAndSubmit(actionUrl) {
            Swal.fire({
                title: 'Xác nhận thanh toán?',
                text: "Bạn có chắc muốn thực hiện thanh toán không?",
                icon: 'question',
                showCancelButton: true,
                confirmButtonText: 'Có, thanh toán!',
                cancelButtonText: 'Hủy'
            }).then((result) => {
                if (result.isConfirmed) {
                    const form = document.getElementById("thanhToanForm");
                    form.action = actionUrl;
                    form.submit();
                    // Redirect is handled by the success message block above
                }
            });
        }
    </script>

    <!-- Include jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Include Bootstrap JS if needed -->
    <!-- <script src="path-to-your-bootstrap.js"></script> -->
</body>
</html>