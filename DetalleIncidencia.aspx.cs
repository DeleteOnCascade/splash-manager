using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using MySql.Data.MySqlClient;
using System.Windows.Forms;
using System.IO;

namespace ProyectoFinalDAM
{
    public partial class DetalleIncidencia : System.Web.UI.Page
    {
        Conexion con = new Conexion();
        MySqlCommand command;
        MySqlDataAdapter da;
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"]==null)
                Response.Redirect("Login.aspx");
            lbUsername.Text = "Usuario: " + Session["username"];
            if (!this.IsPostBack)
            {
                lb_IdIncidencia.Text = Request.QueryString["id"].ToString();
                this.GetIncidencia();
                this.GetHistorial();
                this.CargarUsuarios();
                this.CargarArchivos();               
            }
            if (((int)Session["rol"] == 2))
            {
                btAsignar.Enabled = false;
                dropListAsignar.Enabled = false;
            }
        }

        private void GetIncidencia()
        {
            MySqlConnection conc = con.Conectar();
            command = new MySqlCommand("select * from incidencia where id_incidencia = @incidencia", conc);
            command.Parameters.AddWithValue("@incidencia", lb_IdIncidencia.Text);
            command.ExecuteNonQuery();
            dt = new DataTable();
            da = new MySqlDataAdapter(command);
            da.Fill(dt);

            tbMotivo.Text = dt.Rows[0][1].ToString();
            tbDescripcion.Text = dt.Rows[0][2].ToString();
            lbCategoria.Text = "Categoría: " + dt.Rows[0][3].ToString();
            lbPrioridad.Text = "Prioridad: " + dt.Rows[0][4].ToString();
            lbEstado.Text = "Estado: " + dt.Rows[0][5].ToString();
            lbInformador.Text = "Informador: " + dt.Rows[0][6].ToString();
            lbResponsable.Text = "Responsable: " + dt.Rows[0][7].ToString();
            lbFechaActualizacion.Text = "Fecha actualización: " + dt.Rows[0][8].ToString();
            lbProyecto.Text = "Proyecto: " + dt.Rows[0][9].ToString();
            lbFechaCreacion.Text = "Fecha de creación: " + dt.Rows[0][10].ToString();
            lbEstado.CssClass = lbEstado.Text.Substring(8);
            command = new MySqlCommand("select * from nota where id_incidencia = @incidencia", conc);
            command.Parameters.AddWithValue("@incidencia", lb_IdIncidencia.Text);
            command.ExecuteNonQuery();
            dt = new DataTable();
            da = new MySqlDataAdapter(command);
            da.Fill(dt);
            lvNota.DataSource = dt;
            lvNota.DataBind();
            command.Dispose();
            conc.Close();
        }

        protected void CargarUsuarios()
        {
            MySqlConnection conc = con.Conectar();
            command = new MySqlCommand("SELECT username FROM usuario WHERE username != 'cualquiera' AND rol = '1'", conc);
            dropListAsignar.DataSource = command.ExecuteReader();
            dropListAsignar.DataValueField = "username";
            dropListAsignar.DataBind();
            command.Dispose();
            conc.Close();
        }

        protected void EliminarIncidencia(object sender, EventArgs e)
        {
            
                DialogResult dr = MessageBox.Show("¿Borrar definitivamente la incidencia? \n\t(¡no hay vuelta atrás!)","Confirmación", MessageBoxButtons.YesNo);
                switch (dr)
                {
                    case DialogResult.Yes:
                        try
                        {
                            MySqlConnection conn = con.Conectar();
                            string query_historial = "DELETE FROM historial WHERE id_incidencia = @id_incidencia";
                            string query_nota = "DELETE FROM nota WHERE id_incidencia = @id_incidencia";
                            string query_incidencia = "DELETE FROM incidencia WHERE id_incidencia = @id_incidencia";

                            MySqlCommand cmd_his = new MySqlCommand(query_historial, conn);
                            MySqlCommand cmd_not = new MySqlCommand(query_nota, conn);
                            MySqlCommand cmd_inc = new MySqlCommand(query_incidencia, conn);

                            cmd_his.Parameters.AddWithValue("@id_incidencia", lb_IdIncidencia.Text);
                            cmd_not.Parameters.AddWithValue("@id_incidencia", lb_IdIncidencia.Text);
                            cmd_inc.Parameters.AddWithValue("@id_incidencia", lb_IdIncidencia.Text);

                            cmd_his.ExecuteNonQuery();
                            cmd_not.ExecuteNonQuery();

                            if (cmd_inc.ExecuteNonQuery() ==  1)
                                MessageBox.Show("INCIDENCIA BORRADA");
                            else
                                MessageBox.Show("INCIDENCIA NO BORRADA");

                            cmd_his.Dispose();
                            cmd_not.Dispose();
                            cmd_inc.Dispose();
                            conn.Close();

                            Response.Redirect("Home.aspx");
                        }
                        catch (Exception ex)
                        {
                            MessageBox.Show(ex.Message);
                        }
                        break;
                    case DialogResult.No:
                        break;
                }
            }

