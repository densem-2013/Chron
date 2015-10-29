namespace ChroniclerConfigurator.Forms
{
    partial class CreateChroniklerDBForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.uiCreate = new System.Windows.Forms.Button();
            this.uiDBFileName = new System.Windows.Forms.TextBox();
            this.uiChooseBDFile = new System.Windows.Forms.Button();
            this.saveDBFileDialog = new System.Windows.Forms.SaveFileDialog();
            this.uiChooseLogFile = new System.Windows.Forms.Button();
            this.uiLogFileName = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.uiCancel = new System.Windows.Forms.Button();
            this.saveLogFileDialog = new System.Windows.Forms.SaveFileDialog();
            this.SuspendLayout();
            // 
            // uiCreate
            // 
            this.uiCreate.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.uiCreate.Location = new System.Drawing.Point(325, 103);
            this.uiCreate.Name = "uiCreate";
            this.uiCreate.Size = new System.Drawing.Size(108, 37);
            this.uiCreate.TabIndex = 0;
            this.uiCreate.Text = "Создать";
            this.uiCreate.UseVisualStyleBackColor = true;
            this.uiCreate.Click += new System.EventHandler(this.uiCreate_Click);
            // 
            // uiDBFileName
            // 
            this.uiDBFileName.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.uiDBFileName.Location = new System.Drawing.Point(115, 12);
            this.uiDBFileName.Name = "uiDBFileName";
            this.uiDBFileName.Size = new System.Drawing.Size(388, 29);
            this.uiDBFileName.TabIndex = 1;
            // 
            // uiChooseBDFile
            // 
            this.uiChooseBDFile.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.uiChooseBDFile.Location = new System.Drawing.Point(509, 13);
            this.uiChooseBDFile.Name = "uiChooseBDFile";
            this.uiChooseBDFile.Size = new System.Drawing.Size(38, 29);
            this.uiChooseBDFile.TabIndex = 2;
            this.uiChooseBDFile.Text = "...";
            this.uiChooseBDFile.UseVisualStyleBackColor = true;
            this.uiChooseBDFile.Click += new System.EventHandler(this.uiChooseBDFile_Click);
            // 
            // saveDBFileDialog
            // 
            this.saveDBFileDialog.FileName = "Chronicler.mdf";
            this.saveDBFileDialog.Filter = "SQL Server Database File|*.mdf|All files|*.*";
            // 
            // uiChooseLogFile
            // 
            this.uiChooseLogFile.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.uiChooseLogFile.Location = new System.Drawing.Point(509, 58);
            this.uiChooseLogFile.Name = "uiChooseLogFile";
            this.uiChooseLogFile.Size = new System.Drawing.Size(38, 29);
            this.uiChooseLogFile.TabIndex = 4;
            this.uiChooseLogFile.Text = "...";
            this.uiChooseLogFile.UseVisualStyleBackColor = true;
            this.uiChooseLogFile.Click += new System.EventHandler(this.uiChooseLogFile_Click);
            // 
            // uiLogFileName
            // 
            this.uiLogFileName.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.uiLogFileName.Location = new System.Drawing.Point(115, 57);
            this.uiLogFileName.Name = "uiLogFileName";
            this.uiLogFileName.Size = new System.Drawing.Size(388, 29);
            this.uiLogFileName.TabIndex = 3;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label1.Location = new System.Drawing.Point(12, 15);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(94, 24);
            this.label1.TabIndex = 5;
            this.label1.Text = "Файл БД:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label2.Location = new System.Drawing.Point(12, 60);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(97, 24);
            this.label2.TabIndex = 6;
            this.label2.Text = "Лог файл:";
            // 
            // uiCancel
            // 
            this.uiCancel.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.uiCancel.Location = new System.Drawing.Point(439, 103);
            this.uiCancel.Name = "uiCancel";
            this.uiCancel.Size = new System.Drawing.Size(108, 37);
            this.uiCancel.TabIndex = 7;
            this.uiCancel.Text = "Отмена";
            this.uiCancel.UseVisualStyleBackColor = true;
            this.uiCancel.Click += new System.EventHandler(this.uiCancel_Click);
            // 
            // saveLogFileDialog
            // 
            this.saveLogFileDialog.FileName = "Chronicler_log.ldf";
            this.saveLogFileDialog.Filter = "SQL Server Transaction Log File|*.ldf|All files|*.*";
            // 
            // CreateChroniklerDBForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(552, 149);
            this.Controls.Add(this.uiCancel);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.uiChooseLogFile);
            this.Controls.Add(this.uiLogFileName);
            this.Controls.Add(this.uiChooseBDFile);
            this.Controls.Add(this.uiDBFileName);
            this.Controls.Add(this.uiCreate);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.Name = "CreateChroniklerDBForm";
            this.Text = "Создание БД";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.CreateChroniklerDBForm_FormClosing);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button uiCreate;
        private System.Windows.Forms.TextBox uiDBFileName;
        private System.Windows.Forms.Button uiChooseBDFile;
        private System.Windows.Forms.SaveFileDialog saveDBFileDialog;
        private System.Windows.Forms.Button uiChooseLogFile;
        private System.Windows.Forms.TextBox uiLogFileName;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button uiCancel;
        private System.Windows.Forms.SaveFileDialog saveLogFileDialog;
    }
}