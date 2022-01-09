using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;

namespace ProyectoFinalDAM
{
    public partial class Registro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"]==null)
                Response.Redirect("Login.aspx");
        }

        Conexion con = new Conexion();
        MySqlCommand command;

        protected void Registrar(object sender, EventArgs e)
        {
            if (CompruebaFormulario())
            {
                if (ConfirmaPass())
                {
                    try
                    {
                        MySqlConnection conn = con.Conectar();

                        int rol;
                        if (dropListRol.SelectedValue.ToString().Equals("Administrador"))
                            rol = 1;
                        else
                            rol = 2;

                        string query = "INSERT INTO usuario (id_usuario, username, password, rol) VALUES (id_usuario, @username, @password, @rol)";
                        command = new MySqlCommand(query, conn);
                        command.Parameters.AddWithValue("@username", tbUsername.Text.Trim());
                        command.Parameters.AddWithValue("@password", Encrypt.Encriptar(tbPassword.Text.Trim()));
                        command.Parameters.AddWithValue("@rol", rol);
                        int n = command.ExecuteNonQuery();

                        if (n > 0)
                        {
                            conn.Close();
                            MessageBox.Show("Usuario registrado correctamente");
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
                else
                {
                    lbError.Text = "Las contraseñas no coinciden.";
                    lbError.Visible=true;
                }
            }

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
            if (String.IsNullOrEmpty(tbUsername.Text) || String.IsNullOrEmpty(tbPassword.Text) || String.IsNullOrEmpty(tbConfirmacion.Text))
            {
               if(String.IsNullOrEmpty(tbUsername.Text))
                    tbUsername.BorderColor = System.Drawing.Color.Red;
               if(String.IsNullOrEmpty(tbPassword.Text))
                    tbPassword.BorderColor = System.Drawing.Color.Red;
               if(String.IsNullOrEmpty(tbConfirmacion.Text))
                    tbConfirmacion.BorderColor = System.Drawing.Color.Red;
            }
            else
                comprobado = true;

            return comprobado;
        }

        protected void CambiarVisibilidad(object sender, ImageClickEventArgs e)
        {
            if(btVer.ImageUrl.Equals("Resources/Images/ojo_cerrado.png")){
                tbPassword.TextMode = TextBoxMode.SingleLine;
                btVer.ImageUrl = "Resources/Images/ojo_abierto.png";
            }
            else
            {
                tbPassword.TextMode = TextBoxMode.Password;
                btVer.ImageUrl = "Resources/Images/ojo_cerrado.png";
            }
        }

        protected void CambiarVisibilidadConfirmacion(object sender, ImageClickEventArgs e)
        {
            if (btVerConf.ImageUrl.Equals("Resources/Images/ojo_cerrado.png"))
            {
                tbConfirmacion.TextMode = TextBoxMode.SingleLine;
                btVerConf.ImageUrl = "Resources/Images/ojo_abierto.png";
            }
            else
            {
                tbConfirmacion.TextMode = TextBoxMode.Password;
                btVerConf.ImageUrl = "Resources/Images/ojo_cerrado.png";
            }
        }
    
        protected void Volver(object sender, EventArgs e)
        {
            Response.Redirect("~/Home.aspx");
        }
    
    }
}