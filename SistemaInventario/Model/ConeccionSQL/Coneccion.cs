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
                // connectionString = "server=LAPTOP-V5E4QOLS\\SQLEXPRESS; Database = sistemaInventario ; Integrated Security=True";
                connectionString = @"server= OMARSANDOVAL\SQLEXPRESS; Database = sistemaInventario ; Integrated Security=True";
                  }

                //Solo accedido de una clase eradada
                protected SqlConnection GetConnection()
                {
                    return new SqlConnection(connectionString);
                }
        }
}
