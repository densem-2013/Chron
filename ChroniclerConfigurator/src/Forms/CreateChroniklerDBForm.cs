using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;
using System.Data.SqlClient;

namespace ChroniclerConfigurator.Forms
{
    public partial class CreateChroniklerDBForm : Form
    {
        private string _connectionString;
        private bool _isEverythingFinished = false;

        private bool IsLocal(string connectionString)
        {
            string dataSource = connectionString.Substring(connectionString.IndexOf("Data Source=") + "Data Source=".Length);

            if (dataSource.StartsWith(".") || dataSource.ToLower().StartsWith("localhost"))
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public bool Init(string connectionString)
        {
            _connectionString = connectionString;

            if (!IsLocal(connectionString))
            {
                uiChooseBDFile.Enabled = false;
                uiChooseLogFile.Enabled = false;
            }

            this.ShowDialog();
            return _isEverythingFinished;
        }

        public CreateChroniklerDBForm()
        {
            InitializeComponent();
        }

        private void uiCreate_Click(object sender, EventArgs e)
        {
            if (uiDBFileName.Text == string.Empty)
            {
                MessageBox.Show("Выберите файл БД", "Информация", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return;
            }

            if (uiLogFileName.Text == string.Empty)
            {
                MessageBox.Show("Выберите лог файл", "Информация", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return;
            }

            try
            {
                CreateDB();
                FillDB();
            }
            catch
            {
                MessageBox.Show("В процессе создания БД Chronicler возникли ошибки", "Информация", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return;
            }

            _isEverythingFinished = true;
            MessageBox.Show("БД Chronicler создана успешно", "Информация", MessageBoxButtons.OK, MessageBoxIcon.Information);
            this.Close();
        }

        private void CreateDB()
        {
            try
            {
                FileInfo file = new FileInfo("scripts\\ChroniclerCreateDB.sql");
                string script = file.OpenText().ReadToEnd();

                string[] splitter = new string[] { "\r\nGO\r\n" };
                string[] commandTexts = script.Split(splitter, StringSplitOptions.RemoveEmptyEntries);

                using (var sqlConnection = new SqlConnection(_connectionString))
                {
                    SqlCommand sqlCommand;

                    foreach (string commandText in commandTexts)
                    {
                        if (sqlConnection.State == ConnectionState.Closed)
                        {
                            sqlConnection.Open();
                        }
                        string x = commandText.Replace("GO", "")
                                              .Replace("InsertFileNameHere", uiDBFileName.Text)
                                              .Replace("InsertLogFileNameHere", uiLogFileName.Text);
                        sqlCommand = new SqlCommand(x, sqlConnection);
                        {
                            sqlCommand.ExecuteNonQuery();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                //TODO: Add log
                throw ex;
            }
        }

        private void FillDB()
        {
            try
            {
                FileInfo file = new FileInfo("scripts\\ChroniclerFillDB.sql");
                string script = file.OpenText().ReadToEnd();

                string[] splitter = new string[] { "\r\nGO\r\n" };
                string[] commandTexts = script.Split(splitter, StringSplitOptions.RemoveEmptyEntries);

                using (var sqlConnection = new SqlConnection(_connectionString))
                {
                    SqlCommand sqlCommand;

                    foreach (string commandText in commandTexts)
                    {
                        if (sqlConnection.State == ConnectionState.Closed)
                        {
                            sqlConnection.Open();
                        }
                        string x = commandText.Replace("GO", "");
                        sqlCommand = new SqlCommand(x, sqlConnection);
                        {
                            sqlCommand.ExecuteNonQuery();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                //TODO: Add log
                throw ex; ;
            }
        }

        private void uiChooseBDFile_Click(object sender, EventArgs e)
        {
            if (saveDBFileDialog.ShowDialog() == DialogResult.OK)
            {
                uiDBFileName.Text = saveDBFileDialog.FileName;
            }
        }

        private void uiChooseLogFile_Click(object sender, EventArgs e)
        {
            if (saveLogFileDialog.ShowDialog() == DialogResult.OK)
            {
                uiLogFileName.Text = saveLogFileDialog.FileName;
            }
        }

        private void CreateChroniklerDBForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (!_isEverythingFinished)
            {
                var result = MessageBox.Show("Вы уверены что хотите отменить создание БД Chronicler?", "Предупреждение", MessageBoxButtons.OKCancel, MessageBoxIcon.Exclamation);
                if (result == System.Windows.Forms.DialogResult.Cancel)
                {
                    e.Cancel = true;
                }
            }
        }

        private void uiCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
