using ClientApplication.Dtos.Responses;
using Refit;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClientApplication.Services
{
    internal interface IDataService
    {
        [Get("/Home/data")]
        Task<DataResponse> GetData();
    }
}
