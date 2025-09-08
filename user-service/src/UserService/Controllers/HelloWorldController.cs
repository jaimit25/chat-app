using Microsoft.AspNetCore.Mvc;

namespace UserService.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class HelloWorldController : ControllerBase
    {
        // GET: /api/helloworld
        [HttpGet]
        public IActionResult Get()
        {
            return Ok(new { message = "Hello World from UserService!" });
        }
    }
}
