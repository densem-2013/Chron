using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace ChroniclerConfigurator.ViewModels
{
    public class OpcServer
    {
        public string HostName { get; set; }
        public string ServerName { get; set; }
        public string URL { get; set; }
        [System.Xml.Serialization.XmlIgnoreAttribute]
        public TreeNode RootNode { get; set; }
    }
}
