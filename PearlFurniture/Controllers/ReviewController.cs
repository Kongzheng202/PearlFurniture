using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PearlFurniture.Data;
using PearlFurniture.Models;
using PearlFurniture.Helpers;

public class ReviewController : Controller
{
    private readonly PearlFurnitureContext _context;

    public ReviewController(PearlFurnitureContext context)
    {
        _context = context;
        
    }

    [HttpGet]
    public IActionResult Create(int productId)
    {
        var review = new Review { ProductId = productId };
        return View(review);  // only for showing the form
    }



    [HttpGet]
    public IActionResult Review(int? productId)
    {
        var products = _context.Products.ToList();
        ViewBag.Products = products;

        var reviews = _context.Reviews
            .Where(r => !productId.HasValue || r.ProductId == productId)
            .OrderBy(r => r.CreatedAt)
            .ToList();

        var chartData = reviews
            .GroupBy(r => r.CreatedAt.Date)
            .Select(g => new
            {
                Date = g.Key.ToString("yyyy-MM-dd"),
                AvgRating = g.Average(r => r.Rating)
            })
            .ToList();


        ViewBag.ChartLabels = chartData.Select(d => d.Date).ToList();
        ViewBag.ChartValues = chartData.Select(d => d.AvgRating).ToList();

        // Sentiment classification
        var sentimentCounts = new Dictionary<string, int> { ["Positive"] = 0, ["Neutral"] = 0, ["Negative"] = 0 };
        foreach (var review in reviews)
        {
            if (!string.IsNullOrEmpty(review.Comment))
            {
                var sentiment = SentimentAnalyzer.AnalyzeComment(review.Comment);
                sentimentCounts[sentiment]++;
            }
        }

        ViewBag.SentimentSummary = sentimentCounts;
        ViewBag.AverageRating = reviews.Any() ? reviews.Average(r => r.Rating) : 0;

        return View("Review", reviews);
    }





    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Create(Review review, IFormFile reviewImage)
    {
        if (ModelState.IsValid)
        {
            

            review.CreatedAt = DateTime.Now;

            try
            {
                _context.Reviews.Add(review);
                await _context.SaveChangesAsync();
                Console.WriteLine("✅ Review saved successfully");
                return RedirectToAction("Review", new { productId = review.ProductId });
            }
            catch (Exception ex)
            {
                Console.WriteLine("❌ Save failed: " + ex.Message);
                ModelState.AddModelError("", "An error occurred while saving the review.");
            }
        }

        return View(review);
    }


}



