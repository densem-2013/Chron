using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using ChroniclerConfigurator.ViewModels;

namespace ChroniclerConfigurator.Forms
{
    public partial class GroupForm : Form
    {
        private Group _group;
        private List<OpcServer> _opcServers;

        public Group Init(Group group, List<OpcServer> opcServers)
        {
            _group = group;
            _opcServers = opcServers;

            if (group == null)
            {
                uiCreate.Text = "Создать";
            }
            else
            {
                uiGroupName.Text = group.GroupName;
                uiOpcServer.SelectedItem = group.OpcServer;
                uiRefreshInterval.Value = group.RefreshInterval;
                uiDescription.Text = group.Description;
                uiIsActive.Checked = group.IsActive;

                uiCreate.Text = "Изменить";
            }

            this.ShowDialog();
            return _group;
        }

        public GroupForm()
        {
            InitializeComponent();

            uiRefreshInterval.Maximum = decimal.MaxValue;
        }

        private void GroupForm_Load(object sender, EventArgs e)
        {
            uiOpcServerBindingSource.DataSource = _opcServers;
        }

        private void uiCreate_Click(object sender, EventArgs e)
        {
            if (uiGroupName.Text == string.Empty)
            {
                MessageBox.Show("Введите имя группы", "Предупреждение", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return;
            }

            if (_group == null)
            {
                _group = new Group();
            }

            _group.GroupName = uiGroupName.Text;
            _group.OpcServer = uiOpcServer.SelectedItem as OpcServer;
            _group.RefreshInterval = uiRefreshInterval.Value;
            _group.Description = uiDescription.Text;
            _group.IsActive = uiIsActive.Checked;

            this.Close();
        }

        private void uiCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
