using SistemaInventario.Controller.MRPController;
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SistemaInventario.View.ViewMRP
{
    public partial class Costos : Form
    {
        public Costos()
        {
            InitializeComponent();
            dgvCosto.DataSource = null;
            dgvCosto.DataSource = MRPcontrol.MostrarCosto();
        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void Costos_Load(object sender, EventArgs e)
        {
            ArrayList tipo = MRPcontrol.Tipo();
            ArrayList costo = MRPcontrol.MostrarDatoCosto();

            chartCosto.Series[0].Points.DataBindXY(tipo,costo);
        }
    }
}