        protected void AgregarNota(object sender, EventArgs e)
        {
            string query = "INSERT INTO nota (id_nota,dsc_nota,fch_creacion,usuario,id_incidencia) " +
                "VALUES (id_nota,@dsc_nota,@fch_creacion,@usuario,@id_incidencia)";

            MySqlConnection conn = con.Conectar();
            MySqlCommand cmd = new MySqlCommand(query, conn);
            
            cmd.Parameters.AddWithValue("@dsc_nota", tbNota.Text);
            cmd.Parameters.AddWithValue("@fch_creacion", DateTime.Now);
            cmd.Parameters.AddWithValue("@usuario", Session["username"]);
            cmd.Parameters.AddWithValue("@id_incidencia", lb_IdIncidencia.Text);

            int n = cmd.ExecuteNonQuery();

            InsertaEnHistorial(0);
            ActualizaFchIncidencia();

            if (n>0)
            {
                Response.Redirect("DetalleIncidencia.aspx?id="+lb_IdIncidencia.Text);
                cmd.Dispose();
                conn.Close();
            }
        }

        protected void CambiarEstadoIncidencia(object sender, EventArgs e)
        {
            string query = "UPDATE incidencia SET estado = @estado WHERE id_incidencia = @id_incidencia";

            MySqlConnection conn = con.Conectar();
            MySqlCommand cmd = new MySqlCommand(query, conn);

            cmd.Parameters.AddWithValue("@estado", dropListEstado.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@id_incidencia", lb_IdIncidencia.Text);
            cmd.ExecuteNonQuery();

            InsertaEnHistorial(1);
            ActualizaFchIncidencia();

            Response.Redirect("DetalleIncidencia.aspx?id="+lb_IdIncidencia.Text);
            cmd.Dispose();
            conn.Close();
        }  

        protected void AsignarIncidencia(object sender, EventArgs e)
        {
            string query = "UPDATE incidencia SET responsable = @responsable WHERE id_incidencia = @id_incidencia";

            MySqlConnection conn = con.Conectar();
            MySqlCommand cmd = new MySqlCommand(query, conn);

            cmd.Parameters.AddWithValue("@responsable", dropListAsignar.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@id_incidencia", lb_IdIncidencia.Text);
            cmd.ExecuteNonQuery();

            if (lbEstado.Text.Substring(8).Equals("nueva"))
            {
                query = "UPDATE incidencia SET estado = @estado WHERE id_incidencia = @id_incidencia";
                cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@estado", "asignada");
                cmd.Parameters.AddWithValue("@id_incidencia", lb_IdIncidencia.Text);
                cmd.ExecuteNonQuery();
            }

            InsertaEnHistorial(2);
            ActualizaFchIncidencia();

            Response.Redirect("DetalleIncidencia.aspx?id="+lb_IdIncidencia.Text);
            cmd.Dispose();
            conn.Close();
        }

        protected void ActualizaFchIncidencia()
        {
            string query = "UPDATE incidencia SET fch_actualizacion = @fch_actualizacion WHERE id_incidencia = @id_incidencia";
            MySqlConnection conn = con.Conectar();
            MySqlCommand cmd = new MySqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@fch_actualizacion", DateTime.Now);
            cmd.Parameters.AddWithValue("@id_incidencia", lb_IdIncidencia.Text);
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();
        }

        private void InsertaEnHistorial(int opcion)
        {
            string campo = "";
            string cambio = "";

            switch (opcion)
            {
                case 0:
                    campo = "Nota añadida";
                    break;
                case 1:
                    campo = "Estado cambiado";
                    cambio = lbEstado.Text.Substring(7) + " => " + dropListEstado.SelectedItem.Text;
                    break;
                case 2:
                    campo = "Asignada a";
                    cambio = lbResponsable.Text.Substring(12) + " => " + dropListAsignar.SelectedItem.Text;
                    break;
                case 3:
                    campo = "Archivo adjuntado";
                    break;
            }

            string query = "INSERT INTO historial (fch_modificado,usuario,campo,cambio,id_incidencia) " +
                "VALUES (@fch_modificado,@usuario,@campo,@cambio,@id_incidencia)";

            MySqlConnection conn = con.Conectar();
            MySqlCommand cmd = new MySqlCommand(query, conn);

            cmd = new MySqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@fch_modificado", DateTime.Now);
            cmd.Parameters.AddWithValue("@usuario", Session["username"]);
            cmd.Parameters.AddWithValue("@campo", campo);
            cmd.Parameters.AddWithValue("@cambio", cambio);
            cmd.Parameters.AddWithValue("@id_incidencia", lb_IdIncidencia.Text);
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();
        }

        protected void GetHistorial()
        {
            MySqlConnection conc = con.Conectar();
            command = new MySqlCommand("SELECT * FROM historial WHERE id_incidencia = @incidencia", conc);
            command.Parameters.AddWithValue("@incidencia", lb_IdIncidencia.Text);
            command.ExecuteNonQuery();
            dt = new DataTable();
            da = new MySqlDataAdapter(command);
            da.Fill(dt);
            listViewHistorial.DataSource = dt;
            listViewHistorial.DataBind();
            command.Dispose();
            conc.Close();
        }

        protected void SubirArchivo(object sender, EventArgs e)
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
                if(flag == 1)
                {
                    string query = "INSERT INTO archivo (id_archivo, nombre, id_incidencia) VALUES (id_archivo,@nombre,@id_incidencia)";

                    MySqlConnection conn = con.Conectar();
                    MySqlCommand cmd = new MySqlCommand(query, conn);

                    cmd.Parameters.AddWithValue("@nombre", nombre+extension);
                    cmd.Parameters.AddWithValue("@id_incidencia", lb_IdIncidencia.Text);
                    int n = cmd.ExecuteNonQuery();
                    if(n > 0)
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
                    ActualizaFchIncidencia();
                    InsertaEnHistorial(3);
                    Response.Redirect("DetalleIncidencia.aspx?id=" + lb_IdIncidencia.Text);
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

        protected void CargarArchivos()
        {
            string query = "SELECT * FROM archivo WHERE id_incidencia = @incidencia";
            MySqlConnection conc = con.Conectar();
            MySqlCommand cmd = new MySqlCommand(query, conc);
            cmd.Parameters.AddWithValue("@incidencia", lb_IdIncidencia.Text);
            cmd.ExecuteNonQuery();
            DataTable dt = new DataTable();
            MySqlDataAdapter da = new MySqlDataAdapter(cmd);
            da.Fill(dt);
            gridArchivos.DataSource = dt;
            gridArchivos.DataBind();
            cmd.Dispose();
            conc.Close();    
        }

        protected void EliminarArchivo(object sender, EventArgs e)
        {
            string query = "DELETE archivo WHERE id_incidencia = @incidencia";
            MySqlConnection conc = con.Conectar();
            MySqlCommand cmd = new MySqlCommand(query, conc);
            cmd.Parameters.AddWithValue("@incidencia", lb_IdIncidencia.Text);
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            conc.Close();
        }

        protected void SalirLogout(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

        protected void BuscarIncidencia(object sender, EventArgs e)
        {
            Response.Redirect("DetalleIncidencia.aspx?id=" + tbIncidencia.Text);
        }

    }
}