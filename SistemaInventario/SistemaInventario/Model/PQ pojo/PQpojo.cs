using SistemaInventario.Model.ConeccionSQL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SistemaInventario.Model.PQ_Pojo
{
    class PQpojo : Coneccion
    {
        //variables 
        private int Id_Lis_Material;
        private string Material;
        private int Cantidad;
        private int Total_Acumulado;
        private int porcentaje;

        public PQpojo() { }

        /*constructor para mi primer paso modelo pq*/
        public PQpojo(int id_Lis_Material, string material, int cantidad)
        {
            this.Id_Lis_Material1 = id_Lis_Material;
            this.Material1 = material;
            this.Cantidad = cantidad;
        }

        /*constructor para mi primer paso modelo pq*/
        public PQpojo(int id_Lis_Material, string material, int cantidad, int total_Acumulado, int porcentaje)
        {
            this.Id_Lis_Material = id_Lis_Material;
            this.Material = material;
            this.Cantidad = cantidad;
            this.Total_Acumulado1 = total_Acumulado;
            this.Porcentaje = porcentaje;
        }

        /*contructor para mi segundo paso modelo pq*/
        public PQpojo(string material, int cantidad, int total_Acumulado, int porcentaje)
        {
            this.Material = material;
            this.Cantidad = cantidad;
            this.Total_Acumulado1 = total_Acumulado;
            this.Porcentaje = porcentaje;
        }

        //get y set
        public int Id_Lis_Material1 { get => Id_Lis_Material; set => Id_Lis_Material = value; }
        public string Material1 { get => Material; set => Material = value; }
        public int Cantidad1 { get => this.Cantidad; set => this.Cantidad = value; }
        public int Total_Acumulado1 { get => Total_Acumulado; set => Total_Acumulado = value; }
        public int Porcentaje { get => porcentaje; set => porcentaje = value; }

        //llamando a los procesos almacenados

        //mostrar metodos

        /*------------------------------modelo parte 1------------------------*/

        /*Mi tabla P*/
        public DataTable MostrarModeloP1()
        {
            DataTable tab = new DataTable();

            try
            {
                using (var Conexion = GetConnection())
                {
                    Conexion.Open();
                    using (var comando = new SqlCommand())
                    {
                        comando.Connection = Conexion;
                        comando.CommandText = "Modelo_p1";
                        comando.CommandType = CommandType.StoredProcedure;
                        SqlDataAdapter adp = new SqlDataAdapter(comando);
                        adp.Fill(tab);
                    }//segundo using
                }//primer using
            }
            catch (Exception e)
            {
                MessageBox.Show("Error en la conexion\n" + e.Message);
            }

            return tab;
        }
        
        /*Mi tabla Q*/
        public DataTable MostrarModeloQ1()
        {
            DataTable tab = new DataTable();

            try
            {
                using (var Conexion = GetConnection())
                {
                    Conexion.Open();
                    using (var comando = new SqlCommand())
                    {
                        comando.Connection = Conexion;
                        comando.CommandText = "Modelo_q1";
                        comando.CommandType = CommandType.StoredProcedure;
                        SqlDataAdapter adp = new SqlDataAdapter(comando);
                        adp.Fill(tab);
                    }//segundo using
                }//primer using
            }
            catch (Exception e)
            {
                MessageBox.Show("Error en la conexion\n" + e.Message);
            }

            return tab;
        }

        /*------------------------------modelo parte 2------------------------*/

        /*Mi tabla P*/
        public DataTable MostrarModeloP2()
        {
            DataTable tab = new DataTable();

            try
            {
                using (var Conexion = GetConnection())
                {
                    Conexion.Open();
                    using (var comando = new SqlCommand())
                    {
                        comando.Connection = Conexion;
                        comando.CommandText = "Modelo_p2";
                        comando.CommandType = CommandType.StoredProcedure;
                        SqlDataAdapter adp = new SqlDataAdapter(comando);
                        adp.Fill(tab);
                    }//segundo using
                }//primer using
            }
            catch (Exception e)
            {
                MessageBox.Show("Error en la conexion\n" + e.Message);
            }

            return tab;
        }

        /*Mi tabla Q*/
        public DataTable MostrarModeloQ2()
        {
            DataTable tab = new DataTable();

            try
            {
                using (var Conexion = GetConnection())
                {
                    Conexion.Open();
                    using (var comando = new SqlCommand())
                    {
                        comando.Connection = Conexion;
                        comando.CommandText = "Modelo_q2";
                        comando.CommandType = CommandType.StoredProcedure;
                        SqlDataAdapter adp = new SqlDataAdapter(comando);
                        adp.Fill(tab);
                    }//segundo using
                }//primer using
            }
            catch (Exception e)
            {
                MessageBox.Show("Error en la conexion\n" + e.Message);
            }

            return tab;
        }



 

    }
}
