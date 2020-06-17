using SistemaInventario.Model.ConfiguracionPojo;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaInventario.Controller.ConfigController
{
    class configController
    {
        //Mostrar los metodos
        public static DataTable MostrarDato(string dato)
        {
            config m = new config();

            return m.MostrarDatos(dato);
        }

    }
}
