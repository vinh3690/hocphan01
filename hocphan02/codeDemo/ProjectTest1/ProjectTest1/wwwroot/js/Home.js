$(document).ready(function () {
    loadData(1); // Tải 4 sản phẩm đầu tiên khi trang vừa load
});

function loadData(pageIndex) {
    $.ajax({
        url: "/Home/ListData",
        type: "get",
        data: { page: pageIndex }, // Gửi pageIndex lên Controller
        success: function (result) {
            $("#product-list").html(result); // Gắn HTML trả về vào div
        },
        error: function () {
            alert("Lỗi tải dữ liệu");
        }
    });
}
