using Microsoft.AspNetCore.Mvc;
using PearlFurniture.Models;
using System.Collections.Generic;
using System.Linq;

namespace PearlFurniture.Controllers
{
    public class ProductController : Controller
    {
        public IActionResult Details(int id)
        {
            var products = new List<Product>
            {
                new Product { Id = 1, Name = "Luxury Sofa Set", Description = "Stylish and spacious sofa made for modern living spaces.", Price = 1999.00m, Image = "sofas.jpg" },
                new Product { Id = 2, Name = "Queen Bed Frame", Description = "Elegant queen-sized bed with high-quality cushioning and wood frame.", Price = 2399.00m, Image = "beds.jpg" },
                new Product { Id = 3, Name = "Dining Table Set", Description = "Classic wooden table with 6 matching upholstered chairs.", Price = 1499.00m, Image = "dining set.jpg" }
            };

            var product = products.FirstOrDefault(p => p.Id == id);
            if (product == null) return NotFound();

            return View(product);
        }
    }
}


