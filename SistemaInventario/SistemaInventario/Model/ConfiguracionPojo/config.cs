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

                        }
                        comando.CommandText = proceso;
                        comando.CommandType = CommandType.StoredProcedure;

                        SqlDataAdapter adp = new SqlDataAdapter(comando);
                        adp.Fill(res);
                        comando.Parameters.Clear();

                    }//fin segundo using
                }//fin primer using
            }
            catch (Exception e) { MessageBox.Show(e.Message); }

            return res;
        }
    }
}
