using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Opc.Da;

namespace ChroniclerConfigurator.ViewModels
{
    public class Group
    {
        private List<Property> _properties;

        public string GroupName { get; set; }
        public OpcServer OpcServer { get; set; }
        public decimal RefreshInterval { get; set; }
        public string Description { get; set; }
        public bool IsActive { get; set; }

        public List<Property> Properties
        {
            get { return _properties; }
        }

        public Group()
        {
            _properties = new List<Property>();
        }

        public void AddPropery(Property property)
        {
            _properties.Add(property);
        }

        public void RemovePropery(Property property)
        {
            _properties.Remove(property);
        }
    }
}
