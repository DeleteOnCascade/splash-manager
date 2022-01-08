using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MySql.Data.MySqlClient;
using System.Windows.Forms;
using System.IO;

namespace ProyectoFinalDAM
{
    public partial class RegistroIncidencia : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"]==null)
            Response.Redirect("Login.aspx");
            lbUsername.Text = "Usuario: " + Session["username"];
        }

        Conexion con = new Conexion();
        MySqlCommand command;

        protected void RegistrarIncidencia(object sender, EventArgs e)
        {
            try
            {
                MySqlConnection conn = con.Conectar();

                string query = "INSERT INTO incidencia (id_incidencia,motivo,dsc_incidencia,categoria,prioridad,estado,informador,responsable,fch_actualizacion,proyecto,fch_creacion)" +
                    " VALUES (id_incidencia,@motivo,@dscIncidencia,@categoria,@prioridad,@estado,@informador,'',@fecha_act,'',@fch_creacion)";
                command = new MySqlCommand(query, conn);
                command.Parameters.AddWithValue("@motivo", tbMotivo.Text);
                command.Parameters.AddWithValue("@dscincidencia", tbDescripcion.Text);
                command.Parameters.AddWithValue("@categoria", dropListCategoria.SelectedItem.ToString());
                command.Parameters.AddWithValue("@prioridad", dropListPrioridad.SelectedValue.ToString());
                command.Parameters.AddWithValue("@estado", "nueva");
                command.Parameters.AddWithValue("@informador", Session["username"].ToString());
                command.Parameters.AddWithValue("@fecha_act", DateTime.Now);
                command.Parameters.AddWithValue("@fch_creacion", DateTime.Now);
                int n = command.ExecuteNonQuery();

                InsertarHistorial(conn);
                SubirArchivo();

                if (n>0)
                {
                    Response.Redirect("UsuarioIncidencia.aspx");
                    command.Dispose();
                    conn.Close();
                }
                command.Dispose();
                conn.Close();
            }
            catch (Exception ex)
            {
                lbError.Text = ex.Message;
                lbError.Visible=true;
            }
        }

        protected void SubirArchivo()
        {
            string nombre = "";
            string extension = "";
            int size = 0;
            int flag = 0;

            if (fuArchivo.HasFile == true)
            {
                nombre = Path.GetFileNameWithoutExtension(fuArchivo.FileName);
                extension = Path.GetExtension(fuArchivo.FileName);
                size = fuArchivo.PostedFile.ContentLength;
                switch (extension.ToLower())
                {
                    case ".doc":
                    case ".docx":
                    case ".pdf":
                    case ".png":
                    case ".jpg":
                    case ".txt":
                        flag = 1;
                        break;
                    default:
                        flag= 0;
                        break;
                }
                if (flag == 1)
                {
                    string query = "INSERT INTO archivo (id_archivo, nombre, id_incidencia) VALUES (id_archivo,@nombre,@id_incidencia)";
                    MySqlConnection conn = con.Conectar();
                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@nombre", nombre+extension);
                    cmd.Parameters.AddWithValue("@id_incidencia", GetIncidencia());
                    int n = cmd.ExecuteNonQuery();
                    if (n > 0)
                    {
                        MessageBox.Show("Archivo subido correctamente");
                        cmd.Dispose();
                        conn.Close();
                    }
                    else
                    {
                        MessageBox.Show("No se ha podido subir el archivo");
                    }

                    fuArchivo.SaveAs(Server.MapPath("~/Files/"+nombre+extension));
                }
                else
                {
                    MessageBox.Show("Solo están permitidos los archivos .doc, .docx, .pdf, .png, .jpg, .txt");
                }
            }
            else
            {
                MessageBox.Show("Seleccione un archivo primero");
            }

        }

        protected int GetIncidencia()
        {
            MySqlConnection conn = con.Conectar();
            string query = "SELECT * FROM incidencia WHERE id_incidencia = (SELECT MAX(id_incidencia) FROM incidencia)";
            MySqlCommand cmd = new MySqlCommand(query, conn);
            int id_incidencia = (int)cmd.ExecuteScalar();
            cmd.Dispose();
            conn.Close();
            return id_incidencia;
        }

        protected void InsertarHistorial(MySqlConnection conn)
        {
            string query = "INSERT INTO historial (fch_modificado,usuario,campo,cambio,id_incidencia) " +
            "VALUES (@fch_modificado,@usuario,@campo,@cambio,@id_incidencia)";
            MySqlCommand cmd = new MySqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@fch_modificado", DateTime.Now);
            cmd.Parameters.AddWithValue("@usuario", Session["username"]);
            cmd.Parameters.AddWithValue("@campo", "Nueva Incidencia");
            cmd.Parameters.AddWithValue("@cambio", "");
            cmd.Parameters.AddWithValue("@id_incidencia", GetIncidencia());
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();
        }

        protected void BuscarIncidencia(object sender, EventArgs e)
        {
            Response.Redirect("DetalleIncidencia.aspx?id=" + tbIncidencia.Text);
        }
    }
}