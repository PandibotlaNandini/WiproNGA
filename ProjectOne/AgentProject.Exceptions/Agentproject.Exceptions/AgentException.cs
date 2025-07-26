using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Agentproject.Exceptions
{
    public class AgentException : ApplicationException
    {
        public AgentException() { }

        public AgentException(string message) : base(message) { }
    }
}
