// See https://aka.ms/new-console-template for more information

using ClientApplication.Dtos.Requests;
using ClientApplication.Dtos.Responses;
using ClientApplication.Http;
using ClientApplication.Services;
using ClientApplication.Stores;
using Refit;
string authenticationBaseUrl = "https://localhost:7043/api/Authentication";
//IRegisterService registerService = RestService.For<IRegisterService>(authenticationBaseUrl);

//await registerService.Register(new RegisterRequest
//{
//    Email = "test@mail.com",
//    UserName = "SingletonSean",
//    Password = "test123",
//    ConfirmPassword = "test123"
//});

ILoginService loginService = RestService.For<ILoginService>(authenticationBaseUrl);

IRefreshService refreshService = RestService.For<IRefreshService>(authenticationBaseUrl);

AuthenticatedUserResponse loginResponse = await loginService.Login(new LoginRequest
{
    UserName = "SingletonSean",
    Password = "test123"
});

string dataBaseUrl = "http://localhost:8889";
TokenStore tokenStore = new TokenStore()
{
    AccessToken = loginResponse.AccessToken,
    RefreshToken = loginResponse.RefreshToken,
    AccessTokenExpirationTime = loginResponse.AccessTokenExpirationTime
};
AutoRefreshHttpMessageHandler autoRefreshHttpMessageHandler = new AutoRefreshHttpMessageHandler(tokenStore, refreshService);
IDataService dataService = RestService.For<IDataService>(new HttpClient(autoRefreshHttpMessageHandler)
{
    BaseAddress = new Uri(dataBaseUrl)
});
DataResponse dataResponse = await dataService.GetData();
Console.ReadKey();