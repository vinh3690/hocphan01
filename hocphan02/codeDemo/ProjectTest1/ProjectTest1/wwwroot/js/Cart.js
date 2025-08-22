var cart = {
    addCart: function () {
        var form = $('#cartForm'); 
        if (!form.valid()) return;
        $.ajax({
            url: '/Cart/AddCart',
            type: 'Post',
            data: form.serialize(),
            success: function (result) {
                if (result.status) {
                    toastr.success(result.message);
                    cart.getCount();
                } else {
                    toastr.error(result.message);
                }
            },
            error: function () {
                alert("Đã có lỗi xảy ra khi tải form.");
            }
        });
    },
    getCount: function () {
        $.ajax({
            url: '/Cart/GetCartCount',
            type: 'Get',
           
            success: function (result) {
                $('#spanCount').text(result.count);

            },
            error: function () {
                alert("Đã có lỗi xảy ra khi tải form.");
            }
        });
    },
    copyQuantity: function (form) {
        form.querySelector('[name="Quantity"]').value =
            document.getElementById("quantityInput").value;
    },
}
$(document).on('submit', '#cartForm', function (e) {
    e.preventDefault(); // Ngăn form submit mặc định
    cart.copyQuantity(this);
    cart.addCart(); // Gọi hàm ajax
});