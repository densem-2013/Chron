using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using ChroniclerConfigurator.ViewModels;
using ChroniclerConfigurator.Forms;

namespace ChroniclerConfigurator
{
    public partial class MainForm : Form
    {
        //public OPCServersForm()
        //{
        //    InitializeComponent();
        //    OpcServers = new List<OpcServer>();
        //}

        private void uiOPCServersTab_Add_Click(object sender, EventArgs e)
        {
            var window = new AddOpcServerForm();
            OpcServer opcServer = window.Init();
            if (opcServer == null)
            {
                return;
            }
            if(Settings.OpcServers.Where(os => os.HostName == opcServer.HostName && os.ServerName == opcServer.ServerName).Any())
            {
                MessageBox.Show(opcServer.ServerName + " уже есть в списке", "Предупреждение", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }

            Settings.OpcServers.Add(opcServer);

            uiOpcServerBindingSource.DataSource = null;
            uiOpcServerBindingSource.DataSource = Settings.OpcServers;
        }

        private void uiOPCServersTab_Delete_Click(object sender, EventArgs e)
        {
            DataGridViewSelectedRowCollection selectedRows = uiOPCServersTab_OpcServers.SelectedRows;
            foreach (DataGridViewRow selectedRow in selectedRows)
            {
                var opcServer = selectedRow.DataBoundItem as OpcServer;
                Settings.OpcServers.Remove(opcServer);
                //_opcServers.RemoveAll(os => os.HostName == opcServer.HostName && os.ServerName == opcServer.ServerName);
            }

            uiOpcServerBindingSource.DataSource = null;
            uiOpcServerBindingSource.DataSource = Settings.OpcServers;
        }

        private bool uiOPCServersTab_IsAnyOpcServer()
        {
            if (Settings.OpcServers.Any())
            {
                return true;
            }
            else
            {
                MessageBox.Show("Добавте OPC сервер", "Предупреждение", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
        }
    }
}
