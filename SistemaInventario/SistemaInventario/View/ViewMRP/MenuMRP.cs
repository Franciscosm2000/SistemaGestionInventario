﻿using SistemaInventario.View.Principal;
using SistemaInventario.View.ViewMRP;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SistemaInventario
{
    public partial class MenuMRP : Form
    {
        public MenuMRP()
        {
            InitializeComponent();
        }

        public void AbrirFormEnPanel(object formHijo)
        {

            if (MenuPrincipal.PanelMenuPrincipal.Controls.Count > 0)
                MenuPrincipal.PanelMenuPrincipal.Controls.RemoveAt(0);
            Form fh = formHijo as Form;
            fh.TopLevel = false;
            fh.FormBorderStyle = FormBorderStyle.None;
            fh.Dock = DockStyle.Fill;
            MenuPrincipal.PanelMenuPrincipal.Controls.Add(fh);
            MenuPrincipal.PanelMenuPrincipal.Tag = fh;
            fh.Show();
        }

        private void MostrarFormMRPoAlCerrarForms(object sender, FormClosedEventArgs e)
        {
          AbrirFormEnPanel( new MenuMRP());
        }

        private void MostrarFormCloseAlCerrarForms(object sender, FormClosedEventArgs e)
        {
           
        }

        private void btnLxL_Click(object sender, EventArgs e)
        {
            LotexLote f = new LotexLote();
            f.FormClosed += new FormClosedEventHandler(MostrarFormMRPoAlCerrarForms);
            AbrirFormEnPanel(f);
        }

        private void btnLxL_Click_1(object sender, EventArgs e)
        {
            LotexLote f = new LotexLote();
            f.FormClosed += new FormClosedEventHandler(MostrarFormMRPoAlCerrarForms);
            AbrirFormEnPanel(f);
        }
    }
}
