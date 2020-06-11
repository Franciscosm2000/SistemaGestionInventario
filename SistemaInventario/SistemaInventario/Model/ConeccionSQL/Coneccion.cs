using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaInventario.Model.ConeccionSQL
{
        abstract class Coneccion
        {
                //String solo lectura 
                private readonly string connectionString;

                //Constructor
                public Coneccion()
                {
                    //Cadena servidor 
                    connectionString = @"server= DESKTOP-3FB1R0I\SQLEXPRESS; Database = sistemaInventario ; User Id =sa; Password = 1320022077";
                }

                //Solo accedido de una clase eradada
                protected SqlConnection GetConnection()
                {
                    return new SqlConnection(connectionString);
                }
        }
}
