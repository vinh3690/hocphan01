using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ProjectTest1.Helpper;
using ProjectTest1.Models;
using ProjectTest1.Repository;
using ProjectTest1.ViewModels;
using System.Net.Security;
using System.Security.Claims;

namespace ProjectTest1.Controllers
{
    public class AccountController : Controller
    {
        private readonly DataContext db;
        public AccountController(DataContext db)
        {
            this.db = db;
        }
        [HttpGet]
        public IActionResult Login(string returnUrl = null)
        {
            ViewData["ReturnUrl"] = returnUrl;
            return View();

        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Login(LoginViewModel model, string returnUrl = null)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }
            var user = db.User.FirstOrDefault(u => u.Email == model.Email);
            if (user == null || !BCrypt.Net.BCrypt.Verify(model.Password, user.PasswordHash))
            {
                ModelState.AddModelError(string.Empty, "Email hoặc mật khẩu không đúng!");
                return View(model);
            }
            var claims = new List<Claim>
        {
            new Claim("UserId", user.Id.ToString()),
            new Claim(ClaimTypes.Name, user.FullName),
            new Claim(ClaimTypes.Email, user.Email),
            new Claim(ClaimTypes.Role, user.Role ?? "")
        };
            // Tạo identity và principal
            var identity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
            var principal = new ClaimsPrincipal(identity);

            // Đăng nhập
            await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, principal);
            if (!string.IsNullOrEmpty(returnUrl) && Url.IsLocalUrl(returnUrl))
            {
                return Redirect(returnUrl);
            }

            return RedirectToAction("Index", "Home");
        }
        [HttpGet]
        public IActionResult Register()
        {
            return View();

        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Register(RegisterViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }
            var user = db.User.FirstOrDefault(u => u.Email == model.Email);
            if (user != null)
            {
                ModelState.AddModelError(string.Empty, "Email đã tồn tại!");
                return View(model);
            }
            var newUser = new UserModel
            {
                Id = Guid.NewGuid(),
                Email = model.Email,
                PasswordHash = BCrypt.Net.BCrypt.HashPassword(model.Password), // dùng thư viện BCrypt để mã hóa
                FullName = model.FullName,
                Phone = model.Phone,
                Address = model.Address,
                CreatedAt = DateTime.Now,
                IsEmailConfirmed = false
            };
            db.User.Add(newUser);
            db.SaveChanges();
            return RedirectToAction("Login", "Account");
        }
        [Authorize]
        [HttpGet]
        public async Task<IActionResult> changePassWord()
        {
            var email = User.FindFirst(ClaimTypes.Email)?.Value;
            var model = new ChangePassWordViewModel
            {
                Email = email
            };
            return PartialView(model);
        }
        [Authorize]
        [HttpPost]
        public async Task<IActionResult> changePassWord(ChangePassWordViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return Json(new { success = false, message = "Dữ liệu không hợp lệ!" });
            }
            var user = db.User.FirstOrDefault(u => u.Email == model.Email);
            if (user == null)
            {
                return Json(new { success = false, message = "Email không tồn tại!" });
            }
            bool isValid = BCrypt.Net.BCrypt.Verify(model.CurrentPassword, user.PasswordHash);
            if (!isValid)
            {
                return Json(new { success = false, message = "Mật khẩu hiện tại không đúng!" });
            }
            user.PasswordHash = BCrypt.Net.BCrypt.HashPassword(model.NewPassWord);
            db.Update(user);
            await db.SaveChangesAsync();
            return Json(new { success = true, message = "Đổi mật khẩu thành công!" });
        }
        [HttpGet]
        public IActionResult ForgotPassword()
        {
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> ForgotPassword(ForgetPasswordViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }

            var user = await db.User.FirstOrDefaultAsync(u => u.Email == model.Email);
            if (user == null)
            {
                ModelState.AddModelError(String.Empty, "Email không tồn tại trong hệ thống.");
                return View(model);
            }

            // Tạo token tạm thời (đơn giản hoặc dùng Guid)
            var token = Guid.NewGuid().ToString();

            // Lưu token & thời gian hết hạn (ví dụ 30 phút)
            user.ResetToken = token;
            user.ResetTokenExpiry = DateTime.Now.AddMinutes(3);
            await db.SaveChangesAsync();

            // Tạo URL reset
            var resetLink = Url.Action("ResetPassword", "Account", new { email = user.Email, token = token }, Request.Scheme);

            // Gửi email
            var userName = User.FindFirst(ClaimTypes.Name)?.Value ?? "bạn";

            var body = $"Hello {userName},<br>" +
                       $"Nhấn vào liên kết sau để đặt lại mật khẩu: <a href='{resetLink}'>Đặt lại mật khẩu</a>";
            await EmailHelper.SendEmailAsync(user.Email, "Đặt lại mật khẩu", body);

            ViewBag.Message = "Liên kết đặt lại mật khẩu đã được gửi tới email của bạn.";
            return View("ForgotPassword", model);

        }
        [HttpGet]
        [HttpGet]
        public IActionResult ResetPassword(string email, string token)
        {
            var model = new ResetPasswordViewModel
            {
                Email = email,
                Token = token
            };

            return View(model);
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> ResetPassword(ResetPasswordViewModel model)
        {
            var user = db.User.FirstOrDefault(u =>
                u.Email == model.Email &&
                u.ResetToken == model.Token &&
                u.ResetTokenExpiry > DateTime.Now);

            if (user == null)
            {
                ModelState.AddModelError("", "Token không hợp lệ hoặc đã hết hạn.");
                return View(model);
            }
            if (!ModelState.IsValid)
            {
                return View(model);
            }
            // Reset mật khẩu
            user.PasswordHash = BCrypt.Net.BCrypt.HashPassword(model.NewPassword);

            // Xóa token sau khi sử dụng
            user.ResetToken = null;
            user.ResetTokenExpiry = null;

            db.Update(user);
            await db.SaveChangesAsync();

            ViewBag.SuccessMessage = "Mật khẩu đã được đặt lại thành công!";
            return View("ResetPassword");
        }


    }


}
