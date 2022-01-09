using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;

namespace ProyectoFinalDAM
{
    public partial class CambiarPWD : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        Conexion con = new Conexion();
        MySqlCommand command;

        protected void CambiarPassword(object sender, EventArgs e)
        {
            if (CompruebaFormulario())
            {
                if (ConfirmaPass())
                {
                    try
                    {
                        MySqlConnection conn = con.Conectar();
                        string query = "UPDATE usuario SET password = @password WHERE id_usuario = @id_usuario";
                        command = new MySqlCommand(query, conn);
                        command.Parameters.AddWithValue("@password", Encrypt.Encriptar(tbPassword.Text.Trim()));
                        command.Parameters.AddWithValue("@id_usuario", ObtenerID(conn));

                        int n = command.ExecuteNonQuery();

                        if (n > 0)
                        {
                            conn.Close();
                            MessageBox.Show("Contraseña actualizada correctamente");
                            Response.Redirect("~/UsuarioIncidencia.aspx");
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
                else
                {
                    lbError.Text = "Las contraseñas no coinciden.";
                    lbError.Visible=true;
                }
            }

        }

        protected int ObtenerID(MySqlConnection conn)
        {
            string query = "SELECT id_usuario FROM usuario WHERE username = @username AND password = @clave";
            MySqlCommand cmd = new MySqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@username", Session["username"]);
            cmd.Parameters.AddWithValue("@clave", Encrypt.Encriptar(tbAntigua.Text.Trim()));
            int id = (int)cmd.ExecuteScalar();
            cmd.Dispose();
            return id;
        }

        protected Boolean ConfirmaPass()
        {
            Boolean esIgual = false;
            if (tbPassword.Text.Trim().Equals(tbConfirmacion.Text.Trim()))
            {
                esIgual = true;
            }
            return esIgual;
        }

        protected Boolean CompruebaFormulario()
        {
            Boolean comprobado = false;
            if (String.IsNullOrEmpty(tbAntigua.Text) || String.IsNullOrEmpty(tbPassword.Text) || String.IsNullOrEmpty(tbConfirmacion.Text))
            {
                if (String.IsNullOrEmpty(tbAntigua.Text))
                    tbAntigua.BorderColor = System.Drawing.Color.Red;
                if (String.IsNullOrEmpty(tbPassword.Text))
                    tbPassword.BorderColor = System.Drawing.Color.Red;
                if (String.IsNullOrEmpty(tbConfirmacion.Text))
                    tbConfirmacion.BorderColor = System.Drawing.Color.Red;
            }
            else
                comprobado = true;

            return comprobado;
        }

        protected void Volver(object sender, EventArgs e)
        {
            Response.Redirect("~/UsuarioIncidencia.aspx");
        }
    }
}