using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MySql.Data.MySqlClient;
using System.Security.Cryptography;
using System.Text;

namespace ProyectoFinalDAM
{
    public partial class Login : System.Web.UI.Page
    {
        Conexion con = new Conexion();
        MySqlCommand command;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Entrar(object sender, EventArgs e)
        {
            try
            {
                MySqlConnection conn = con.Conectar();
                
                string query = "SELECT * FROM usuario WHERE username = @username AND password = @password ";
                command = new MySqlCommand(query, conn);
                command.Parameters.AddWithValue("@username", tbUsername.Text.Trim());
                command.Parameters.AddWithValue("@password", tbPassword.Text.Trim());
                
                MySqlDataReader lee = command.ExecuteReader();

                if (lee.Read())
                {
                    conn.Close();
                    Session["username"] = tbUsername.Text.Trim();
                    Response.Redirect("~/Home.aspx");
                }
                else
                {
                    lbError.Visible=true;
                }
                conn.Close();
            }
            catch (Exception ex)
            {
                lbError.Text = ex.Message;
                lbError.Visible=true;
            }
        }

        protected string encriptar(string pwd)
        {
            SHA256 sha256 = SHA256Managed.Create();
            ASCIIEncoding encoding = new ASCIIEncoding();
            byte[] stream = null;
            StringBuilder sb = new StringBuilder();
            stream = sha256.ComputeHash(encoding.GetBytes(pwd));
            for (int i = 0; i < stream.Length; i++) sb.AppendFormat("{0:x2}", stream[i]);
            return sb.ToString();
        }
    }
}