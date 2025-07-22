using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Schema;

namespace DemoApplication
{
    internal class MilestoneEx3
    {
        static void Main()
        {
            Console.WriteLine("Enter a sentence:");
            string input = Console.ReadLine();

            string result = ReverseAlternateWords(input);
            Console.WriteLine("Output:");
            Console.WriteLine(result);
        }

        static string ReverseAlternateWords(string sentence)
        {
            if (string.IsNullOrWhiteSpace(sentence))
                return "";

            string[] words = sentence.Split(' ');

            for (int i = 0; i < words.Length; i++)
            {
                if (i % 2 != 0) // Reverse every second word (index 1, 3, 5, ...)
                {
                    char[] charArray = words[i].ToCharArray();
                    Array.Reverse(charArray);
                    words[i] = new string(charArray);
                }
            }

            return string.Join(" ", words);
        }

    }
}
