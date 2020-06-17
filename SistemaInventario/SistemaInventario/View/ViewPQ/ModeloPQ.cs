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
using SistemaInventario.Controller.PQController;
using System.Data.SqlClient;
using System.Windows.Forms.DataVisualization.Charting;

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

        /*------------------------------------CODIGO DEL GRAFICO---------------------------------*/

        String conexionstring = @"server= DESKTOP-3FB1R0I\SQLEXPRESS; Database = sistemaInventario ; User Id =sa; Password = 1320022077";
        SqlDataAdapter DA;
        DataTable DT;
        DataRow DR;
        String Consulta;
        

        /*boton para graficar los materiales a usar en dicho producto*/
        private void boton_gra_Click(object sender, EventArgs e)
        {
            Consulta = "SELECT lm.Padre, SUM(lm.cantidad_Elaborar) From Lista_Material lm GROUP BY lm.Padre";
            DA = new SqlDataAdapter(Consulta,conexionstring);
            DT = new DataTable();
            DA.Fill(DT);
            this.graficapq.Palette = ChartColorPalette.SeaGreen;
            this.graficapq.Titles.Add("Cantidad de Materiales Para Elaborar la cama");
            if(DT.Rows.Count > 0)
            {
                for (int i = 0; i < DT.Rows.Count; i++)
                {
                    DR = DT.Rows[i];
                    Series series = this.graficapq.Series.Add(DR.ItemArray[0].ToString());
                    series.Points.Add(Convert.ToInt32(DR.ItemArray[1]));
                }
            }
        }


        /*boton para imprimir la grafica dada*/
        private void boton_guar_Click(object sender, EventArgs e)
        {
            this.graficapq.SaveImage("D://Grafica_Materiales.png", ChartImageFormat.Png);
            MessageBox.Show("Imagen Guardada Correctamente");
        }
    }
}
