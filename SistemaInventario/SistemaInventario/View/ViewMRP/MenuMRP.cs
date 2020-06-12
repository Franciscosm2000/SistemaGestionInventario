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

        FormMenuPrincipal obj = new FormMenuPrincipal();

        private void MostrarFormMRPoAlCerrarForms(object sender, FormClosedEventArgs e)
        {
          obj.AbrirFormEnPanel( new MenuMRP());
        }

        private void btnLxL_Click(object sender, EventArgs e)
        {
            LotexLote f = new LotexLote();
            f.FormClosed += new FormClosedEventHandler(MostrarFormMRPoAlCerrarForms);
            obj.AbrirFormEnPanel(f);
            f.Show();
            MessageBox.Show("click");
        }
    }
}
