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

        protected void btIngresar_Click(object sender, EventArgs e)
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
    }
}