using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using ChroniclerConfigurator.ViewModels;
using Opc;

namespace ChroniclerConfigurator.Forms
{
    public partial class AddOpcServerForm : Form
    {
        private OpcServer _opcServer;

        public AddOpcServerForm()
        {
            InitializeComponent();
        }

        public OpcServer Init()
        {
            this.ShowDialog();
            return _opcServer;
        }

        private void uiAdd_Click(object sender, EventArgs e)
        {
            _opcServer = new OpcServer();
            _opcServer.HostName = uiHostName.Text;
            _opcServer.ServerName = uiServers.Text;
            var opcServer = uiServers.SelectedItem as Server;
            _opcServer.URL = opcServer.Url.ToString();
            this.Close();
        }

        private void uiRefresh_Click(object sender, EventArgs e)
        {
            if (uiHostName.Text == string.Empty)
            {
                return;
            }

            IDiscovery discovery = new OpcCom.ServerEnumerator();

            try
            {
                uiServerBindingSource.DataSource = discovery.GetAvailableServers(Specification.COM_DA_20, uiHostName.Text, null);
                CheckValidity(null, null);
            }
            catch
            {
                MessageBox.Show("OPC сервера не найдены", "Предупреждение", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void CheckValidity(object sender, EventArgs e)
        {
            if (uiHostName.Text == string.Empty || uiServers.Text == string.Empty)
            {
                uiAdd.Enabled = false;
            }
            else
            {
                uiAdd.Enabled = true;
            }
        }

        private void uiCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
