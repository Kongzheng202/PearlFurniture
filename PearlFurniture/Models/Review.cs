using System;
using System.ComponentModel.DataAnnotations;

namespace PearlFurniture.Models
{

        public class Review
        {
            public int Id { get; set; }
            public int ProductId { get; set; }
            public Product? Product { get; set; }


        [Range(1, 5)]
            public int Rating { get; set; }

            public string? Comment { get; set; }

            public string? Quality { get; set; }     // Optional fields
            public string? Performance { get; set; }

            public string? ImagePath { get; set; }  // If media allowed
            public DateTime CreatedAt { get; set; } = DateTime.Now;
        }

    
}
