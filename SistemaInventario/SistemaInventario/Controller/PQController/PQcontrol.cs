using SistemaInventario.Model.PQ_Pojo;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaInventario.Controller.PQController
{
    class PQcontrol
    {
        //mostrar las tablas PQ

        /*parte 1 P*/
        public static DataTable Mostrar_P1()
        {
            PQpojo entrada = new PQpojo();
            return entrada.MostrarModeloP1();
        }

        /*parte 1 Q*/
        public static DataTable Mostrar_Q1()
        {
            PQpojo entrada = new PQpojo();
            return entrada.MostrarModeloQ1();
        }

        /*parte 2 P*/
        public static DataTable Mostrar_P2()
        {
            PQpojo entrada = new PQpojo();
            return entrada.MostrarModeloP2();
        }

        /*parte 2 Q*/
        public static DataTable Mostrar_Q2()
        {
            PQpojo entrada = new PQpojo();
            return entrada.MostrarModeloQ2();
        }
    }
}
