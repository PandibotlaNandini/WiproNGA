using Microsoft.AspNetCore.Mvc.RazorPages;

namespace DemoWipro1.Models
{
    public class EmployeeModels : PageModel
    {
        public List<Employ> Employs { get; set; }

        public void OnGet()
        {
            Employs = new List<Employ>
            {
                new Employ{Empno=1,Name="Yamini",Basic=83234},
                new Employ{Empno=2,Name="Uday",Basic=89923},
                new Employ{Empno=3,Name="Ganesh",Basic=92222},

            };
        }

    }
}
