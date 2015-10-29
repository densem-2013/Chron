using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Data.SqlClient;
using ChroniclerConfigurator.Forms;
using ChroniclerConfigurator.ViewModels;

namespace ChroniclerConfigurator
{
    public partial class MainForm : Form
    {
        private List<string> uiDataBaseTab_ChroniclerTablesList
        {
            get
            {
                var tablesList = new List<string>();

                tablesList.Add("department");
                tablesList.Add("department_class");
                tablesList.Add("department_class_dep");
                tablesList.Add("equipment");
                tablesList.Add("equipment_class");
                tablesList.Add("equipment_class_dep");
                tablesList.Add("property");
                tablesList.Add("property_collection_source");
                tablesList.Add("property_definition");
                tablesList.Add("property_history");
                tablesList.Add("property_storage_group");
                tablesList.Add("property_type");
                
                return tablesList;
            }
        }


        string GetConnectionStringToSQLServer()
        {
            string connectionString;

            if (uiDataBaseTab_Authentication.Text == "SQL Server Authentication")
            {
                connectionString = String.Format("Data Source={0};Integrated Security=false;Uid={1};Pwd={2};", uiDataBaseTab_HostName.Text, uiDataBaseTab_Login.Text, uiDataBaseTab_Password.Text);
            }
            else
            {
                connectionString = String.Format("Data Source={0};Integrated Security=true;", uiDataBaseTab_HostName.Text);
            }
            return connectionString;
        }

        string GetConnectionStringToDataBase()
        {
            string connectionString = GetConnectionStringToSQLServer();
            connectionString += string.Format("Initial Catalog={0};", uiDataBaseTab_DataBaseName.Text);
            return connectionString;
        }


        private void uiDataBaseTab_CheckConnection_Click(object sender, EventArgs e)
        {
            bool isDataBaseGood = uiDataBaseTab_CheckDatabase();
            if (isDataBaseGood)
            {
                MessageBox.Show("Соединение установлено успешно", "Информация", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private bool uiDataBaseTab_CheckDatabase()
        {
            //Check empty fields
            if (uiDataBaseTab_HostName.Text == string.Empty)
            {
                MessageBox.Show("Введите имя хоста", "Предупреждение", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }

            if (uiDataBaseTab_DataBaseName.Text == string.Empty)
            {
                MessageBox.Show("Введите имя базы данных", "Предупреждение", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }

            //Check SQL Server connection
            string connectionString = GetConnectionStringToSQLServer();
            SqlConnection sqlConnection = null;
            try
            {
                sqlConnection = new SqlConnection(connectionString);
                sqlConnection.Open();
            }
            catch(SqlException)
            {
                sqlConnection.Close();
                MessageBox.Show("Ошибка установки соединения с SQL сервером", "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }

            //Check is database exists?
            try
            {
                string sqlCreateDBQuery = string.Format("SELECT database_id FROM sys.databases WHERE Name = '{0}'", uiDataBaseTab_DataBaseName.Text);
                var sqlCommand = new SqlCommand(sqlCreateDBQuery, sqlConnection);
                int databaseID = (int)sqlCommand.ExecuteScalar();
            }
            catch(System.NullReferenceException)
            {
                //sqlConnection.Close();
                var result = MessageBox.Show("На данном сервере отсутсвует база данных " + uiDataBaseTab_DataBaseName.Text + ". Вы хотите создать её?", 
                                "Информация", MessageBoxButtons.YesNo, MessageBoxIcon.Exclamation);
                if (result == System.Windows.Forms.DialogResult.Yes)
                {
                    var window = new CreateChroniklerDBForm();
                    bool isDBCreated = window.Init(connectionString);
                    if (!isDBCreated)
                    {
                        return false;
                    }
                }
                else
                {
                    return false;
                }
            }

            //Check tables in database
            try
            {
                var tablesList = this.uiDataBaseTab_ChroniclerTablesList;
                string sqlQuery = string.Format("use {0};SELECT name FROM sys.sysobjects WHERE (sys.sysobjects.type = 'U')", uiDataBaseTab_DataBaseName.Text);
                var sqlCommand = new SqlCommand(sqlQuery, sqlConnection);
                var sqlDataReader = sqlCommand.ExecuteReader();
                while (sqlDataReader.Read())
                {
                    tablesList.RemoveAll(t => t.Equals( sqlDataReader[0].ToString() ));
                }
                sqlConnection.Close();
                if (tablesList.Any())
                {
                    MessageBox.Show("База данных " + uiDataBaseTab_DataBaseName.Text + " не подходит для Chronicler", 
                        "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                    return false;
                }
                
            }
            catch
            {
                sqlConnection.Close();
                MessageBox.Show("Ошибка установки соединения", "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }

            sqlConnection.Close();
            //MessageBox.Show("Соединение установлено успешно", "Информация", MessageBoxButtons.OK, MessageBoxIcon.Information);
            return true;
        }

        private void uiDataBaseTab_TryConnectToDB()
        {
                
        }


        private void uiDataBaseTab_Authentication_SelectedIndexChanged(object sender, EventArgs e)
        {
            //TODO: Do something with Authentication constant strings
            if (uiDataBaseTab_Authentication.Text == "Windows Authentication")
            {
                uiDataBaseTab_Login.Enabled = false;
                uiDataBaseTab_LoginLabel.Enabled = false;
                uiDataBaseTab_Password.Enabled = false;
                uiDataBaseTab_PasswordLabel.Enabled = false;
            }
            else
            {
                uiDataBaseTab_Login.Enabled = true;
                uiDataBaseTab_LoginLabel.Enabled = true;
                uiDataBaseTab_Password.Enabled = true;
                uiDataBaseTab_PasswordLabel.Enabled = true;
            }
        }


        private DataBase uiDataBaseTab_GetDataBaseSettings()
        {
            var dataBase = new DataBase();
            dataBase.HostName = uiDataBaseTab_HostName.Text;
            dataBase.DataBaseName = uiDataBaseTab_DataBaseName.Text;
            dataBase.Authentification = uiDataBaseTab_Authentication.Text;
            dataBase.Login = uiDataBaseTab_Login.Text;
            dataBase.ConnectionString = GetConnectionStringToDataBase();
            return dataBase;
        }

        private void uiDataBaseTab_UpdateSettings()
        {
            uiDataBaseTab_HostName.Text = _settings.DataBase.HostName;
            uiDataBaseTab_DataBaseName.Text = _settings.DataBase.DataBaseName;
            if (_settings.DataBase.Authentification == "Windows Authentication")
            {
                uiDataBaseTab_Authentication.SelectedIndex = 0;
            }
            else
            {
                uiDataBaseTab_Authentication.SelectedIndex = 1;
            }
            uiDataBaseTab_Login.Text = _settings.DataBase.Login;
            uiDataBaseTab_Password.Text = _settings.DataBase.Password;
        }
    }
}
