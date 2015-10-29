using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ChroniclerConfigurator.ViewModels
{
    public class ChroniclerSettings
    {
        public List<OpcServer> OpcServers { get; set; }
        public List<Group> Groups { get; set; }
        public DataBase DataBase { get; set; }
    }
}
