﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using SistemaInventario.Model.ConeccionSQL;

namespace SistemaInventario.Model.MRP_Pojo
{
    class MRPPojo : Coneccion
    {
        //Variables
       
        private int necesidadesBrutas;
        private int recepcionesProgramadas;
        private int disponible;
        private int necesidadesNetas;
        private int lanzamientoOrden;
        private int recepcionOrden;

        //Constructor

        public MRPPojo(int necesidadesB=0, int recepcionesP=0, int dispo=0 , int necesidadesN=0, int lanzamientoO=0, int recepcionO = 0)
        {
            this.NecesidadesBrutas = necesidadesB;
            this.RecepcionesProgramadas = recepcionesP;
            this.Disponible = dispo;
            this.NecesidadesNetas = necesidadesN;
            this.LanzamientoOrden = lanzamientoO;
            this.RecepcionOrden = recepcionO;
        }

        //Get y Set
        public int NecesidadesBrutas { get => necesidadesBrutas; set => necesidadesBrutas = value; }
        public int RecepcionesProgramadas { get => recepcionesProgramadas; set => recepcionesProgramadas = value; }
        public int Disponible { get => disponible; set => disponible = value; }
        public int NecesidadesNetas { get => necesidadesNetas; set => necesidadesNetas = value; }
        public int LanzamientoOrden { get => lanzamientoOrden; set => lanzamientoOrden = value; }
        public int RecepcionOrden { get => recepcionOrden; set => recepcionOrden = value; }
            
        //Creacion de funciones llamando a los procesos almacenados/
    
        //Mostrar metodos 
       public DataTable MostrarDatos(string tipo)
            {
                DataTable res = new DataTable();
                string proceso = null;

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
                            case "LXL":
                                proceso = "MetodoLXL";
                                break;
                            case "EOQ":
                                proceso = "MetodoPOQ";
                                break;
                            case "POQ":
                                proceso = "MetodoEOQ";
                                break;
                        }
                            comando.CommandText = proceso;
                            comando.CommandType = CommandType.StoredProcedure;
                            comando.Parameters.AddWithValue("@idProducto", 1);

                            SqlDataAdapter adp = new SqlDataAdapter(comando);
                            adp.Fill(res);
                            comando.Parameters.Clear(); 

                        }//fin segundo using
                    }//fin primer using
                }
                catch (Exception e) { MessageBox.Show(e.Message); }

                return res;
            }

        //Mostrar tabla de costos

        public DataTable MostrarCosto()
        {
            DataTable res = new DataTable();

            try
            {
                using (var coneccion = GetConnection())
                {
                    coneccion.Open();
                    using (var comando = new SqlCommand())
                    {
                        comando.Connection = coneccion;


                        comando.CommandText = "tablaCosto";
                        comando.CommandType = CommandType.StoredProcedure;

                        SqlDataAdapter adp = new SqlDataAdapter(comando);
                        adp.Fill(res);

                    }//fin segundo using
                }//fin primer using
            }
            catch (Exception e) { MessageBox.Show(e.Message); }

            return res;
        }

    }
}