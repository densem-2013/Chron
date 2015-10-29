using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;
using ChroniclerConfigurator.Forms;
using ChroniclerConfigurator.ViewModels;
using Opc;
using Opc.Da;
using Factory = OpcCom.Factory;
using Property = ChroniclerConfigurator.ViewModels.Property;
using Server = Opc.Da.Server;
using System.Reflection;

namespace ChroniclerConfigurator
{
    public partial class MainForm : Form
    {
        private void uiGroupsTab_Enter(object sender, EventArgs e)
        {
            UpdateFoldersTree();
        }


        //private void AddNode(Server opcServer, TreeNode treeNode)
        //{
        //    ItemIdentifier itemId;
        //    BrowsePosition position;
        //    BrowseFilters filters = new BrowseFilters() { BrowseFilter = browseFilter.branch };

        //    if (treeNode.FullPath == opcServer.Name)
        //    {
        //        itemId = null;
        //    }
        //    else
        //    {
        //        //int serverNameLength = opcServer.Name.Length;
        //        //string itemIdentifier = treeNode.FullPath.Substring(serverNameLength + 1);
        //        itemId = new ItemIdentifier(treeNode.Name);
        //    }

        //    BrowseElement[] elements = opcServer.Browse(itemId, filters, out position);
        //    if (elements == null)
        //    {
        //        return;
        //    }
           
        //    foreach (var element in elements)
        //    {
        //        treeNode.Nodes.Add(element.Name).Name = element.ItemName;
        //    }
        //    //foreach (TreeNode node in treeNode.Nodes)
        //    //{
        //    //    AddNode(opcServer, node);
        //    //}
        //}

        private void UpdateFoldersTree()
        {
            uiGroupsTab_AllFoldersTreeView.Nodes.Clear();
            List<OpcServer> opcServers;

            if (uiGroupsTab_Groups.SelectedItem == null)
            {
                opcServers = Settings.OpcServers;
            }
            else
            {
                var selectedGroup = uiGroupsTab_Groups.SelectedItem as Group;
                opcServers = new List<OpcServer>();
                opcServers.Add(selectedGroup.OpcServer);
            }

            foreach (var opcServer in opcServers)
            {
                string urlstring = opcServer.URL;
                Server server = new Server(new Factory(), new URL(urlstring));
                if (opcServer.RootNode == null)
                {
                    var newNode = uiGroupsTab_AllFoldersTreeView.Nodes.Add(server.Name);
                    server.Connect();
                    //AddNode(server, newNode);
                    UpdateFolderData(newNode);
                    server.Disconnect();
                    opcServer.RootNode = newNode;
                }
                else
                {
                    uiGroupsTab_AllFoldersTreeView.Nodes.Add(opcServer.RootNode);
                }
            }

            if (uiGroupsTab_AllFoldersTreeView.Nodes != null)
            {
                foreach (TreeNode node in uiGroupsTab_AllFoldersTreeView.Nodes)
                {
                    node.Expand();
                }
            }
            UpdateFolderData(uiGroupsTab_AllFoldersTreeView.SelectedNode);
        }

