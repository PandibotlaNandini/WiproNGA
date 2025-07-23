using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DemoSecondLibrary
{
    internal class Third : DemoFirstLibrary.Demo
    {
        public void Test()
        {
            Third third = new Third();
            Console.WriteLine(third.publicStr);
            Console.WriteLine(third.protectedStr);
            Console.WriteLine(third.ipStr);
        }
    }
}
