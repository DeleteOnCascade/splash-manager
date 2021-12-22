using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;

namespace ProyectoFinalDAM
{
    public class Conexion
    {
        public MySqlConnection Conectar()
        {
            string conexion = "SERVER=127.0.0.1;PORT=3306;DATABASE=central;UID=root;PASSWORD=;integrated security = true";
            MySqlConnection conn = new MySqlConnection(conexion);
            conn.Open();
            return conn;
        }
    }
}