using System.Drawing;

namespace SistemaInventario.View.Principal
{
    partial class MenuPrincipal
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
            BunifuAnimatorNS.Animation animation1 = new BunifuAnimatorNS.Animation();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(MenuPrincipal));
            this.PanelContenedorPrincipal = new System.Windows.Forms.Panel();
            this.PanelMenuPrincipal = new System.Windows.Forms.Panel();
            this.panel2 = new System.Windows.Forms.Panel();
            this.lbFecha = new System.Windows.Forms.Label();
            this.lblHora = new System.Windows.Forms.Label();
            this.panelMenu = new System.Windows.Forms.Panel();
            this.btnMenu = new Bunifu.Framework.UI.BunifuImageButton();
            this.btnPQ = new System.Windows.Forms.Button();
            this.btnPlanAgregado = new System.Windows.Forms.Button();
            this.btnMRP = new System.Windows.Forms.Button();
            this.PanelBarraTitulo = new System.Windows.Forms.Panel();
            this.btnNormal = new System.Windows.Forms.Button();
            this.btnMinimizar = new System.Windows.Forms.Button();
            this.btnMaximizar = new System.Windows.Forms.Button();
            this.btnCerrar = new System.Windows.Forms.Button();
            this.tmFechaHora = new System.Windows.Forms.Timer(this.components);
            this.MenuEfect = new BunifuAnimatorNS.BunifuTransition(this.components);
            this.PanelContenedorPrincipal.SuspendLayout();
            this.panel2.SuspendLayout();
            this.panelMenu.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.btnMenu)).BeginInit();
            this.PanelBarraTitulo.SuspendLayout();
            this.SuspendLayout();
            // 
            // PanelContenedorPrincipal
            // 
            this.PanelContenedorPrincipal.Controls.Add(this.PanelMenuPrincipal);
            this.PanelContenedorPrincipal.Controls.Add(this.panel2);
            this.PanelContenedorPrincipal.Controls.Add(this.panelMenu);
            this.PanelContenedorPrincipal.Controls.Add(this.PanelBarraTitulo);
            this.MenuEfect.SetDecoration(this.PanelContenedorPrincipal, BunifuAnimatorNS.DecorationType.None);
            this.PanelContenedorPrincipal.Dock = System.Windows.Forms.DockStyle.Fill;
            this.PanelContenedorPrincipal.Location = new System.Drawing.Point(0, 0);
            this.PanelContenedorPrincipal.Name = "PanelContenedorPrincipal";
            this.PanelContenedorPrincipal.Size = new System.Drawing.Size(1200, 800);
            this.PanelContenedorPrincipal.TabIndex = 0;
            // 
            // PanelMenuPrincipal
            // 
            this.MenuEfect.SetDecoration(this.PanelMenuPrincipal, BunifuAnimatorNS.DecorationType.None);
            this.PanelMenuPrincipal.Dock = System.Windows.Forms.DockStyle.Fill;
            this.PanelMenuPrincipal.Location = new System.Drawing.Point(78, 43);
            this.PanelMenuPrincipal.Name = "PanelMenuPrincipal";
            this.PanelMenuPrincipal.Size = new System.Drawing.Size(1122, 657);
            this.PanelMenuPrincipal.TabIndex = 9;
            // 
            // panel2
            // 
            this.panel2.BackColor = System.Drawing.Color.White;
            this.panel2.Controls.Add(this.lbFecha);
            this.panel2.Controls.Add(this.lblHora);
            this.MenuEfect.SetDecoration(this.panel2, BunifuAnimatorNS.DecorationType.None);
            this.panel2.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.panel2.Location = new System.Drawing.Point(78, 700);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(1122, 100);
            this.panel2.TabIndex = 8;
            // 
            // lbFecha
            // 
            this.lbFecha.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.lbFecha.AutoSize = true;
            this.MenuEfect.SetDecoration(this.lbFecha, BunifuAnimatorNS.DecorationType.None);
            this.lbFecha.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(128)));
            this.lbFecha.ForeColor = System.Drawing.Color.Black;
            this.lbFecha.Location = new System.Drawing.Point(860, 71);
            this.lbFecha.Name = "lbFecha";
            this.lbFecha.Size = new System.Drawing.Size(224, 20);
            this.lbFecha.TabIndex = 4;
            this.lbFecha.Text = "Lunes, 26 de septiembre 2018";
            // 
            // lblHora
            // 
            this.lblHora.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.lblHora.AutoSize = true;
            this.MenuEfect.SetDecoration(this.lblHora, BunifuAnimatorNS.DecorationType.None);
            this.lblHora.Font = new System.Drawing.Font("Microsoft Sans Serif", 35.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblHora.ForeColor = System.Drawing.Color.Black;
            this.lblHora.Location = new System.Drawing.Point(867, 10);
            this.lblHora.Name = "lblHora";
            this.lblHora.Size = new System.Drawing.Size(205, 54);
            this.lblHora.TabIndex = 1;
            this.lblHora.Text = "21:49:45";
            // 
            // panelMenu
            // 
            this.panelMenu.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(27)))), ((int)(((byte)(27)))), ((int)(((byte)(47)))));
            this.panelMenu.Controls.Add(this.btnMenu);
            this.panelMenu.Controls.Add(this.btnPQ);
            this.panelMenu.Controls.Add(this.btnPlanAgregado);
            this.panelMenu.Controls.Add(this.btnMRP);
            this.MenuEfect.SetDecoration(this.panelMenu, BunifuAnimatorNS.DecorationType.None);
            this.panelMenu.Dock = System.Windows.Forms.DockStyle.Left;
            this.panelMenu.Location = new System.Drawing.Point(0, 43);
            this.panelMenu.Name = "panelMenu";
            this.panelMenu.Size = new System.Drawing.Size(78, 757);
            this.panelMenu.TabIndex = 3;
            // 
            // btnMenu
            // 
            this.btnMenu.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(26)))), ((int)(((byte)(32)))), ((int)(((byte)(40)))));
            this.btnMenu.Cursor = System.Windows.Forms.Cursors.Hand;
            this.MenuEfect.SetDecoration(this.btnMenu, BunifuAnimatorNS.DecorationType.None);
            this.btnMenu.Image = ((System.Drawing.Image)(resources.GetObject("btnMenu.Image")));
            this.btnMenu.ImageActive = null;
            this.btnMenu.Location = new System.Drawing.Point(3, 6);
            this.btnMenu.Name = "btnMenu";
            this.btnMenu.Size = new System.Drawing.Size(35, 35);
            this.btnMenu.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.btnMenu.TabIndex = 14;
            this.btnMenu.TabStop = false;
            this.btnMenu.Zoom = 10;
            this.btnMenu.Click += new System.EventHandler(this.btnMenu_Click);
            // 
            // btnPQ
            // 
            this.btnPQ.Cursor = System.Windows.Forms.Cursors.Hand;
            this.MenuEfect.SetDecoration(this.btnPQ, BunifuAnimatorNS.DecorationType.None);
            this.btnPQ.FlatAppearance.BorderSize = 0;
            this.btnPQ.FlatAppearance.MouseDownBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(69)))), ((int)(((byte)(76)))));
            this.btnPQ.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(38)))), ((int)(((byte)(45)))), ((int)(((byte)(53)))));
            this.btnPQ.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnPQ.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnPQ.ForeColor = System.Drawing.Color.Silver;
            this.btnPQ.Image = ((System.Drawing.Image)(resources.GetObject("btnPQ.Image")));
            this.btnPQ.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnPQ.Location = new System.Drawing.Point(3, 550);
            this.btnPQ.Margin = new System.Windows.Forms.Padding(3, 3, 3, 50);
            this.btnPQ.Name = "btnPQ";
            this.btnPQ.Size = new System.Drawing.Size(230, 80);
            this.btnPQ.TabIndex = 13;
            this.btnPQ.Text = "   Mètodo PQ";
            this.btnPQ.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageBeforeText;
            this.btnPQ.UseVisualStyleBackColor = true;
            // 
            // btnPlanAgregado
            // 
            this.btnPlanAgregado.Cursor = System.Windows.Forms.Cursors.Hand;
            this.MenuEfect.SetDecoration(this.btnPlanAgregado, BunifuAnimatorNS.DecorationType.None);
            this.btnPlanAgregado.FlatAppearance.BorderSize = 0;
            this.btnPlanAgregado.FlatAppearance.MouseDownBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(69)))), ((int)(((byte)(76)))));
            this.btnPlanAgregado.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(38)))), ((int)(((byte)(45)))), ((int)(((byte)(53)))));
            this.btnPlanAgregado.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnPlanAgregado.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnPlanAgregado.ForeColor = System.Drawing.Color.Silver;
            this.btnPlanAgregado.Image = ((System.Drawing.Image)(resources.GetObject("btnPlanAgregado.Image")));
            this.btnPlanAgregado.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnPlanAgregado.Location = new System.Drawing.Point(0, 350);
            this.btnPlanAgregado.Margin = new System.Windows.Forms.Padding(3, 3, 3, 50);
            this.btnPlanAgregado.Name = "btnPlanAgregado";
            this.btnPlanAgregado.Size = new System.Drawing.Size(230, 80);
            this.btnPlanAgregado.TabIndex = 12;
            this.btnPlanAgregado.Text = "   Plan Agregado";
            this.btnPlanAgregado.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageBeforeText;
            this.btnPlanAgregado.UseVisualStyleBackColor = true;
            // 
            // btnMRP
            // 
            this.btnMRP.Cursor = System.Windows.Forms.Cursors.Hand;
            this.MenuEfect.SetDecoration(this.btnMRP, BunifuAnimatorNS.DecorationType.None);
            this.btnMRP.FlatAppearance.BorderSize = 0;
            this.btnMRP.FlatAppearance.MouseDownBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(69)))), ((int)(((byte)(76)))));
            this.btnMRP.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(38)))), ((int)(((byte)(45)))), ((int)(((byte)(53)))));
            this.btnMRP.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnMRP.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnMRP.ForeColor = System.Drawing.Color.Silver;
            this.btnMRP.Image = ((System.Drawing.Image)(resources.GetObject("btnMRP.Image")));
            this.btnMRP.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnMRP.Location = new System.Drawing.Point(0, 180);
            this.btnMRP.Margin = new System.Windows.Forms.Padding(0);
            this.btnMRP.Name = "btnMRP";
            this.btnMRP.Size = new System.Drawing.Size(230, 80);
            this.btnMRP.TabIndex = 4;
            this.btnMRP.Text = "         MRP";
            this.btnMRP.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageBeforeText;
            this.btnMRP.UseVisualStyleBackColor = true;
            this.btnMRP.Click += new System.EventHandler(this.btnMRP_Click);
            // 
            // PanelBarraTitulo
            // 
            this.PanelBarraTitulo.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(27)))), ((int)(((byte)(27)))), ((int)(((byte)(47)))));
            this.PanelBarraTitulo.Controls.Add(this.btnNormal);
            this.PanelBarraTitulo.Controls.Add(this.btnMinimizar);
            this.PanelBarraTitulo.Controls.Add(this.btnMaximizar);
            this.PanelBarraTitulo.Controls.Add(this.btnCerrar);
            this.MenuEfect.SetDecoration(this.PanelBarraTitulo, BunifuAnimatorNS.DecorationType.None);
            this.PanelBarraTitulo.Dock = System.Windows.Forms.DockStyle.Top;
            this.PanelBarraTitulo.Location = new System.Drawing.Point(0, 0);
            this.PanelBarraTitulo.Name = "PanelBarraTitulo";
            this.PanelBarraTitulo.Size = new System.Drawing.Size(1200, 43);
            this.PanelBarraTitulo.TabIndex = 2;
            this.PanelBarraTitulo.MouseDown += new System.Windows.Forms.MouseEventHandler(this.PanelBarraTitulo_MouseDown);
            // 
            // btnNormal
            // 
            this.btnNormal.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnNormal.Cursor = System.Windows.Forms.Cursors.Hand;
            this.MenuEfect.SetDecoration(this.btnNormal, BunifuAnimatorNS.DecorationType.None);
            this.btnNormal.FlatAppearance.BorderSize = 0;
            this.btnNormal.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnNormal.Image = ((System.Drawing.Image)(resources.GetObject("btnNormal.Image")));
            this.btnNormal.Location = new System.Drawing.Point(1096, 2);
            this.btnNormal.Name = "btnNormal";
            this.btnNormal.Size = new System.Drawing.Size(43, 43);
            this.btnNormal.TabIndex = 3;
            this.btnNormal.UseVisualStyleBackColor = true;
            this.btnNormal.Visible = false;
            this.btnNormal.Click += new System.EventHandler(this.btnNormal_Click);
            // 
            // btnMinimizar
            // 
            this.btnMinimizar.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnMinimizar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(27)))), ((int)(((byte)(27)))), ((int)(((byte)(47)))));
            this.btnMinimizar.Cursor = System.Windows.Forms.Cursors.Hand;
            this.MenuEfect.SetDecoration(this.btnMinimizar, BunifuAnimatorNS.DecorationType.None);
            this.btnMinimizar.FlatAppearance.BorderSize = 0;
            this.btnMinimizar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnMinimizar.ForeColor = System.Drawing.Color.Cornsilk;
            this.btnMinimizar.Image = ((System.Drawing.Image)(resources.GetObject("btnMinimizar.Image")));
            this.btnMinimizar.Location = new System.Drawing.Point(1050, 0);
            this.btnMinimizar.Name = "btnMinimizar";
            this.btnMinimizar.Size = new System.Drawing.Size(43, 43);
            this.btnMinimizar.TabIndex = 2;
            this.btnMinimizar.UseVisualStyleBackColor = false;
            this.btnMinimizar.Click += new System.EventHandler(this.btnMinimizar_Click);
            // 
            // btnMaximizar
            // 
            this.btnMaximizar.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnMaximizar.Cursor = System.Windows.Forms.Cursors.Hand;
            this.MenuEfect.SetDecoration(this.btnMaximizar, BunifuAnimatorNS.DecorationType.None);
            this.btnMaximizar.FlatAppearance.BorderSize = 0;
            this.btnMaximizar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnMaximizar.Image = ((System.Drawing.Image)(resources.GetObject("btnMaximizar.Image")));
            this.btnMaximizar.Location = new System.Drawing.Point(1096, 0);
            this.btnMaximizar.Name = "btnMaximizar";
            this.btnMaximizar.Size = new System.Drawing.Size(43, 43);
            this.btnMaximizar.TabIndex = 1;
            this.btnMaximizar.UseVisualStyleBackColor = true;
            this.btnMaximizar.Click += new System.EventHandler(this.btnMaximizar_Click);
            // 
            // btnCerrar
            // 
            this.btnCerrar.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnCerrar.Cursor = System.Windows.Forms.Cursors.Hand;
            this.MenuEfect.SetDecoration(this.btnCerrar, BunifuAnimatorNS.DecorationType.None);
            this.btnCerrar.FlatAppearance.BorderSize = 0;
            this.btnCerrar.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnCerrar.Image = ((System.Drawing.Image)(resources.GetObject("btnCerrar.Image")));
            this.btnCerrar.Location = new System.Drawing.Point(1143, 2);
            this.btnCerrar.Name = "btnCerrar";
            this.btnCerrar.Size = new System.Drawing.Size(39, 39);
            this.btnCerrar.TabIndex = 0;
            this.btnCerrar.UseVisualStyleBackColor = true;
            this.btnCerrar.Click += new System.EventHandler(this.btnCerrar_Click);
            // 
            // tmFechaHora
            // 
            this.tmFechaHora.Enabled = true;
            this.tmFechaHora.Tick += new System.EventHandler(this.tmFechaHora_Tick);
            // 
            // MenuEfect
            // 
            this.MenuEfect.AnimationType = BunifuAnimatorNS.AnimationType.Particles;
            this.MenuEfect.Cursor = null;
            animation1.AnimateOnlyDifferences = true;
            animation1.BlindCoeff = ((System.Drawing.PointF)(resources.GetObject("animation1.BlindCoeff")));
            animation1.LeafCoeff = 0F;
            animation1.MaxTime = 1F;
            animation1.MinTime = 0F;
            animation1.MosaicCoeff = ((System.Drawing.PointF)(resources.GetObject("animation1.MosaicCoeff")));
            animation1.MosaicShift = ((System.Drawing.PointF)(resources.GetObject("animation1.MosaicShift")));
            animation1.MosaicSize = 1;
            animation1.Padding = new System.Windows.Forms.Padding(100, 50, 100, 150);
            animation1.RotateCoeff = 0F;
            animation1.RotateLimit = 0F;
            animation1.ScaleCoeff = ((System.Drawing.PointF)(resources.GetObject("animation1.ScaleCoeff")));
            animation1.SlideCoeff = ((System.Drawing.PointF)(resources.GetObject("animation1.SlideCoeff")));
            animation1.TimeCoeff = 2F;
            animation1.TransparencyCoeff = 0F;
            this.MenuEfect.DefaultAnimation = animation1;
            // 
            // MenuPrincipal
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.ClientSize = new System.Drawing.Size(1200, 800);
            this.Controls.Add(this.PanelContenedorPrincipal);
            this.MenuEfect.SetDecoration(this, BunifuAnimatorNS.DecorationType.None);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MinimumSize = new System.Drawing.Size(1200, 800);
            this.Name = "MenuPrincipal";
            this.Text = "MenuNuevo";
            this.Load += new System.EventHandler(this.FormMenuPrincipal_Load);
            this.PanelContenedorPrincipal.ResumeLayout(false);
            this.panel2.ResumeLayout(false);
            this.panel2.PerformLayout();
            this.panelMenu.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.btnMenu)).EndInit();
            this.PanelBarraTitulo.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel PanelContenedorPrincipal;
        private System.Windows.Forms.Panel PanelBarraTitulo;
        private System.Windows.Forms.Button btnNormal;
        private System.Windows.Forms.Button btnMinimizar;
        private System.Windows.Forms.Button btnMaximizar;
        private System.Windows.Forms.Button btnCerrar;
        private System.Windows.Forms.Panel panelMenu;
        private Bunifu.Framework.UI.BunifuImageButton btnMenu;
        private System.Windows.Forms.Button btnPQ;
        private System.Windows.Forms.Button btnPlanAgregado;
        private System.Windows.Forms.Button btnMRP;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.Label lbFecha;
        private System.Windows.Forms.Label lblHora;
        private BunifuAnimatorNS.BunifuTransition MenuEfect;
        private System.Windows.Forms.Timer tmFechaHora;
        private System.Windows.Forms.Panel PanelMenuPrincipal;
    }
}