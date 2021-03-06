﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using SistemaInventario.Controller.MRPController;

namespace SistemaInventario.View.ViewMRP
{
    public partial class LotexLote : Form
    {
        public LotexLote()
        {
            InitializeComponent();
            dgvLxL.DataSource = null;
            dgvLxL.DataSource = MRPcontrol.MostrarDato("LXL");
        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void cambioLetra(object sender, EventArgs e)
        {
            this.exportar.ForeColor = Color.White;
        }

        private void normalLetra(object sender, EventArgs e)
        {
            this.exportar.ForeColor = Color.Black;
        }

        private void exportar_Click(object sender, EventArgs e)
        {
            MRPcontrol.ExportarExcel(dgvLxL);
        }
    }
}
