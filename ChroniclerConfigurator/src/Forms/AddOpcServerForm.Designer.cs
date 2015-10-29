namespace ChroniclerConfigurator.Forms
{
    partial class AddOpcServerForm
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
            this.components = new System.ComponentModel.Container();
            this.uiHostName = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.uiServers = new System.Windows.Forms.ComboBox();
            this.uiServerBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.uiAdd = new System.Windows.Forms.Button();
            this.uiCancel = new System.Windows.Forms.Button();
            this.uiRefresh = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.uiServerBindingSource)).BeginInit();
            this.SuspendLayout();
            // 
            // uiHostName
            // 
            this.uiHostName.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.uiHostName.Location = new System.Drawing.Point(157, 6);
            this.uiHostName.Name = "uiHostName";
            this.uiHostName.Size = new System.Drawing.Size(349, 29);
            this.uiHostName.TabIndex = 0;
            this.uiHostName.Text = "localhost";
            this.uiHostName.TextChanged += new System.EventHandler(this.CheckValidity);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label1.Location = new System.Drawing.Point(12, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(107, 24);
            this.label1.TabIndex = 1;
            this.label1.Text = "Имя хоста:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label2.Location = new System.Drawing.Point(12, 59);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(131, 24);
            this.label2.TabIndex = 2;
            this.label2.Text = "Имя сервера:";
            // 
            // uiServers
            // 
            this.uiServers.DataSource = this.uiServerBindingSource;
            this.uiServers.DisplayMember = "Name";
            this.uiServers.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.uiServers.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.uiServers.FormattingEnabled = true;
            this.uiServers.Location = new System.Drawing.Point(157, 56);
            this.uiServers.Name = "uiServers";
            this.uiServers.Size = new System.Drawing.Size(463, 32);
            this.uiServers.TabIndex = 3;
            this.uiServers.ValueMember = "Name";
            this.uiServers.TextChanged += new System.EventHandler(this.CheckValidity);
            // 
            // uiServerBindingSource
            // 
            this.uiServerBindingSource.DataSource = typeof(Opc.Server);
            // 
            // uiAdd
            // 
            this.uiAdd.Enabled = false;
            this.uiAdd.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.uiAdd.Location = new System.Drawing.Point(414, 103);
            this.uiAdd.Name = "uiAdd";
            this.uiAdd.Size = new System.Drawing.Size(96, 38);
            this.uiAdd.TabIndex = 4;
            this.uiAdd.Text = "Добавить";
            this.uiAdd.UseVisualStyleBackColor = true;
            this.uiAdd.Click += new System.EventHandler(this.uiAdd_Click);
            // 
            // uiCancel
            // 
            this.uiCancel.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.uiCancel.Location = new System.Drawing.Point(524, 103);
            this.uiCancel.Name = "uiCancel";
            this.uiCancel.Size = new System.Drawing.Size(96, 38);
            this.uiCancel.TabIndex = 5;
            this.uiCancel.Text = "Отменить";
            this.uiCancel.UseVisualStyleBackColor = true;
            this.uiCancel.Click += new System.EventHandler(this.uiCancel_Click);
            // 
            // uiRefresh
            // 
            this.uiRefresh.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.uiRefresh.Location = new System.Drawing.Point(512, 6);
            this.uiRefresh.Name = "uiRefresh";
            this.uiRefresh.Size = new System.Drawing.Size(108, 29);
            this.uiRefresh.TabIndex = 6;
            this.uiRefresh.Text = "Обновить";
            this.uiRefresh.UseVisualStyleBackColor = true;
            this.uiRefresh.Click += new System.EventHandler(this.uiRefresh_Click);
            // 
            // AddOpcServerForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(624, 150);
            this.Controls.Add(this.uiRefresh);
            this.Controls.Add(this.uiCancel);
            this.Controls.Add(this.uiAdd);
            this.Controls.Add(this.uiServers);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.uiHostName);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.Name = "AddOpcServerForm";
            this.Text = "Добавить OPC сервер";
            ((System.ComponentModel.ISupportInitialize)(this.uiServerBindingSource)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox uiHostName;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ComboBox uiServers;
        private System.Windows.Forms.Button uiAdd;
        private System.Windows.Forms.Button uiCancel;
        private System.Windows.Forms.BindingSource uiServerBindingSource;
        private System.Windows.Forms.Button uiRefresh;
    }
}