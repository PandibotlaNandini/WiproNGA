using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EmployProject.Models
{
    [Serializable]
    public class Employ
    {
        public int Empno { get; set; }
        public string Name { get; set; }
        public string Gender { get; set; }
        public string Dept { get; set; }
        public string Design { get; set; }
        public double Basic { get; set; }

        public Employ() { }

        public Employ(int empno,string name, string gender, string dept, string design, double basic)
        {
            Empno = empno;
            Name = name;
            Gender = gender;
            Dept = dept;
            Design = design;
            Basic = basic;
        }
        public override string ToString()
        {
            return "Employ No" + Empno +
                "Name" + Name +
                "Gender" + Gender +
                "Department" + Dept +
                "Designation" + Design +
                "Basic" + Basic;
        }
    }
}
