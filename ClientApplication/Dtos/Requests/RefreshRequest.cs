using System.ComponentModel.DataAnnotations;

namespace ClientApplication.Dtos.Requests
{
    public class RefreshRequest
    {
        [Required]
        public string RefreshToken { get; set; }
    }
}
