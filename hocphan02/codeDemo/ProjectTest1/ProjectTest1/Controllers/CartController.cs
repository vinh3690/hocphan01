using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ProjectTest1.Models;
using ProjectTest1.Repository;
using ProjectTest1.ViewModels;

namespace ProjectTest1.Controllers
{
    public class CartController : Controller
    {
        private readonly DataContext db;
        public CartController(DataContext db)
        {
            this.db = db;
        }
        public IActionResult Index()
        {
            var userIdStr = User.FindFirst("UserId")?.Value;
            if (userIdStr == null)
            {
                return View("login");
            }
            var cartItems = db.CartItemModels
       .Include(c => c.Cart)  // để lọc theo UserId
       .Include(c => c.ProductVariant)
           .ThenInclude(pv => pv.Size)
       .Include(c => c.ProductVariant)
           .ThenInclude(pv => pv.Color)
       .Include(c => c.ProductVariant)
           .ThenInclude(pv => pv.Product)
       .Where(c => c.Cart.UserId == Guid.Parse(userIdStr))
       .ToList();
            var cartViewModel = cartItems.Select(c => new CartItemViewModel
            {
                ProductVariantId = c.ProductVariantId,
                ProductName = c.ProductVariant.Product.Name,
                ImageUrl = c.ProductVariant.Product.Img,
                UnitPrice = c.ProductVariant.Product.Price,
                Quantity = c.Quantity,
                SizeName = c.ProductVariant.Size?.SizeName ?? "",   // lấy tên size
                ColorName = c.ProductVariant.Color?.ColorName ?? ""  // lấy tên màu
            }).ToList();


            return View(cartViewModel);
        }
        [HttpPost]
        public async Task<JsonResult> AddCart(CartItemViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return Json(new { status = false, message = "Dữ liệu không hợp lệ" });
            }

            try
            {
                // Lấy userId từ Claim
                var userIdStr = User.FindFirst("UserId")?.Value;
                if (string.IsNullOrEmpty(userIdStr) || !Guid.TryParse(userIdStr, out Guid userId))
                {
                    return Json(new { status = false, message = "Người dùng chưa đăng nhập" });
                }

                // Tìm giỏ hàng theo user
                var cart = await db.CartModels
                    .Include(c => c.CartItems)
                    .FirstOrDefaultAsync(c => c.UserId == userId);

                if (cart == null)
                {
                    cart = new CartModel
                    {
                        UserId = userId,
                        CreatedDate = DateTime.Now,
                        CartItems = new List<CartItemModel>()
                    };
                    db.CartModels.Add(cart);
                }

                // Kiểm tra sản phẩm đã có trong giỏ chưa
                var existingItem = cart.CartItems.FirstOrDefault(i => i.ProductVariantId == model.ProductVariantId);
                if (existingItem != null)
                {
                    existingItem.Quantity += model.Quantity;
                }
                else
                {
                    var variant = await db.ProductVariants
                        .Include(v => v.Product)
                        .FirstOrDefaultAsync(v => v.ProductVariantId == model.ProductVariantId);

                    if (variant == null)
                        return Json(new { status = false, message = "Không tìm thấy sản phẩm" });

                    cart.CartItems.Add(new CartItemModel
                    {
                        ProductVariantId = model.ProductVariantId,
                        Quantity = model.Quantity,
                        UnitPrice = variant.Product.Price // hoặc variant.UnitPrice nếu bạn có
                    });
                }

                await db.SaveChangesAsync();

                return Json(new { status = true, message = "Thêm giỏ hàng thành công" });
            }
            catch (Exception ex)
            {
                return Json(new { status = false, message = "Có lỗi: " + ex.Message });
            }
        }
        [HttpGet]
        public IActionResult GetCartCount()
        {
            var userId = User.FindFirst("UserId")?.Value;
            if (userId == null) return Json(new { count = 0 });

            var count = db.CartItemModels
                          .Where(c => c.Cart.UserId == Guid.Parse(userId))
                          .Sum(c => c.Quantity);

            return Json(new { count });
        }
        //[HttpPost]
        //public IActionResult Checkout()
        //{
        //    // Lấy thông tin đơn hàng (ví dụ: tổng tiền)
        //    var amount = 100000; // giả sử 100,000 VND

        //    // Tạo URL thanh toán VNPay
        //    var vnp_Returnurl = "https://localhost:5001/Cart/PaymentReturn"; // URL trả về
        //    var vnp_Url = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
        //    var vnp_TmnCode = "YOUR_TMN_CODE";
        //    var vnp_HashSecret = "YOUR_HASH_SECRET";

        //    var vnpay = new VnPayLibrary();
        //    vnpay.AddRequestData("vnp_Version", "2.1.0");
        //    vnpay.AddRequestData("vnp_Command", "pay");
        //    vnpay.AddRequestData("vnp_TmnCode", vnp_TmnCode);
        //    vnpay.AddRequestData("vnp_Amount", (amount * 100).ToString()); // nhân 100
        //    vnpay.AddRequestData("vnp_CreateDate", DateTime.Now.ToString("yyyyMMddHHmmss"));
        //    vnpay.AddRequestData("vnp_CurrCode", "VND");
        //    vnpay.AddRequestData("vnp_IpAddr", HttpContext.Connection.RemoteIpAddress?.ToString());
        //    vnpay.AddRequestData("vnp_Locale", "vn");
        //    vnpay.AddRequestData("vnp_OrderInfo", "Thanh toan don hang test");
        //    vnpay.AddRequestData("vnp_OrderType", "other");
        //    vnpay.AddRequestData("vnp_ReturnUrl", vnp_Returnurl);
        //    vnpay.AddRequestData("vnp_TxnRef", DateTime.Now.Ticks.ToString());

        //    string paymentUrl = vnpay.CreateRequestUrl(vnp_Url, vnp_HashSecret);

        //    // Redirect sang VNPay
        //    return Redirect(paymentUrl);
        //}


    }
}
