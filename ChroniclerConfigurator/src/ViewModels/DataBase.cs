using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ChroniclerConfigurator.ViewModels
{
    public class DataBase
    {
        public string HostName { get; set; }
        public string DataBaseName { get; set; }
        public string Authentification { get; set; }
        public string Login { get; set; }
        public string Password { get; set; }
        public string ConnectionString { get; set; }
    }
}
