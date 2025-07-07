<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>Quản Lý Sản Phẩm</title>
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
    rel="stylesheet">
<!-- Bootstrap 5 JS Bundle -->
<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
body {
    margin: 0;
}
.container {
    display: flex;
    min-height: 100vh;
    padding: 0;
}
.custom-container {
    max-width: 12000px;
    width: 100%;
}
.sidebar {
    width: 250px;
    background: #f5f5f5;
    padding: 15px;
    border-right: 1px solid #ccc;
    flex-shrink: 0;
    position: relative;
    left: 0;
    z-index: 1;
}
.content {
    flex: 1;
    padding: 20px;
    margin-left: 250px;
    padding-left: 50px;
    padding-right: 50px;
    position: relative;
    z-index: 0;
    overflow-x: auto;
}
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}
th, td {
    padding: 10px;
    border: 1px solid #ccc;
    text-align: center;
}
th {
    background-color: #f5f5f5;
}
.btn {
    padding: 6px 12px;
    margin: 2px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    color: white;
}
.btn-edit {
    background-color: #17a2b8;
}
.btn-delete {
    background-color: #dc3545;
}
.btn-add {
    background-color: #28a745;
    margin-bottom: 10px;
}
form input, form select, form textarea {
    margin-bottom: 8px;
    width: 100%;
    padding: 6px;
    box-sizing: border-box;
}
.sidebar * {
    position: static !important;
}
@media (max-width: 768px) {
    .container {
        flex-direction: column;
    }
    .sidebar {
        width: 100%;
        border-right: none;
        border-bottom: 1px solid #ccc;
    }
    .content {
        margin-left: 0;
        padding: 10px;
        padding-left: 50px;
        padding-right: 50px;
    }
}
.alert {
    margin-bottom: 15px;
}
/* Pagination styles */
.pagination {
    display: flex;
    justify-content: center;
    margin-top: 20px;
}
.pagination a {
    color: #007bff;
    padding: 8px 16px;
    text-decoration: none;
    border: 1px solid #ddd;
    margin: 0 4px;
    border-radius: 4px;
}
.pagination a.active {
    background-color: #007bff;
    color: white;
    border: 1px solid #007bff;
}
.pagination a:hover:not(.active) {
    background-color: #ddd;
}
</style>
</head>
<body>
<div class="container custom-container">
    <jsp:include page="slierBar.jsp" />
    <div class="content">
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
        <h2>Quản Lý Sản Phẩm</h2>
        <button type="button" class="btn btn-primary mb-3" onclick="hienForm()">Thêm mới sản phẩm</button>
        <div id="formThemMoi" class="card p-3 mb-3" style="display: none;">
            <form action="sanPhamController" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="them">
                <input type="text" name="tenSanPham" class="form-control mb-2" placeholder="Tên sản phẩm" required />
                <input type="number" name="gia" class="form-control mb-2" placeholder="Giá" required />
                <textarea name="moTa" class="form-control mb-2" placeholder="Mô tả" rows="3"></textarea>
                <input type="file" name="anh" />
                <select name="danhMucId" class="form-select mb-2">
                    <c:forEach var="dm" items="${danhMuc}">
                        <option value="${dm.id}">${dm.tenDanhMuc}</option>
                    </c:forEach>
                </select>
                <input type="number" name="soLuong" class="form-control mb-2" placeholder="Số lượng" required />
                <div class="d-flex justify-content-between">
                    <button type="submit" class="btn btn-success"><i class="fas fa-plus"></i> Thêm mới</button>
                    <button type="button" class="btn btn-secondary" onclick="anForm()">Hủy</button>
                </div>
            </form>
        </div>
   <div class="d-flex justify-content-center mb-3">
    <input type="text" id="searchInput" class="form-control form-control-sm w-50 text-center" 
           placeholder="Tìm kiếm sản phẩm..." oninput="searchProduct()">
</div>

<table id="productTable" class="table">
    <thead>
        <tr>
            <th style="width: 100px;">Tên Sản Phẩm</th>
            <th style="width: 130px;">Giá</th>
            <th style="width: 430px;">Mô Tả</th>
            <th>Ảnh</th>
            <th style="width: 120px;">Tên Danh Mục</th>
            <th style="width: 80px;">Số Lượng</th>
            <th style="width: 195px;">Hành Động</th>

        </tr>
    </thead>
    <tbody>
        <c:forEach var="sp" items="${pagedSanPham}">
            <tr class="product-row"> <!-- Added product-row class -->
                <td class="product-name">${sp.tenSanPham}</td> <!-- Added product-name class -->
                <td>
                    <fmt:setLocale value="vi_VN" />
                    <fmt:formatNumber value="${sp.gia}" type="number" groupingUsed="true" minFractionDigits="0" /> VNĐ
                </td>
                <td>${sp.moTa}</td>
                <td><img src="images/${sp.anh}" alt="Ảnh SP" width="90" /></td>
                <td>${sp.tenDanhMuc}</td>
                <td>${sp.soLuong}</td>
                <td>
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-warning btn-edit" data-id="${sp.id}" data-name="${sp.tenSanPham}"
                                data-desc="${sp.moTa}" data-price="${sp.gia}" data-category="${sp.danhMucId}"
                                data-quantity="${sp.soLuong}" data-image="${sp.anh}" data-bs-toggle="modal"
                                data-bs-target="#productModal">
                            <i class="fas fa-edit"></i> Sửa
                        </button>
                        <form action="sanPhamController" method="post">
                            <input type="hidden" name="productId" value="${sp.id}" />
                            <button class="btn btn-danger" type="submit" name="action" value="xoa"
                                    onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này không?');">
                                <i class="fas fa-trash"></i> Xóa
                            </button>
                        </form>
                    </div>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<!-- Pagination (unchanged) -->
