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
    public partial class POQ : Form
    {
        public POQ()
        {
            InitializeComponent();
            dgvPOQ.DataSource = null;
            dgvPOQ.DataSource = MRPcontrol.MostrarDato("POQ");
        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
