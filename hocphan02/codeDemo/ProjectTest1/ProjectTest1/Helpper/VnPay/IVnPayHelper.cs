using ProjectTest1.ViewModels;

namespace ProjectTest1.Helpper.VnPay
{
    public interface IVnPayHelper
    {
        string CreatePaymentUrl(PaymentInformationViewModel model, HttpContext context);
        PaymentResponseViewModel PaymentExecute(IQueryCollection collections);

    }
}
