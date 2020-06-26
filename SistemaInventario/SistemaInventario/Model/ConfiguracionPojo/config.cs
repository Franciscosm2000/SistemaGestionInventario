using Microsoft.VisualBasic;
using SistemaInventario.Model.ConeccionSQL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SistemaInventario.Model.ConfiguracionPojo
{
    class config : Coneccion
    {
        public DataTable MostrarDatos(string tipo)
        {
            DataTable res = new DataTable();
            string proceso = "";

            try
            {
                using (var coneccion = GetConnection())
                {
                    coneccion.Open();
                    using (var comando = new SqlCommand())
                    {
                        comando.Connection = coneccion;

                        switch (tipo)
                        {
                            case "PM":
                                proceso = "ProgramaMaestro";
                                break;
                            case "LM":
                                proceso = "Registro_inventario";
                                break;

                            case "DC":
                                proceso = "mostrarDatosAlexander";
                                break;

                        }

                        if (proceso.Equals("mostrarDatosAlexander"))
                        {
                            comando.CommandText = proceso;
                            comando.CommandType = CommandType.StoredProcedure;

                            SqlDataAdapter adp = new SqlDataAdapter(comando);
                            adp.Fill(res);
                        }
                        else
                        {
                            comando.CommandText = proceso;
                            comando.CommandType = CommandType.StoredProcedure;

                            SqlDataAdapter adp = new SqlDataAdapter(comando);
                            adp.Fill(res);
                        }

                        comando.Parameters.Clear();

                    }//fin segundo using
                }//fin primer using
            }
            catch (Exception e) { MessageBox.Show(e.Message); }

            return res;
        }

        public void eventagregar(DataGridView dbe)
        {

            try
            {
                using (var coneccion = GetConnection())
                {
                    coneccion.Open();
                    using(var comando = new SqlCommand())
                    {
                        comando.Connection = coneccion;
                        string a = "";
                        long b = 0;
                        a = Convert.ToString(Interaction.InputBox("Ingrese la cantidad : "));
                        bool c = long.TryParse(a, out b);
                        if (c == true)
                        {
                            int cp = Convert.ToInt32(dbe.Rows.Count);
                            string consult = "insert into Programa_Maestro values (1," + cp + "," + a + ")";
                            SqlCommand res = new SqlCommand(consult, coneccion);
                            res.ExecuteNonQuery();

                            MessageBox.Show("Valor guardado Exitosamente");


                        }
                        else
                        {
                            MessageBox.Show("Valor no permitido.", "Importante!!", MessageBoxButtons.OK);
                        }
                    }
                }
            }
            catch (Exception e)
            {
                MessageBox.Show(" Error : " + e, "Importante");
            };

            }

        public void actulizarplan(TextBox tex,DataGridView dbe)
        {
            try
            {
                using (var coneccion = GetConnection())
                {
                    coneccion.Open();
                    using(var comando=new SqlCommand())
                    {
                        string a = "";
                        long b = 0;
                        a = tex.Text;
                        bool c = long.TryParse(a, out b);
                        if (c == true)
                        {
                            int cp = Convert.ToInt32(dbe.CurrentRow.Cells["Semana"].Value.ToString());
                            string consult = "update Programa_Maestro set cantidad=" + Convert.ToInt32(a) + " where semana=" + cp + "";
                            SqlCommand res = new SqlCommand(consult, coneccion);
                            res.ExecuteNonQuery();
                            MessageBox.Show("Valor actualizado Exitosamente");


                        }
                        else
                        {
                            MessageBox.Show("Valor no permitido.", "Importante!!", MessageBoxButtons.OK);
                        }
                    }
                }
            }
            catch (Exception e)
            {
                MessageBox.Show("Error : " + e, "Importante!!");
            }
            
        }
            
        public void actualizarAlex(TextBox text,DataGridView dbe)
        {
            try
            {
                using (var coneccion = GetConnection())
                {
                    coneccion.Open();
                    using (var comando = new SqlCommand())
                    {
                        string a = "";
                        long b = 0;
                        a = text.Text;
                        bool c = long.TryParse(a, out b);
                        if (c == true)
                        {
                            string dat = dbe.CurrentRow.Cells["Datos"].Value.ToString();
                            int cp = Convert.ToInt32(a);
                            if (dat == "ss")
                            {
                                if(cp<0 || cp > 100)
                                {
                                    MessageBox.Show("Stock en Porcentaje (0% - 100%)","Importante!!");
                                }
                                else
                                {
                                    string consult = "update Alexander set " + dat + "=" + cp + ";";
                                    SqlCommand res = new SqlCommand(consult, coneccion);
                                    res.ExecuteNonQuery();
                                    MessageBox.Show("Valor actualizado Exitosamente");
                                }

                            }
                            else
                            {
                                string consult = "update Alexander set " + dat + "=" + cp + ";";
                                SqlCommand res = new SqlCommand(consult, coneccion);
                                res.ExecuteNonQuery();
                                MessageBox.Show("Valor actualizado Exitosamente");
                            }
                            


                        }
                        else
                        {
                            MessageBox.Show("Valor no permitido.", "Importante!!", MessageBoxButtons.OK);
                        }
                    }
                }
            }
            catch (Exception e)
            {
                MessageBox.Show("Error : " + e, "Importante!!");
            }
        }

    }
}
