namespace ChroniclerConfigurator.Forms
{
    partial class GroupForm
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
            this.uiGroupName = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.uiDescription = new System.Windows.Forms.TextBox();
            this.uiOpcServer = new System.Windows.Forms.ComboBox();
            this.uiOpcServerBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.uiRefreshInterval = new System.Windows.Forms.NumericUpDown();
            this.uiCreate = new System.Windows.Forms.Button();
            this.uiCancel = new System.Windows.Forms.Button();
            this.label5 = new System.Windows.Forms.Label();
            this.uiIsActive = new System.Windows.Forms.CheckBox();
            ((System.ComponentModel.ISupportInitialize)(this.uiOpcServerBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.uiRefreshInterval)).BeginInit();
            this.SuspendLayout();
            // 
            // uiGroupName
            // 
            this.uiGroupName.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.uiGroupName.Location = new System.Drawing.Point(118, 9);
            this.uiGroupName.Name = "uiGroupName";
            this.uiGroupName.Size = new System.Drawing.Size(233, 26);
            this.uiGroupName.TabIndex = 0;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label1.Location = new System.Drawing.Point(12, 12);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(100, 20);
            this.label1.TabIndex = 1;
            this.label1.Text = "Имя группы:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label2.Location = new System.Drawing.Point(12, 176);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(87, 20);
            this.label2.TabIndex = 2;
            this.label2.Text = "Описание:";
            // 
            // uiDescription
            // 
            this.uiDescription.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.uiDescription.Location = new System.Drawing.Point(12, 204);
            this.uiDescription.Multiline = true;
            this.uiDescription.Name = "uiDescription";
            this.uiDescription.Size = new System.Drawing.Size(339, 90);
            this.uiDescription.TabIndex = 3;
            // 
            // uiOpcServer
            // 
            this.uiOpcServer.DataSource = this.uiOpcServerBindingSource;
            this.uiOpcServer.DisplayMember = "ServerName";
            this.uiOpcServer.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.uiOpcServer.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.uiOpcServer.FormattingEnabled = true;
            this.uiOpcServer.Location = new System.Drawing.Point(118, 52);
            this.uiOpcServer.Name = "uiOpcServer";
            this.uiOpcServer.Size = new System.Drawing.Size(233, 28);
            this.uiOpcServer.TabIndex = 4;
            this.uiOpcServer.ValueMember = "ServerName";
            // 
            // uiOpcServerBindingSource
            // 
            this.uiOpcServerBindingSource.DataSource = typeof(ChroniclerConfigurator.ViewModels.OpcServer);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label3.Location = new System.Drawing.Point(12, 55);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(69, 20);
            this.label3.TabIndex = 5;
            this.label3.Text = "Сервер:";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label4.Location = new System.Drawing.Point(12, 97);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(183, 20);
            this.label4.TabIndex = 6;
            this.label4.Text = "Интервал обновления:";
            // 
            // uiRefreshInterval
            // 
            this.uiRefreshInterval.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.uiRefreshInterval.Location = new System.Drawing.Point(201, 95);
            this.uiRefreshInterval.Maximum = new decimal(new int[] {
            0,
            0,
            0,
            0});
            this.uiRefreshInterval.Name = "uiRefreshInterval";
            this.uiRefreshInterval.Size = new System.Drawing.Size(150, 26);
            this.uiRefreshInterval.TabIndex = 7;
            // 
            // uiCreate
            // 
            this.uiCreate.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.uiCreate.Location = new System.Drawing.Point(161, 304);
            this.uiCreate.Name = "uiCreate";
            this.uiCreate.Size = new System.Drawing.Size(99, 33);
            this.uiCreate.TabIndex = 8;
            this.uiCreate.Text = "Создать";
            this.uiCreate.UseVisualStyleBackColor = true;
            this.uiCreate.Click += new System.EventHandler(this.uiCreate_Click);
            // 
            // uiCancel
            // 
            this.uiCancel.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.uiCancel.Location = new System.Drawing.Point(266, 304);
            this.uiCancel.Name = "uiCancel";
            this.uiCancel.Size = new System.Drawing.Size(85, 33);
            this.uiCancel.TabIndex = 9;
            this.uiCancel.Text = "Отмена";
            this.uiCancel.UseVisualStyleBackColor = true;
            this.uiCancel.Click += new System.EventHandler(this.uiCancel_Click);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.label5.Location = new System.Drawing.Point(12, 139);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(77, 20);
            this.label5.TabIndex = 10;
            this.label5.Text = "Активна:";
            // 
            // uiIsActive
            // 
            this.uiIsActive.AutoSize = true;
            this.uiIsActive.Checked = true;
            this.uiIsActive.CheckState = System.Windows.Forms.CheckState.Checked;
            this.uiIsActive.Font = new System.Drawing.Font("Microsoft Sans Serif", 20.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.uiIsActive.Location = new System.Drawing.Point(95, 144);
            this.uiIsActive.Name = "uiIsActive";
            this.uiIsActive.Size = new System.Drawing.Size(15, 14);
            this.uiIsActive.TabIndex = 11;
            this.uiIsActive.UseVisualStyleBackColor = true;
            // 
            // GroupForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(361, 345);
            this.Controls.Add(this.uiIsActive);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.uiCancel);
            this.Controls.Add(this.uiCreate);
            this.Controls.Add(this.uiRefreshInterval);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.uiOpcServer);
            this.Controls.Add(this.uiDescription);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.uiGroupName);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.Name = "GroupForm";
            this.Text = "GroupForm";
            this.Load += new System.EventHandler(this.GroupForm_Load);
            ((System.ComponentModel.ISupportInitialize)(this.uiOpcServerBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.uiRefreshInterval)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox uiGroupName;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox uiDescription;
        private System.Windows.Forms.ComboBox uiOpcServer;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.NumericUpDown uiRefreshInterval;
        private System.Windows.Forms.Button uiCreate;
        private System.Windows.Forms.Button uiCancel;
        private System.Windows.Forms.BindingSource uiOpcServerBindingSource;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.CheckBox uiIsActive;
    }
}