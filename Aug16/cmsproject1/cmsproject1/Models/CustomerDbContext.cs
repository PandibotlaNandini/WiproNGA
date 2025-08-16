using Microsoft.EntityFrameworkCore;

namespace cmsproject1.Models
{
    public class CustomerDbContext : DbContext
    {
        public CustomerDbContext() { }

        public CustomerDbContext(DbContextOptions<CustomerDbContext> options) : base(options)
        {
        }

        //OnConfiguring() method is used to select and configure the data source
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {

        }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Customer>().ToTable("Customer");


        }

        public DbSet<Customer> Customer { get; set; }

    }
}
