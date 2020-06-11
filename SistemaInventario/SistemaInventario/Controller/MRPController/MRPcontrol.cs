using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SistemaInventario.Model.MRP_Pojo;
namespace SistemaInventario.Controller.MRPController
{
    class MRPcontrol
    {
        //Mostrar los metodos
        public static DataTable MostrarDato(string dato)
        {
            MRPPojo m = new MRPPojo();

            return m.MostrarDatos(dato);
        }

        //Mostrar Costos
        public static DataTable MostrarCosto()
        {
            MRPPojo m = new MRPPojo();

            return m.MostrarCosto();
        }
    }
}
