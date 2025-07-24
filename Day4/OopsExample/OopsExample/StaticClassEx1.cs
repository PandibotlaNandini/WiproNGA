using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OopsExample
{
    static class Demos
    {
        public static void Show()
        {
            Console.WriteLine("Show Method from Demo Class...");
        }

        public static string Trainer()
        {
            return "Trainer is Prasanna P";
        }
    }
    internal class StaticClassEx1
    {
        static void Main()
        {
            Demos.Show();
            Console.WriteLine(Demos.Trainer());
        }
    }
}