<div class="pagination" id="pagination">
    <c:if test="${currentPage > 1}">
        <a href="quanLiSanPhamController?page=${currentPage - 1}">« Trước</a>
    </c:if>
    <c:forEach begin="1" end="${totalPages}" var="i">
        <c:choose>
            <c:when test="${i == currentPage}">
                <a class="active">${i}</a>
            </c:when>
            <c:otherwise>
                <a href="quanLiSanPhamController?page=${i}">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <c:if test="${currentPage < totalPages}">
        <a href="quanLiSanPhamController?page=${currentPage + 1}">Tiếp »</a>
    </c:if>
</div>
</div>
    <div class="modal fade" id="productModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <form id="productForm" method="post" action="sanPhamController" class="modal-content" enctype="multipart/form-data">
                <input type="hidden" name="action" value="sua">
                <div class="modal-header">
                    <h5 class="modal-title">Sửa Sản Phẩm</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="productId" name="id">
                    <div class="mb-3">
                        <label>Tên sản phẩm</label>
                        <input type="text" id="productName" name="tenSanPham" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label>Mô tả</label>
                        <input type="text" id="productDesc" name="moTa" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label>Giá</label>
                        <input type="number" id="productPrice" name="gia" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label>Số lượng</label>
                        <input type="number" id="productQuantity" name="soLuong" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label>Danh mục</label>
                        <select id="productCategory" name="danhMuc" class="form-select" required>
                            <option value="">-- Chọn danh mục --</option>
                            <c:forEach var="cat" items="${danhMuc}">
                                <option value="${cat.id}">${cat.tenDanhMuc}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label>Ảnh sản phẩm</label>
                        <input type="file" id="productImage" name="anh" class="form-control">
                        <label>Ảnh sản phẩm hiện tại</label><br>
                        <img id="previewImage" src="" alt="Ảnh sản phẩm" width="120" class="mb-2 d-block" />
                        <input type="hidden" name="anhCu" id="oldImage">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary" id="modalSubmitBtn">Lưu</button>
                </div>
            </form>
        </div>
    </div>
</div>
<script>
document.addEventListener("DOMContentLoaded", function () {
    // Sử dụng event delegation để xử lý nút "Sửa"
    document.body.addEventListener("click", function (event) {
        if (event.target.closest(".btn-edit")) {
            const button = event.target.closest(".btn-edit");
            const id = button.dataset.id;
            const name = button.dataset.name ? button.dataset.name.trim() : '';
            const desc = button.dataset.desc || '';
            const price = button.dataset.price ? parseInt(button.dataset.price) || 0 : 0;
            const quantity = button.dataset.quantity ? parseInt(button.dataset.quantity) || 0 : 0;
            const category = button.dataset.category || '';
            const image = button.dataset.image || '';

            // Điền dữ liệu vào form
            document.getElementById("productId").value = id;
            document.getElementById("productName").value = name;
            document.getElementById("productDesc").value = desc;
            document.getElementById("productPrice").value = price;
            document.getElementById("productQuantity").value = quantity;
            document.getElementById("productCategory").value = category;
            document.getElementById("oldImage").value = image;
            document.getElementById("previewImage").src = image ? "images/" + image : '';

            // Log dữ liệu ra console
            console.log("ID:", id);
            console.log("Tên:", name);
            console.log("Mô tả:", desc);
            console.log("Giá (chuỗi):", button.dataset.price);
            console.log("Giá (parseInt):", price);
            console.log("Số lượng:", quantity);
            console.log("Danh mục:", category);
            console.log("Ảnh:", image);

            // Cập nhật nút submit trong modal
            const submitBtn = document.getElementById("modalSubmitBtn");
            submitBtn.value = "sua";
            submitBtn.textContent = "Cập nhật";
        }
    });
});

document.getElementById("productImage").addEventListener("change", function(event) {
    const file = event.target.files[0];
    if (file) {
        const imageURL = URL.createObjectURL(file);
        document.getElementById("previewImage").src = imageURL;
    }
});

function hienForm() {
    $('#formThemMoi').slideDown();
}

function anForm() {
    $('#formThemMoi').slideUp();
}

$(document).ready(function() {
    // Hàm để tải trang sản phẩm mới
    function loadPage(page) {
        $.ajax({
            url: 'quanLiSanPhamController',
            method: 'GET',
            data: { page: page },
            success: function(response) {
                // Cập nhật bảng sản phẩm
                $('#productTable').html($(response).find('#productTable').html());
                // Cập nhật phân trang
                $('#pagination').html($(response).find('#pagination').html());
            },
            error: function() {
                alert('Đã có lỗi xảy ra.');
            }
        });
    }

    // Khi người dùng click vào phân trang
    $(document).on('click', '.pagination a', function(e) {
        e.preventDefault(); // Ngừng hành động mặc định của liên kết
        var page = $(this).attr('href').split('=')[1]; // Lấy số trang từ URL
        loadPage(page); // Gọi AJAX để tải trang mới
    });

    // Tải trang mặc định khi trang load
    loadPage(1);
});

function searchProduct() {
    let input = document.getElementById("searchInput").value.toLowerCase();
    let rows = document.querySelectorAll(".product-row");

    rows.forEach(row => {
        let productName = row.querySelector(".product-name").textContent.toLowerCase();
        row.style.display = productName.includes(input) ? "" : "none";
    });
}
</script>
</body>
</html>