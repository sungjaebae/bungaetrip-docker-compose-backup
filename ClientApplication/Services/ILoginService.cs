using ClientApplication.Dtos.Requests;
using ClientApplication.Dtos.Responses;
using Refit;

namespace ClientApplication.Services
{
    internal interface ILoginService
    {
        [Post("/login")]
        Task<AuthenticatedUserResponse> Login([Body] LoginRequest loginRequest);
    }
}
