using System;
using System.ComponentModel.DataAnnotations;

namespace PearlFurniture.Models
{

        public class Review
        {
        public int Id { get; set; }
        
        public int ProductId { get; set; }
        
        public Product? product { get; set; }

        [Range(1, 5)]
         public int Rating { get; set; }

        public string? Comment { get; set; }
        
        public DateTime CreatedAt { get; set; } = DateTime.Now;
        }

    
}
