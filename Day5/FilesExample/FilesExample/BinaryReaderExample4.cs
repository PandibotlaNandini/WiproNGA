using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FilesExample
{
    internal class BinaryReaderExample4
    {
        static void Main()
        {
            FileStream fs = new FileStream(@"C:\Users\nandi\OneDrive\WiproTraining\Day5\FilesExample\data.txt", FileMode.Open, FileAccess.Read);
            BinaryReader reader = new BinaryReader(fs);
            int x = reader.ReadInt32();
            string str = reader.ReadString();
            double bas = reader.ReadDouble();
            bool flag = reader.ReadBoolean();
            Console.WriteLine(x);
            Console.WriteLine(str);
            Console.WriteLine(bas);
            Console.WriteLine(flag);
            reader.Close();
            fs.Close();
        }
    }
}
