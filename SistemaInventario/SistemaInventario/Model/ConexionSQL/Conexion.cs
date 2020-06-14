using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaInventario.Model.ConexionSQL
{
    abstract class Conexion
    {
        private readonly string conexionstring;

        public Conexion()
        {
            conexionstring = "server= SAULINO; Database = sistemaInventario ; User Id =sa; Password = Java2019";
        }

        protected SqlConnection GetConnection()
        {
            return new SqlConnection(conexionstring);
        }
    }
}
