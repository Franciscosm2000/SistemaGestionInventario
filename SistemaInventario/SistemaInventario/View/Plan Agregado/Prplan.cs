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
        SqlConnection conec = new SqlConnection(@"server= DESKTOP-3FB1R0I\SQLEXPRESS; Database = sistemaInventario ; User Id =sa; Password = 1320022077");
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

                SqlCommand cmo = new SqlCommand("select * from totales", conec);
                SqlDataReader adaptador1;
                adaptador1= cmo.ExecuteReader();
                if (adaptador1.Read())
                {
                    textBox1.Text = adaptador1["total1"].ToString();
                    textBox4.Text = adaptador1["total1"].ToString();
                    textBox2.Text = adaptador1["total2"].ToString();
                    textBox5.Text = adaptador1["total2"].ToString();
                    textBox3.Text = adaptador1["total3"].ToString();
                    textBox6.Text = adaptador1["total3"].ToString();
                }
                
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

        

        private void button6_Click(object sender, EventArgs e)
        {
            exportaraexcel(dataGridView3);
        }

        private void button7_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void Prplan_Resize(object sender, EventArgs e)
        {
            //logo y btn cerrar
            pictureBox1.Location= new Point(384, -73);
            button7.Location = new Point(this.Width-100, 6);
            //franja celeste izquierda
            panel5.Width = this.Width/5 ;
            panel5.Location = new Point(0, 95);
            panel8.Width = panel5.Width;
            panel8.Location = panel5.Location;
            panel14.Location = panel5.Location;
            panel14.Width = panel5.Width;
            panel11.Width = panel5.Width;
            panel11.Location = panel5.Location;
            //franja azul grande
            panel6.Width = this.Width;
            panel6.Location = new Point(0, 95);
            panel7.Width = panel6.Width;
            panel7.Location = panel6.Location;
            panel10.Width = panel6.Width;
            panel10.Location= panel6.Location;
            panel13.Width = panel6.Width;
            panel13.Location = panel6.Location;
            //Label PLAN AGREGADO
            label6.Location = new Point(panel6.Width / 2 - 100, 9);
            label13.Location = label6.Location;
            label21.Location = label6.Location;
            label17.Location = label6.Location;
            //Panel Amarrillo
            panel1.Size = new Size((this.Width/6),(381));
            panel1.Location = new Point((panel6.Width/50),148);
            //Letra de encabezados
            Font enca = new Font("Calibri",15,FontStyle.Bold);
            label1.Font=enca;
            label1.Location = new Point(panel1.Width/4,17 );
            //letra texto
            label2.Size=new Size((panel1.Width-20),326);
            //Panel Celeste. 1
            panel2.Size = new Size((this.Width/4)-15,381);
            panel2.Location = new Point(this.Width/4,148);
            label3.Width = panel2.Width;
            label3.Location = new Point(0,17);
            label3.Font = enca;
            label10.Width = label3.Width - 30;
            label10.Location =new Point(label3.Location.X + 15,49);

            textBox1.Width = (panel2.Width / 2)-10;
            textBox1.Location = new Point((panel2.Width / 2)-20,263);
            button1.Width = panel2.Width-50;
            button1.Location = new Point(25,307);

            //Panel Celeste .2
            panel3.Size = new Size((this.Width / 4)-15, 381);
            panel3.Location = new Point(this.Width/2,148);
            label4.Width = panel3.Width;
            label4.Location = new Point(0, 17);
            label4.Font = enca;
            label11.Width = label4.Width - 30;
            label11.Location = new Point(label4.Location.X+15,49);

            textBox2.Width = (panel3.Width / 2) - 10;
            textBox2.Location = new Point((panel3.Width / 2) - 20, 263);
            button2.Width = panel3.Width - 50;
            button2.Location = new Point(25, 307);
            //Panel Celeste .3
            panel4.Size = new Size((this.Width/4)-15,381);
            panel4.Location = new Point((this.Width*75/100), 148);
            label5.Width = panel4.Width;
            label5.Location = new Point(0, 17);
            label5.Font = enca;
            label12.Width = label5.Width - 30;
            label12.Location = new Point(label5.Location.X+15,49);

            textBox3.Width = (panel4.Width / 2) - 10;
            textBox3.Location = new Point((panel4.Width / 2) - 20, 263);
            button3.Width = panel3.Width - 50;
            button3.Location = new Point(25, 307);
            



        }
    }
}
