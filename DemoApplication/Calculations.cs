using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DemoApplication
{
    internal class Calculations
    {
        #region calculation_class
        #region methods
        public int Sum(int a, int b)
        {
            return a + b;
        }
        public int Sub(int a, int b)
        {
            return a - b;
        }
        public int Mult(int a, int b)
        {
            return a * b;
        }
            #endregion methods
            #region main_method
        static void Main()
        {
            int a, b;
            Console.WriteLine("Enter 2 Numbers  ");
            a = Convert.ToInt32(Console.ReadLine());
            b = Convert.ToInt32(Console.ReadLine());
            Calculations calculation = new Calculations();
            int result = calculation.Sum(a, b);
            Console.WriteLine("Sum is  " + result);
            result = calculation.Sub(a, b);
            Console.WriteLine("Sub is  " + result);
            result = calculation.Mult(a, b);
            Console.WriteLine("Mult is  " + result);
        }
            #endregion main_method
    }
        #endregion calculation_class
}