        private void UpdateFolderData(TreeNode node)
        {
            if (node == null)
            {
                uiFolderTagsBindingSource.DataSource = null;
                return;
            }

            //Add items to folder, read from OPC Server if first time
            var folderTags = node.Tag as List<BrowseElement>;
            if (folderTags == null)
            {
                TreeNode rootNode = node;
                while (rootNode.Parent != null)
                {
                    rootNode = rootNode.Parent;
                }
                
                var opcServer = Settings.OpcServers.Where(os => rootNode.FullPath == os.ServerName).Single();
                string urlstring = opcServer.URL;
                Server server = new Server(new Factory(), new URL(urlstring));
                server.Connect();

                BrowsePosition position;
                BrowseFilters filters = new BrowseFilters() { BrowseFilter = browseFilter.all };
                ItemIdentifier itemId = null;

                if (node.FullPath != server.Name)
                {
                    itemId = new ItemIdentifier(node.Name);
                }

                BrowseElement[] elements = server.Browse(itemId, filters, out position);
                server.Disconnect();

                var items = elements.Where(e => e.IsItem);
                if (items.Any())
                {
                    folderTags = items.ToList();
                }
                else
                {
                    folderTags = new List<BrowseElement>();
                }

                var folders = elements.Where(e => e.IsItem == false);
                if(folders.Any())
                {
                    foreach (var element in elements.Where(e => !e.IsItem))
                    {
                        node.Nodes.Add(element.Name).Name = element.ItemName;
                    }
                }

                node.Tag = folderTags;
            }

            //Exlude elements which already are in group
            folderTags = folderTags.ToList();
            var selectedGroup = uiGroupsTab_Groups.SelectedItem as Group;
            if (selectedGroup != null)
            {
                if (selectedGroup.Properties != null)
                {
                    foreach (var property in selectedGroup.Properties)
                    {
                        folderTags.RemoveAll(t => t.ItemName == property.TagName);
                    }
                }
            }

            uiFolderTagsBindingSource.DataSource = folderTags;

            //if (elements != null)
            //{
            //    var itemsIDs = new List<ItemIdentifier>();
            //    foreach (var element in elements)
            //    {
            //        itemsIDs.Add(new ItemIdentifier(element.ItemName));
            //    }

            //    var prid = new List<PropertyID>();
            //    prid.Add(new PropertyID(1));
            //    prid.Add(new PropertyID(2));

            //    var tst = server.GetProperties(itemsIDs.ToArray(), prid.ToArray(), true);
            //}
        }


        private void EnableButtons()
        {
            if (uiGroupsTab_FolderTagsListBox.SelectedItem == null || uiGroupsTab_Groups.SelectedItem == null)
            {
                uiGroupsTab_Add.Enabled = false;
            }
            else
            {
                uiGroupsTab_Add.Enabled = true;
            }
            if (uiGroupsTab_TagsInGroup.SelectedRows.Count == 0)
            {
                uiGroupsTab_Delete.Enabled = false;
            }
            else
            {
                uiGroupsTab_Delete.Enabled = true;
            }
        }
        
        private void uiGroupsTab_AllFoldersTreeView_AfterSelect(object sender, TreeViewEventArgs e)
        {
            UpdateFolderData(uiGroupsTab_AllFoldersTreeView.SelectedNode);
        }
        
        private void uiGroupsTab_FolderTagsListBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            EnableButtons();
        }

        private void uiGroupsTab_TagsInGroup_CurrentCellChanged(object sender, EventArgs e)
        {
            EnableButtons();
        }


        private void uiGroupsTab_GroupsManagementToolStripAdd_Click(object sender, EventArgs e)
        {
            var window = new GroupForm();
            Group newGroup = window.Init(null, Settings.OpcServers);

            if (newGroup != null)
            {
                Settings.Groups.Add(newGroup);
                uiGroupsBindingSource.DataSource = null;
                uiGroupsBindingSource.DataSource = Settings.Groups;
            }
        }
        
