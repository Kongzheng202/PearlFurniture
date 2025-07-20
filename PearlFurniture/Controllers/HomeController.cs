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
        public IActionResult Index() => View();

        // GET: /Home/Shop
        public IActionResult Shop() => View();

        // GET: /Home/Contact
        public IActionResult Contact() => View();

        // GET: /Home/Review
        public IActionResult Review() => View();

        public IActionResult CreateReview() => View();

        // GET: /Home/Privacy
        public IActionResult Privacy() => View();

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}



