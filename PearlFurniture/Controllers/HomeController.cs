using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using PearlFurniture.Models;

namespace PearlFurniture.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        // GET: /
        public IActionResult Index()
        {
            return View();
        }

        // GET: /Home/Shop
        public IActionResult Shop()
        {
            return View();
        }

        // GET: /Home/Contact
        public IActionResult Contact()
        {
            return View();
        }

        // GET: /Home/Review
        public IActionResult Review()
        {
            return View();
        }

        // GET: /Home/Profile
        public IActionResult Profile()
        {
            return View();
        }

        // GET: /Home/Privacy
        public IActionResult Privacy()
        {
            return View();
        }

        public IActionResult CreateReview()
        {
            return View();
        }

        // GET: /Home/Error
        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}

