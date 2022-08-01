using ClientApplication.Dtos.Requests;
using ClientApplication.Dtos.Responses;
using Refit;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClientApplication.Services
{
    public interface IRefreshService
    {
        [Post("/refresh")]
        Task<AuthenticatedUserResponse> Refresh([Body] RefreshRequest refreshRequest);
    }
}