        private void uiGroupsTab_GroupsManagementToolStripEdit_Click(object sender, EventArgs e)
        {
            var selectedGroup = uiGroupsTab_Groups.SelectedItem as Group;
            if (selectedGroup == null)
            {
                MessageBox.Show("Выберите группу", "Предупреждение", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return;
            }

            var window = new GroupForm();
            selectedGroup = window.Init(selectedGroup, Settings.OpcServers);

            uiGroupsBindingSource.DataSource = null;
            uiGroupsBindingSource.DataSource = Settings.Groups;
        }

        private void uiGroupsTab_GroupsManagementToolStripRemove_Click(object sender, EventArgs e)
        {

            var selectedGroup = uiGroupsTab_Groups.SelectedItem as Group;
            if (selectedGroup == null)
            {
                MessageBox.Show("Выберите группу", "Предупреждение", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return;
            }

            var result = MessageBox.Show("Вы уверены что хотите удалить группу "
                + selectedGroup.GroupName + "?", "Предупреждение",
                MessageBoxButtons.YesNo,
                MessageBoxIcon.Exclamation);

            if (result == DialogResult.Yes)
            {
                Settings.Groups.Remove(selectedGroup);
                uiGroupsBindingSource.DataSource = null;
                uiGroupsBindingSource.DataSource = Settings.Groups;
            }
        }

        private void uiGroupsTab_GroupsManagementToolStripPrevious_Click(object sender, EventArgs e)
        {
            if (uiGroupsTab_Groups.SelectedIndex > 0)
            {
                uiGroupsTab_Groups.SelectedIndex--;
            }
        }

        private void uiGroupsTab_GroupsManagementToolStripNext_Click(object sender, EventArgs e)
        {
            if (uiGroupsTab_Groups.SelectedIndex < Settings.Groups.Count - 1)
            {
                uiGroupsTab_Groups.SelectedIndex++;
            }
        }

        
        private void uiGroupsTab_Add_Click(object sender, EventArgs e)
        {
            if (uiGroupsTab_FolderTagsListBox.SelectedItem == null || uiGroupsTab_FolderTagsListBox.SelectedItem == null)
            {
                return;
            }

            var selectedGroup = uiGroupsTab_Groups.SelectedItem as Group;
            var selectedTagInFolder = uiGroupsTab_FolderTagsListBox.SelectedItem as BrowseElement;
            var folderTags = uiFolderTagsBindingSource.DataSource as List<BrowseElement>;

            Int16 typeID = GetTagCanonicalType(selectedTagInFolder.ItemName);
            var property = new Property()
            {
                Name = selectedTagInFolder.ItemName,
                TagName = selectedTagInFolder.ItemName,
                ValueTypeId = typeID
            };
            selectedGroup.AddPropery(property);
            folderTags.Remove(selectedTagInFolder);

            uiGroupTagsBindingSource.DataSource = null;
            uiGroupTagsBindingSource.DataSource = selectedGroup.Properties;
            uiFolderTagsBindingSource.DataSource = null;
            uiFolderTagsBindingSource.DataSource = folderTags;
        }

        private void uiGroupsTab_Delete_Click(object sender, EventArgs e)
        {
            var selectedGroup = uiGroupsTab_Groups.SelectedItem as Group;
            var selectedPropertyInGroup = uiGroupsTab_TagsInGroup.SelectedRows[0].DataBoundItem as Property;

            selectedGroup.RemovePropery(selectedPropertyInGroup);

            uiGroupTagsBindingSource.DataSource = null;
            uiGroupTagsBindingSource.DataSource = selectedGroup.Properties;
            UpdateFolderData(uiGroupsTab_AllFoldersTreeView.SelectedNode);
        }


        private Int16 GetTagCanonicalType(string itemName)
        {
            const int ItemCanonicalDataTypeProperty = 1;

            TreeNode rootNode = uiGroupsTab_AllFoldersTreeView.SelectedNode;
            while (rootNode.Parent != null)
            {
                rootNode = rootNode.Parent;
            }

            var opcServer = Settings.OpcServers.Where(os => rootNode.FullPath == os.ServerName).Single();
            string urlstring = opcServer.URL;
            Server server = new Server(new Factory(), new URL(urlstring));
            server.Connect();

            ItemIdentifier [] itemIdentifiers = new ItemIdentifier[] {new ItemIdentifier(itemName)};
            PropertyID[] propertyIDs = new PropertyID[] { new PropertyID(ItemCanonicalDataTypeProperty) };

            var result = server.GetProperties(itemIdentifiers, propertyIDs, true);

            server.Disconnect();

            var resultType = result[0][0].Value.GetType();
            PropertyInfo nameProperty = resultType.GetProperty("Name");
            string name = nameProperty.GetValue(result[0][0].Value, null) as string;

            switch (name.ToLower())
            {
                case "string":
                case "char":
                    return 0;
                case "int16":
                case "int32":
                case "int64":
                case "uint16":
                case "uint32":
                case "uint64":
                    return 1;
                case "boolean":
                    return 2;
                case "decimal":
                case "double":
                    return 3;
                case "datetime":
                case "datetimeoffset":
                    return 4;
                default:
                    return 0;
            }
        }
    }
}