using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;

namespace JwtExampleDotnet.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class SomeProtectedController : ControllerBase
    {
        [HttpGet]
        public IActionResult GetProtectedData()
        {
            return Ok(new { message = "This is protected data" });
        }
    }
}
