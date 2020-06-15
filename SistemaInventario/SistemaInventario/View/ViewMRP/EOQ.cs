using SistemaInventario.Controller.MRPController;
using System;
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
    public partial class EOQ : Form
    {
        public EOQ()
        {
            InitializeComponent();
            dgvEOQ.DataSource = null;
            dgvEOQ.DataSource = MRPcontrol.MostrarDato("EOQ");
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
    }
}
