using SistemaInventario.Model.ConfiguracionPojo;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

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
        public static void agregar(DataGridView a)
        {
            config m = new config();
            m.eventagregar(a);
        }

        public static  void actualizar1(TextBox a,DataGridView b)
        {
            config m = new config();
            m.actulizarplan(a,b);
        }

        public static void actualizar2(TextBox a, DataGridView b)
        {
            config m = new config();
            m.actualizarAlex(a,b);
        }

    }
}
