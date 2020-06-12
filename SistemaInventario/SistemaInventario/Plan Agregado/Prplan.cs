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

namespace SistemaInventario.Plan_Agregado
{
    public partial class Prplan : Form
    {
        SqlConnection conec = new SqlConnection("server=LAPTOP-V5E4QOLS\\SQLEXPRESS;database=sistemaInventario; Integrated security=true");
        public Prplan()
        {
            InitializeComponent();
        }

        private void Prplan_Load(object sender, EventArgs e)
        {
            try
            {
                conec.Open();
                SqlCommand comando = new SqlCommand("exec EstartegiaPersecucion", conec);
                SqlDataAdapter adaptador = new SqlDataAdapter();
                adaptador.SelectCommand = comando;
                DataTable tabla = new DataTable();
                adaptador.Fill(tabla);
                dataGridView1.DataSource = GenerateTransposedTable(tabla);
                dataGridView1.Columns[0].Width = 200 ;

                SqlCommand comando2 = new SqlCommand("exec InventarioAjustado", conec);
                adaptador.SelectCommand = comando2;
                DataTable tabla2 = new DataTable();
                adaptador.Fill(tabla2);
                dataGridView2.DataSource = GenerateTransposedTable(tabla2);
                dataGridView2.Columns[0].Width = 200;

                SqlCommand comando3 = new SqlCommand("exec FuerzaNivelada", conec);
                adaptador.SelectCommand = comando3;
                DataTable tabla3 = new DataTable();
                adaptador.Fill(tabla3);
                dataGridView3.DataSource = GenerateTransposedTable(tabla3);
                dataGridView3.Columns[0].Width = 200;
            }
            catch (Exception)
            {
                MessageBox.Show("Corrija");
            }

        }
        private DataTable GenerateTransposedTable(DataTable inputTable)
        {
            DataTable outputTable = new DataTable();

            // Se agregan las columnas haciendo un ciclo para cada fila

            // El encabezado de la primera columna es el mismo. 
            outputTable.Columns.Add(inputTable.Columns[0].ColumnName.ToString());

            // El encabezado para las demas columnas
            foreach (DataRow inRow in inputTable.Rows)
            {
                string newColName = inRow[0].ToString();
                outputTable.Columns.Add(newColName);
            }

            // Se agregan las columnas por cada renglón        
            for (int rCount = 1; rCount <= inputTable.Columns.Count - 1; rCount++)
            {
                DataRow newRow = outputTable.NewRow();

                newRow[0] = inputTable.Columns[rCount].ColumnName.ToString();
                for (int cCount = 0; cCount <= inputTable.Rows.Count - 1; cCount++)
                {
                    string colValue = inputTable.Rows[cCount][rCount].ToString();
                    newRow[cCount + 1] = colValue;
                }
                outputTable.Rows.Add(newRow);
            }

            return outputTable;
        }


        private void label9_Click(object sender, EventArgs e)
        {

        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void label7_Click(object sender, EventArgs e)
        {

        }

        private void textBox3_TextChanged(object sender, EventArgs e)
        {

        }

        private void label9_Click_1(object sender, EventArgs e)
        {

        }

        private void label8_Click(object sender, EventArgs e)
        {

        }

        private void tabPage2_Click(object sender, EventArgs e)
        {
            
        }

        private void tabControl1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void button4_Click(object sender, EventArgs e)
        {
            exportaraexcel(dataGridView1);
        }

        public void exportaraexcel(DataGridView tabla)
        {

            Microsoft.Office.Interop.Excel.Application excel = new Microsoft.Office.Interop.Excel.Application();

            excel.Application.Workbooks.Add(true);

            int IndiceColumna = 0;

            foreach (DataGridViewColumn col in tabla.Columns) // Columnas
            {

                IndiceColumna++;

                excel.Cells[1, IndiceColumna] = col.Name;

            }

            int IndeceFila = 0;

            foreach (DataGridViewRow row in tabla.Rows) // Filas
            {

                IndeceFila++;

                IndiceColumna = 0;

                foreach (DataGridViewColumn col in tabla.Columns)
                {

                    IndiceColumna++;

                    excel.Cells[IndeceFila + 1, IndiceColumna] = row.Cells[col.Name].Value;

                }

            }

            excel.Visible = true;


        }

        private void button1_Click(object sender, EventArgs e)
        {
            tabControl1.SelectedIndex=1;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            tabControl1.SelectedIndex = 2;
        }

        private void button3_Click(object sender, EventArgs e)
        {
            tabControl1.SelectedIndex = 3;
        }

        private void button5_Click(object sender, EventArgs e)
        {
            exportaraexcel(dataGridView2);
        }

        private void dataGridView2_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
