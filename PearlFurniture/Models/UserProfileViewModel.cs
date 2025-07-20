namespace PearlFurniture.Models
{
    public class UserProfileViewModel
    {
        public string FullName { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string PhoneNumber { get; set; } = string.Empty;
        public int? CustomerAge { get; set; }
        public string CustomerAddress { get; set; } = string.Empty;
        public DateTime? CustomerDOB { get; set; }
    }
}



