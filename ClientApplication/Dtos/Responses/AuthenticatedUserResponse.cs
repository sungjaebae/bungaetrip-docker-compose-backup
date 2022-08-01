using System.ComponentModel.DataAnnotations;

namespace ClientApplication.Dtos.Responses
{
    public class AuthenticatedUserResponse
    {
        [Required]
        public string AccessToken { get; set; }
        [Required]
        public DateTime AccessTokenExpirationTime { get; set; }
        [Required]
        public string RefreshToken { get; set; }
    }
}
