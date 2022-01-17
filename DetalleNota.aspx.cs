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
    public partial class DetalleNota : System.Web.UI.Page
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
                lbIdNota.Text = Request.QueryString["id"].ToString();
                this.GetNota();
            }
        }

        protected void GetNota()
        {
            MySqlConnection conc = con.Conectar();
            command = new MySqlCommand("select * from nota where id_nota = @id_nota", conc);
            command.Parameters.AddWithValue("@id_nota", lbIdNota.Text);
            command.ExecuteNonQuery();
            dt = new DataTable();
            da = new MySqlDataAdapter(command);
            da.Fill(dt);

            lb_id_nota.Text = dt.Rows[0][0].ToString();
            tbDescripcion.Text = dt.Rows[0][1].ToString();
            lb_fchCreacion.Text = "Fecha creación: " + dt.Rows[0][2].ToString();
            lbUsuario.Text = "Usuario: " + dt.Rows[0][3].ToString();
            lb_id_incidencia.Text = "Incidencia: " + dt.Rows[0][4].ToString();

            command.Dispose();
            conc.Close();
        }

        protected void EliminarNota(object sender, EventArgs e)
        {
            DialogResult dr = MessageBox.Show("¿Borrar definitivamente esta nota? \n\t(¡no hay vuelta atrás!)", "Confirmación", MessageBoxButtons.YesNo);
            switch (dr)
            {
                case DialogResult.Yes:
                    try
                    {
                        string query = "DELETE FROM nota WHERE id_nota = @id_nota";
                        MySqlConnection conn = con.Conectar();
                        MySqlCommand cmd = new MySqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@id_nota", lbIdNota.Text);
                        int n = cmd.ExecuteNonQuery();

                        if (n > 0)
                        {
                            MessageBox.Show("NOTA BORRADA");
                            InsertaEnHistorial(1);
                            ActualizaFchIncidencia();
                        }
                            
                        else
                            MessageBox.Show("NOTA NO BORRADA");

                        cmd.Dispose();
                        conn.Close();
                        Response.Redirect("DetalleIncidencia.aspx?id="+lb_id_incidencia.Text.Substring(12));
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

        protected void EditarNota(object sender, EventArgs e)
        {
            try
            {
                string query = "UPDATE nota SET dsc_nota = @dsc_nota WHERE id_nota = @id_nota";
                MySqlConnection conn = con.Conectar();
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@dsc_nota", tbDescripcion.Text);
                cmd.Parameters.AddWithValue("@id_nota", lbIdNota.Text);
                int n = cmd.ExecuteNonQuery();

                if (n > 0)
                {
                    MessageBox.Show("Nota editada.");
                    InsertaEnHistorial(0);
                    ActualizaFchIncidencia();
                }
                else
                    MessageBox.Show("Error al actualizar.");

                cmd.Dispose();
                conn.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        protected void Volver(object sender, EventArgs e)
        {
            Response.Redirect("DetalleIncidencia.aspx?id="+lb_id_incidencia.Text.Substring(12));
        }

        private void InsertaEnHistorial(int opcion)
        {
            string campo = "";
            string cambio = "";

            switch (opcion)
            {
                case 0:
                    campo = "Nota (" + lbIdNota.Text + ") editada";
                    break;
                case 1:
                    campo = "Nota (" + lbIdNota.Text + ") eliminada";
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
            cmd.Parameters.AddWithValue("@id_incidencia", lb_id_incidencia.Text.Substring(12));
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();
        }

        protected void ActualizaFchIncidencia()
        {
            string query = "UPDATE incidencia SET fch_actualizacion = @fch_actualizacion WHERE id_incidencia = @id_incidencia";
            MySqlConnection conn = con.Conectar();
            MySqlCommand cmd = new MySqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@fch_actualizacion", DateTime.Now);
            cmd.Parameters.AddWithValue("@id_incidencia", lb_id_incidencia.Text.Substring(12));
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();
        }

        protected void SalirLogout(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

    }
}