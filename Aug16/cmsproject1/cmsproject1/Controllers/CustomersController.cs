using cmsproject1.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace cmsproject1.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CustomersController : ControllerBase
    {
        private readonly CustomerDbContext _context;

        public CustomersController(CustomerDbContext context)
        {
            _context = context;
        }

        // GET: api/Customers
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Customer>>> GetCustomers()
        {
            return await _context.Customer.ToListAsync();
        }

        // GET: api/Customers/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Customer>> GetCustomer(int id)
        {
            var customer = await _context.Customer.FindAsync(id);
            if (customer == null)
            {
                return NotFound(new { message = "Customer not found" });
            }
            return Ok(customer);
        }

        // GET: api/Customers/byusername/{username}
        [HttpGet("byusername/{username}")]
        public async Task<ActionResult<Customer>> GetCustomerByUsername(string username)
        {
            var customer = await _context.Customer
                .FirstOrDefaultAsync(c => c.custUserName.ToLower() == username.ToLower());

            if (customer == null)
            {
                return NotFound(new { message = "Customer not found" });
            }

            return Ok(customer);
        }

        // POST: api/Customers
        [HttpPost]
        public async Task<ActionResult<Customer>> PostCustomer(Customer customer)
        {
            // Check for duplicate custId
            if (await _context.Customer.AnyAsync(c => c.custId == customer.custId))
            {
                return BadRequest(new { message = "Customer ID already exists" });
            }

            // Optionally, you can hash password here or in frontend
            // customer.custPassword = BCrypt.Net.BCrypt.HashPassword(customer.custPassword);

            _context.Customer.Add(customer);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetCustomer), new { id = customer.custId }, customer);
        }

        // POST: api/Customers/login
        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] Login login)
        {
            if (login == null || string.IsNullOrEmpty(login.Username) || string.IsNullOrEmpty(login.Password))
            {
                return BadRequest(new { message = "Username and password are required" });
            }

            var customer = await _context.Customer
                .FirstOrDefaultAsync(c => c.custUserName == login.Username
                                       && c.custPassword == login.Password);

            if (customer == null)
            {
                return Unauthorized(new { message = "Invalid username or password" });
            }

            return Ok(new { message = "Login successful", customer });
        }
    }

    // DTO for login
    public class Login
    {
        public string Username { get; set; }
        public string Password { get; set; }
    }
}
