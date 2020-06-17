using SistemaInventario.Controller.ConfigController;
using SistemaInventario.Plan_Agregado;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SistemaInventario.View.Principal.Configuracines
{
    public partial class General : Form
    {
        public General()
        {
            InitializeComponent();
            llamadoTabla();
        }

        private void llamadoTabla()
        {
            dgvListaM.DataSource = null;
            dgvProgramaM.DataSource = null;
            dgvAJFB.DataSource = null;

            dgvListaM.DataSource = configController.MostrarDato("LM");
            dgvProgramaM.DataSource = configController.MostrarDato("PM");
            dgvAJFB.DataSource = Prplan.GenerateTransposedTable(configController.MostrarDato("DC"));
        }
 
    }
}
