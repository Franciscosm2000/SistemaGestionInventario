using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Windows.Forms.DataVisualization.Charting;
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

        //tabla completa lxl

        public static DataTable MostrarLxL()
        {
            MRPPojo m = new MRPPojo();

            return m.LotexLoteCompleto();
        }

        public static ArrayList Tipo()
        {
            MRPPojo m = new MRPPojo();

            return m.MostrarTipo();
        }

        public static ArrayList MostrarDatoCosto()
        {
            MRPPojo m = new MRPPojo();

            return m.MostrarDatoCosto();
        }

        public static void ExportarExcel(DataGridView tabla)
        {
            MRPPojo.exportaraexcel(tabla);
        }

    }
}
