var AppAccount = {
    init: function () {
        $('#changePasswordForm').on('submit', function (e) {
            e.preventDefault();
            AppAccount.changePassword();
        });
    },

    changePassword: function () {
        var formData = $('#changePasswordForm').serialize();

        $.ajax({
            type: 'POST',
            url: '/Account/changePassWord',
            data: formData,
            success: function (response) {
                if (response.success) {
                    toastr.success(response.message);
                    $('#changePasswordForm')[0].reset();
                } else {
                    toastr.error(response.message);
                }
            },
            error: function () {
                toastr.error("Lỗi hệ thống.");
            }
        });
    },

    successReset: function (message) {
        if (message && message !== '') {
            Swal.fire({
                icon: 'success',
                title: message,
                showConfirmButton: false,
                timer: 2500
            });

            setTimeout(function () {
                window.location.href = '/Account/Login';
            }, 2500);
        }
    }
};

$(function () {
    AppAccount.init();
});
