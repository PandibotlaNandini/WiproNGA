using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace OopsExample
{
    internal class Demo
    {
        static int count;
        public void Increment()
        {
            count++;
        }
        public void Show()
        {
            Console.WriteLine("Count  " + count);
        }
        static void Main()
        {
            Demo obj1 = new Demo();
            Demo obj2 = new Demo();
            obj1.Increment();
            obj1.Show();
            obj2.Increment();
            obj2.Show();
        }
        
    }
}
