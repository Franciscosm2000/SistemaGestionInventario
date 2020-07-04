using SistemaInventario.View.Principal;
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
            Form l = formHijo as Form;
            l.FormBorderStyle = FormBorderStyle.None;
            l.TopLevel = false;
            l.Dock = DockStyle.Fill;
            this.Controls.Add(l);
            this.Tag = l;
            l.BringToFront();
            l.Show();
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

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnEOQ_Click(object sender, EventArgs e)
        {
            EOQ eOQ = new EOQ();
            eOQ.FormClosed += new FormClosedEventHandler(MostrarFormMRPoAlCerrarForms);
            AbrirFormEnPanel(eOQ);
        }

        private void btnPOQ_Click(object sender, EventArgs e)
        {
            POQ eOQ = new POQ();
            eOQ.FormClosed += new FormClosedEventHandler(MostrarFormMRPoAlCerrarForms);
            AbrirFormEnPanel(eOQ);
        }

        private void btnCostoMetodos_Click(object sender, EventArgs e)
        {
            Costos eOQ = new Costos();
            eOQ.FormClosed += new FormClosedEventHandler(MostrarFormMRPoAlCerrarForms);
            AbrirFormEnPanel(eOQ);
        }
    }
}
