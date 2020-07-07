using Microsoft.VisualBasic;
using SistemaInventario.Controller.ConfigController;
using SistemaInventario.Model.ConeccionSQL;
using SistemaInventario.Plan_Agregado;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
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
            dgvProgramaM.DataSource = null;
            dgvAJFB.DataSource = null;

            dgvProgramaM.DataSource = configController.MostrarDato("PM");
            dgvAJFB.DataSource = Prplan.GenerateTransposedTable(configController.MostrarDato("DC"));
            dataGridView1.DataSource = configController.MostrarDato("Ma");
        }

        private void panel2_Paint(object sender, PaintEventArgs e)
        {

        }

        private void button4_Click(object sender, EventArgs e)
        {
            configController.actualizar2(textBox2,dgvAJFB);
            dgvAJFB.DataSource = null;
            dgvAJFB.DataSource = Prplan.GenerateTransposedTable(configController.MostrarDato("DC"));

        }

        private void dgvProgramaM_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void dgvProgramaM_CellClick(object sender, DataGridViewCellEventArgs e)
        {

            textBox3.Text = "Semana : "+(dgvProgramaM.CurrentRow.Cells["Semana"].Value.ToString());
            textBox1.Text = dgvProgramaM.CurrentRow.Cells["Cantidad"].Value.ToString();
        }

        private void textBox3_ForeColorChanged(object sender, EventArgs e)
        {

        }

        private void dgvAJFB_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            textBox2.Text = dgvAJFB.CurrentRow.Cells["valores"].Value.ToString();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            configController.agregar(dgvProgramaM);
            dgvProgramaM.DataSource = null;
            dgvProgramaM.DataSource = configController.MostrarDato("PM");

        }

        private void button1_Click(object sender, EventArgs e)
        {
            configController.actualizar1(textBox1,dgvProgramaM);
            dgvProgramaM.DataSource = null;
            dgvProgramaM.DataSource = configController.MostrarDato("PM");

        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void splitContainer2_Panel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void button5_Click(object sender, EventArgs e)
        {
            configController.actualizar3(textBox4,textBox5,dataGridView1);
            dataGridView1.DataSource = configController.MostrarDato("Ma");

        }

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            textBox4.Text = dataGridView1.CurrentRow.Cells["Dias"].Value.ToString();
            textBox5.Text = dataGridView1.CurrentRow.Cells["Demand"].Value.ToString();

        }

        private void button3_Click(object sender, EventArgs e)
        {
            configController.agregar2();
            dataGridView1.DataSource = configController.MostrarDato("Ma");

        }
    }
}
