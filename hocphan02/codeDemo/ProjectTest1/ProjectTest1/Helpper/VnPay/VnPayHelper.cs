using Azure;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using ProjectTest1.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace ProjectTest1.Helpper.VnPay
{
    public class VnPayHelper
    {
        private readonly IConfiguration _configuration;

        public VnPayHelper(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public string CreatePaymentUrl(PaymentInformationViewModel model, HttpContext context)
        {
            var tick = DateTime.Now.Ticks.ToString();

            // Thời gian
            var timeZoneId = _configuration["Vnpay:TimeZoneId"] ?? "SE Asia Standard Time";
            var timeZoneById = TimeZoneInfo.FindSystemTimeZoneById(timeZoneId);
            var timeNow = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, timeZoneById);

            var urlCallBack = _configuration["Vnpay:PaymentBackReturnUrl"];

            var vnp_Params = new Dictionary<string, string>
            {
                { "vnp_Version", _configuration["Vnpay:Version"] },
                { "vnp_Command", _configuration["Vnpay:Command"] },
                { "vnp_TmnCode", _configuration["Vnpay:TmnCode"] },
                { "vnp_Amount", ((long)(model.Amount * 100)).ToString() },
                { "vnp_CreateDate", timeNow.ToString("yyyyMMddHHmmss") },
                { "vnp_CurrCode", _configuration["Vnpay:CurrCode"] },
                { "vnp_IpAddr", context.Connection.RemoteIpAddress?.ToString() ?? "127.0.0.1" },
                { "vnp_Locale", _configuration["Vnpay:Locale"] },
                { "vnp_OrderInfo", $"{model.Name} {model.OrderDescription} {model.Amount}" },
                { "vnp_OrderType", string.IsNullOrEmpty(model.OrderType) ? "other" : model.OrderType },
                { "vnp_ReturnUrl", urlCallBack },
                { "vnp_TxnRef", tick },
                { "vnp_BankCode", string.IsNullOrEmpty(_configuration["Vnpay:BankCode"]) ? "VIB" : _configuration["Vnpay:BankCode"] }
            };

            // Sort key alphabet
            // Build dữ liệu query và hashData
            var sortedKeys = vnp_Params.Keys.OrderBy(k => k).ToList();
            var hashData = new StringBuilder();
            var query = new StringBuilder();

            foreach (var key in sortedKeys)
            {
                var value = vnp_Params[key];
                if (!string.IsNullOrEmpty(value))
                {
                    hashData.Append($"{key}={HttpUtility.UrlEncode(value, Encoding.UTF8)}&");
                    query.Append($"{HttpUtility.UrlEncode(key, Encoding.UTF8)}={HttpUtility.UrlEncode(value, Encoding.UTF8)}&");
                }
            }

            // Remove trailing &
            if (hashData.Length > 0) hashData.Length--;
            if (query.Length > 0) query.Length--;

            // Tạo chữ ký dựa trên signData
            string signData = hashData.ToString();
            var hashSecret = _configuration["Vnpay:HashSecret"];
            using (var hmac = new HMACSHA512(Encoding.UTF8.GetBytes(hashSecret)))
            {
                var hashBytes = hmac.ComputeHash(Encoding.UTF8.GetBytes(signData));
                var vnp_SecureHash = BitConverter.ToString(hashBytes).Replace("-", "");
                query.Append($"&vnp_SecureHash={vnp_SecureHash}");
            }

            // Build URL cuối
            var paymentUrl = $"{_configuration["Vnpay:BaseUrl"]}?{query}";
            return paymentUrl;
           
        }

        public Dictionary<string, string> PaymentExecute(IQueryCollection query)
        {
            // Chuyển query sang dictionary
            var response = query.ToDictionary(k => k.Key, v => v.Value.ToString());
            return response;
        }
    }
}
