namespace SistemaInventario.View.Principal.Configuracines
{
    partial class General
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
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle3 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle4 = new System.Windows.Forms.DataGridViewCellStyle();
            this.principal = new System.Windows.Forms.SplitContainer();
            this.secundario = new System.Windows.Forms.SplitContainer();
            this.dgvProgramaM = new System.Windows.Forms.DataGridView();
            this.label1 = new System.Windows.Forms.Label();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.dgvListaM = new System.Windows.Forms.DataGridView();
            this.panel2 = new System.Windows.Forms.Panel();
            this.panel1 = new System.Windows.Forms.Panel();
            this.label2 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.principal)).BeginInit();
            this.principal.Panel1.SuspendLayout();
            this.principal.Panel2.SuspendLayout();
            this.principal.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.secundario)).BeginInit();
            this.secundario.Panel1.SuspendLayout();
            this.secundario.Panel2.SuspendLayout();
            this.secundario.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvProgramaM)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvListaM)).BeginInit();
            this.SuspendLayout();
            // 
            // principal
            // 
            this.principal.Dock = System.Windows.Forms.DockStyle.Fill;
            this.principal.Location = new System.Drawing.Point(0, 0);
            this.principal.Name = "principal";
            this.principal.Orientation = System.Windows.Forms.Orientation.Horizontal;
            // 
            // principal.Panel1
            // 
            this.principal.Panel1.Controls.Add(this.secundario);
            // 
            // principal.Panel2
            // 
            this.principal.Panel2.Controls.Add(this.dgvListaM);
            this.principal.Panel2.Controls.Add(this.panel2);
            this.principal.Panel2.Controls.Add(this.panel1);
            this.principal.Panel2.Controls.Add(this.label2);
            this.principal.Size = new System.Drawing.Size(800, 450);
            this.principal.SplitterDistance = 223;
            this.principal.TabIndex = 0;
            // 
            // secundario
            // 
            this.secundario.Dock = System.Windows.Forms.DockStyle.Fill;
            this.secundario.Location = new System.Drawing.Point(0, 0);
            this.secundario.Name = "secundario";
            // 
            // secundario.Panel1
            // 
            this.secundario.Panel1.Controls.Add(this.dgvProgramaM);
            this.secundario.Panel1.Controls.Add(this.label1);
            // 
            // secundario.Panel2
            // 
            this.secundario.Panel2.Controls.Add(this.pictureBox1);
            this.secundario.Size = new System.Drawing.Size(800, 223);
            this.secundario.SplitterDistance = 250;
            this.secundario.TabIndex = 0;
            // 
            // dgvProgramaM
            // 
            this.dgvProgramaM.BackgroundColor = System.Drawing.Color.Snow;
            this.dgvProgramaM.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.dgvProgramaM.CellBorderStyle = System.Windows.Forms.DataGridViewCellBorderStyle.Raised;
            dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle1.BackColor = System.Drawing.Color.Snow;
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgvProgramaM.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
            this.dgvProgramaM.ColumnHeadersHeight = 50;
            this.dgvProgramaM.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.DisableResizing;
            this.dgvProgramaM.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgvProgramaM.EnableHeadersVisualStyles = false;
            this.dgvProgramaM.GridColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(64)))));
            this.dgvProgramaM.Location = new System.Drawing.Point(0, 13);
            this.dgvProgramaM.Name = "dgvProgramaM";
            this.dgvProgramaM.RowHeadersVisible = false;
            dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.TopCenter;
            dataGridViewCellStyle2.BackColor = System.Drawing.Color.Snow;
            dataGridViewCellStyle2.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle2.ForeColor = System.Drawing.Color.Black;
            dataGridViewCellStyle2.SelectionBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(192)))));
            dataGridViewCellStyle2.SelectionForeColor = System.Drawing.Color.Black;
            this.dgvProgramaM.RowsDefaultCellStyle = dataGridViewCellStyle2;
            this.dgvProgramaM.Size = new System.Drawing.Size(250, 210);
            this.dgvProgramaM.TabIndex = 17;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Dock = System.Windows.Forms.DockStyle.Top;
            this.label1.Location = new System.Drawing.Point(0, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(93, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Programa Maestro";
            // 
            // pictureBox1
            // 
            this.pictureBox1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pictureBox1.Location = new System.Drawing.Point(0, 0);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(546, 223);
            this.pictureBox1.TabIndex = 0;
            this.pictureBox1.TabStop = false;
            // 
            // dgvListaM
            // 
            this.dgvListaM.BackgroundColor = System.Drawing.Color.Snow;
            this.dgvListaM.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.dgvListaM.CellBorderStyle = System.Windows.Forms.DataGridViewCellBorderStyle.Raised;
            dataGridViewCellStyle3.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter;
            dataGridViewCellStyle3.BackColor = System.Drawing.Color.Snow;
            dataGridViewCellStyle3.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle3.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle3.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle3.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle3.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgvListaM.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle3;
            this.dgvListaM.ColumnHeadersHeight = 50;
            this.dgvListaM.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.DisableResizing;
            this.dgvListaM.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgvListaM.EnableHeadersVisualStyles = false;
            this.dgvListaM.GridColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(64)))));
            this.dgvListaM.Location = new System.Drawing.Point(200, 13);
            this.dgvListaM.Name = "dgvListaM";
            this.dgvListaM.RowHeadersVisible = false;
            dataGridViewCellStyle4.Alignment = System.Windows.Forms.DataGridViewContentAlignment.TopCenter;
            dataGridViewCellStyle4.BackColor = System.Drawing.Color.Snow;
            dataGridViewCellStyle4.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle4.ForeColor = System.Drawing.Color.Black;
            dataGridViewCellStyle4.SelectionBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(192)))));
            dataGridViewCellStyle4.SelectionForeColor = System.Drawing.Color.Black;
            this.dgvListaM.RowsDefaultCellStyle = dataGridViewCellStyle4;
            this.dgvListaM.Size = new System.Drawing.Size(400, 210);
            this.dgvListaM.TabIndex = 23;
            // 
            // panel2
            // 
            this.panel2.Dock = System.Windows.Forms.DockStyle.Right;
            this.panel2.Location = new System.Drawing.Point(600, 13);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(200, 210);
            this.panel2.TabIndex = 22;
            // 
            // panel1
            // 
            this.panel1.Dock = System.Windows.Forms.DockStyle.Left;
            this.panel1.Location = new System.Drawing.Point(0, 13);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(200, 210);
            this.panel1.TabIndex = 21;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Dock = System.Windows.Forms.DockStyle.Top;
            this.label2.Location = new System.Drawing.Point(0, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(95, 13);
            this.label2.TabIndex = 20;
            this.label2.Text = "Lista de Materiales";
            // 
            // General
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.principal);
            this.Name = "General";
            this.Text = "General";
            this.principal.Panel1.ResumeLayout(false);
            this.principal.Panel2.ResumeLayout(false);
            this.principal.Panel2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.principal)).EndInit();
            this.principal.ResumeLayout(false);
            this.secundario.Panel1.ResumeLayout(false);
            this.secundario.Panel1.PerformLayout();
            this.secundario.Panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.secundario)).EndInit();
            this.secundario.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvProgramaM)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvListaM)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.SplitContainer principal;
        private System.Windows.Forms.SplitContainer secundario;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.DataGridView dgvProgramaM;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.DataGridView dgvListaM;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.Panel panel1;
    }
}