using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MySql.Data.MySqlClient;

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
                string query = "SELECT rol FROM usuario WHERE username = @username AND password = @password";
                command = new MySqlCommand(query, conn);
                command.Parameters.AddWithValue("@username", tbUsername.Text.Trim());
                command.Parameters.AddWithValue("@password", Encrypt.Encriptar(tbPassword.Text.Trim()));
                
                MySqlDataReader lee = command.ExecuteReader();

                if (lee.Read())
                {
                    lee.Close();
                    Session["username"] = tbUsername.Text.Trim();
                    if (GetRol(command)==1)
                        Response.Redirect("~/Home.aspx");
                    else if (GetRol(command)==2)
                        Response.Redirect("~/UsuarioIncidencia.aspx");
                    conn.Close();
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

        protected void CambiarVisibilidad(object sender, ImageClickEventArgs e)
        {
            if (btVer.ImageUrl.Equals("Resources/Images/ojo_cerrado.png"))
            {
                tbPassword.TextMode = TextBoxMode.SingleLine;
                btVer.ImageUrl = "Resources/Images/ojo_abierto.png";
            }
            else
            {
                tbPassword.TextMode = TextBoxMode.Password;
                btVer.ImageUrl = "Resources/Images/ojo_cerrado.png";
            }
        }

        protected int GetRol(MySqlCommand command)
        {
            MySqlConnection conn = con.Conectar();
            int rol = (int)command.ExecuteScalar();
            Session["rol"] = rol;
            return rol;
        }

    }
}