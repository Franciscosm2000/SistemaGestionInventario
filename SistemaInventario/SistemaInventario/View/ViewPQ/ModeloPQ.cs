using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using SistemaInventario.Model.PQ_Pojo;
using SistemaInventario.Model.ConexionSQL;
using SistemaInventario.Controller.PQController;
using System.Data.SqlClient;

namespace SistemaInventario.View.ViewPQ
{
    public partial class ModeloPQ : Form
    {
        public ModeloPQ()
        {
            InitializeComponent();
            CenterToScreen();
            Mostrarmodelop1();
            /*ajustar el tamaño de columnas y celdas*/
            /*parte 1*/
            tablap1.AutoResizeColumns();
            tablap1.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCells;
            tablaq1.AutoResizeColumns();
            tablaq1.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCells;
            /*parte 2*/
            tablap2.AutoResizeColumns();
            tablap2.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCells;
            tablaq2.AutoResizeColumns();
            tablaq2.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCells;
        }

        /*capturando los datos del modelo PQ*/
        private void Mostrarmodelop1()
        {
            /*parte 1*/
            tablap1.DataSource = null;
            tablap1.DataSource = PQcontrol.Mostrar_P1();
            tablaq1.DataSource = null;
            tablaq1.DataSource = PQcontrol.Mostrar_Q1();
            /*parte 2*/
            tablap2.DataSource = null;
            tablap2.DataSource = PQcontrol.Mostrar_P2();
            tablaq2.DataSource = null;
            tablaq2.DataSource = PQcontrol.Mostrar_Q2();
        }

        private void button_close_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
