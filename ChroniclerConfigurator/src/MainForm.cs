using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using ChroniclerConfigurator.Forms;
using ChroniclerConfigurator.ViewModels;
using System.Xml.Serialization;
using System.IO;
using ChroniclerConfigurator.Data;
using System.Configuration;

namespace ChroniclerConfigurator
{
    public partial class MainForm : Form
    {
        public ChroniclerSettings _settings;
        public ChroniclerSettings Settings
        {
            get
            {
                if (_settings == null)
                {
                    _settings = new ChroniclerSettings();
                    _settings.DataBase = new DataBase();
                    _settings.OpcServers = new List<OpcServer>();
                    _settings.Groups = new List<Group>();
                }

                _settings.DataBase = uiDataBaseTab_GetDataBaseSettings();

                return _settings;
            }
            set
            {
                _settings = value;
            }
        }

        public MainForm()
        {
            InitializeComponent();

            uiDataBaseTab_Authentication.SelectedIndex = 0;
        }

        private void uiTabControl_DrawItem(object sender, DrawItemEventArgs e)
        {
            Graphics g = e.Graphics;
            Brush _textBrush;

            // Get the item from the collection.
            TabPage _tabPage = uiTabControl.TabPages[e.Index];

            // Get the real bounds for the tab rectangle.
            Rectangle _tabBounds = uiTabControl.GetTabRect(e.Index);

            if (e.State == DrawItemState.Selected)
            {

                // Draw a different background color, and don't paint a focus rectangle.
                _textBrush = new SolidBrush(Color.Black);
                g.FillRectangle(new SolidBrush(Color.FromKnownColor(KnownColor.Control)), e.Bounds);
            }
            else
            {
                _textBrush = new System.Drawing.SolidBrush(e.ForeColor);
                e.DrawBackground();
            }


            // Use our own font.
            Font _tabFont = new Font("Arial", (float)14.0, FontStyle.Bold, GraphicsUnit.Pixel);

            // Draw string. Center the text.
            StringFormat _stringFlags = new StringFormat();
            _stringFlags.Alignment = StringAlignment.Near;
            _stringFlags.LineAlignment = StringAlignment.Center;
            _tabBounds.X += 5;
            _tabBounds.Width -= 5;
            g.DrawString(_tabPage.Text, _tabFont, _textBrush, _tabBounds, new StringFormat(_stringFlags));
        }


        //Tab navigation
        private void uiNext_Click(object sender, EventArgs e)
        {
            if (uiTabControl.SelectedIndex == (uiTabControl.TabCount - 1))
            {
                Finish();
            }
            else
            {
                uiTabControl.SelectedIndex++;
            }
        }

        private void uiPrevious_Click(object sender, EventArgs e)
        {
            uiTabControl.SelectedIndex--;
        }

        private void uiTabControl_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (uiTabControl.SelectedIndex == 0)
            {
                uiPrevious.Enabled = false;
            }
            else
            {
                uiPrevious.Enabled = true;
            }

            if (uiTabControl.SelectedIndex == (uiTabControl.TabCount - 1))
            {
                uiNext.Text = "Завершить";
            }
            else
            {
                uiNext.Text = "Далее >";
                uiNext.Enabled = true;
            }
        }
        
        private void uiTabControl_Selecting(object sender, TabControlCancelEventArgs e)
        {
            if (!CheckValidity())
            {
                e.Cancel = true;
            }
        }

        private bool CheckValidity()
        {
            switch (uiTabControl.SelectedTab.Name)
            {
                case "uiOPCServersTab":
                    return uiDataBaseTab_CheckDatabase();
                case "uiGroupsTab":
                    return uiDataBaseTab_CheckDatabase() && uiOPCServersTab_IsAnyOpcServer();
                default:
                    return true;
            }
        }


        //Form closing
        private void uiCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void MainForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            var result = MessageBox.Show("Вы уверены что хотите закрыть приложение?", "Предупреждение", MessageBoxButtons.OKCancel, MessageBoxIcon.Exclamation);
            if (result == System.Windows.Forms.DialogResult.Cancel)
            {
                e.Cancel = true;
            }
        }


        //ToolStripMenu
        private void uiToolStripMenuFileSave_Click(object sender, EventArgs e)
        {
            if (saveChroniclerSettingsDialog.ShowDialog() == DialogResult.OK)
            {
                XmlSerializer xmlSerializer = new XmlSerializer(typeof(ChroniclerSettings));
                 TextWriter textWriter = new StreamWriter(saveChroniclerSettingsDialog.FileName);

                xmlSerializer.Serialize(textWriter, this.Settings);
                textWriter.Close();
            }
        }

        private void uiToolStripMenuFileLoad_Click(object sender, EventArgs e)
        {
            if (loadChroniclerSettingsDialog.ShowDialog() == DialogResult.OK)
            {
                XmlSerializer serializer = new XmlSerializer(typeof(ChroniclerSettings));

                FileStream fs = new FileStream(loadChroniclerSettingsDialog.FileName, FileMode.Open);
                ChroniclerSettings chroniclerSettings;

                chroniclerSettings = serializer.Deserialize(fs) as ChroniclerSettings;
                if (chroniclerSettings != null)
                {
                    Settings = chroniclerSettings;
                    UpdateChroniclerSettings();
                }
            }
        }

        private void UpdateChroniclerSettings()
        {
            uiDataBaseTab_UpdateSettings();
            uiOpcServerBindingSource.DataSource = _settings.OpcServers;
            uiGroupsBindingSource.DataSource = _settings.Groups;
        }


        private void Finish()
        {
            if (Settings.Groups.Any())
            {
                WriteToDB();
            }
            else
            {
                MessageBox.Show("Добовьте группу", "Предупреждение", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }
        }

        private void WriteToDB()
        {
            string connectionStringForChroniclerEntities = ConfigurationManager.ConnectionStrings["ChroniclerEntities"].ConnectionString;
            connectionStringForChroniclerEntities = string.Format(connectionStringForChroniclerEntities, Settings.DataBase.ConnectionString);
            using (ChroniclerEntities chroniclerEntities = new ChroniclerEntities(connectionStringForChroniclerEntities))
            {
                foreach (Group group in Settings.Groups)
                {
                    property_collection_source propertyCollection = new property_collection_source()
                    {
                        source_refresh_interval = group.RefreshInterval,
                        source_description = group.Description,
                        source_group_name = group.GroupName,
                        source_is_active = group.IsActive ? 1 : 0,
                        source_server_id = group.OpcServer.URL
                    };

                    foreach (var prop in group.Properties)
                    {
                        property newProperty = new property()
                        {
                            property_name = prop.Name,
                            tag_name = prop.TagName,
                            last_update_date = DateTime.Now,
                            property_definition_id = 0,
                            property_storage_group_id = 0
                        };
                        propertyCollection.properties.Add(newProperty);
                    }
                    chroniclerEntities.AddObject("ChroniclerEntities." + typeof(property_collection_source).Name, propertyCollection);
                }
                chroniclerEntities.SaveChanges();
            }
        }

        //Can`t move it to GroupsTab.cs - every time when change something on Main form it appeares here
        private void uiGroupsTab_Groups_SelectedIndexChanged(object sender, EventArgs e)
        {
            UpdateFoldersTree();

            if (uiGroupsTab_Groups.SelectedItem != null)
            {
                var selectedGroup = uiGroupsTab_Groups.SelectedItem as Group;
                uiGroupTagsBindingSource.DataSource = selectedGroup.Properties;
            }
            else
            {
                uiGroupTagsBindingSource.DataSource = null;
            }
        }
    }
}
