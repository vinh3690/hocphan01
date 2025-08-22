using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ProjectTest1.Models;
using ProjectTest1.Repository;
using System.Diagnostics;
using System.Security.Claims;

namespace ProjectTest1.Controllers
{
    
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly DataContext _context;

        public HomeController(DataContext context, ILogger<HomeController> logger)
        {
            _context = context;
            _logger = logger;
        }

        public IActionResult Index()
        {
            if (User.Identity.IsAuthenticated)
            {
                ViewBag.fullName = User.FindFirst(ClaimTypes.Name)?.Value ?? "Người dùng";

            }
            return View();
        }
        public IActionResult Detail()
        {
            return View();
        }
        public IActionResult Privacy()
        {
            
            return View();
        }
        [HttpGet]
        public async Task<PartialViewResult> ListData(int page = 1)
        {
            int pageSize = 4;
            List<ProductModel> products = new List<ProductModel>();
            try
            {
                 products = await _context.Product
                .OrderByDescending(p => p.CreatedAt)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToListAsync();
            }catch(Exception ex)
            {

            }
            ViewBag.CurrentPage = page;
            ViewBag.TotalPages = (int)Math.Ceiling((double)_context.Product.Count() / pageSize);
            return PartialView(products);

        }
        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
