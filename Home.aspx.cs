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

namespace ProyectoFinalDAM
{
    public partial class Home : System.Web.UI.Page
    {
        Conexion con = new Conexion();
        MySqlCommand command;
        MySqlDataAdapter da;
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"]==null)
                Response.Redirect("Login.aspx");
            if((int)Session["rol"] == 2)
                Response.Redirect("UsuarioIncidencia.aspx");

            lbUsername.Text = "Usuario: " + Session["username"];

            if (!this.IsPostBack)
            {
                this.getListView();
                this.CargarUsuarios();
                this.CargarNumIncidencias();
            }
        }

        private void getListView()
        {
            MySqlConnection conc = con.Conectar();
            command = new MySqlCommand("SELECT id_incidencia, categoria, prioridad, estado, responsable, fch_actualizacion, motivo  FROM incidencia " +
                "WHERE estado != 'cerrada' ORDER BY fch_actualizacion DESC LIMIT 20", conc);
            command.ExecuteNonQuery();
            dt = new DataTable();
            da = new MySqlDataAdapter(command);
            da.Fill(dt);
            ListView1.DataSource = dt;
            ListView1.DataBind();
            command.Dispose();
            conc.Close();
        }

        protected void CargarUsuarios()
        {
            MySqlConnection conc = con.Conectar();
            command = new MySqlCommand("SELECT username FROM usuario WHERE rol = '1'", conc);
            dropListAsignar.DataSource = command.ExecuteReader();
            dropListAsignar.DataValueField = "username";
            dropListAsignar.DataBind();
            command.Dispose();
            conc.Close();
        }

        protected void FiltrarIncidencias(object sender, EventArgs e)
        {
            MySqlConnection conc = con.Conectar();

            string query = ConstruirQueryFiltro();

            string estado = dropListEstado.SelectedItem.ToString();
            string responsable = dropListAsignar.SelectedItem.ToString();
            string prioridad = dropListPrioridad.SelectedItem.ToString();
            string categoria = dropListCategoria.SelectedItem.ToString();

            command = new MySqlCommand(query, conc);
            command.Parameters.AddWithValue("@estado", estado);
            command.Parameters.AddWithValue("@responsable", responsable);
            command.Parameters.AddWithValue("@prioridad", prioridad);
            command.Parameters.AddWithValue("@categoria", categoria);
            command.ExecuteNonQuery();

            dt = new DataTable();
            da = new MySqlDataAdapter(command);
            da.Fill(dt);
            ListView1.DataSource = dt;
            ListView1.DataBind();
            command.Dispose();
            conc.Close();
        }

        protected string ConstruirQueryFiltro()
        {
            string query = "SELECT id_incidencia, categoria, prioridad, estado, responsable, fch_actualizacion, motivo  FROM incidencia WHERE";

            if (!dropListEstado.SelectedItem.ToString().Equals("cualquiera"))
                query += " estado = @estado";
            else
                query += " estado != @estado";

            if (!dropListAsignar.SelectedItem.ToString().Equals("cualquiera"))
                query += " AND responsable = @responsable";
            else
                query += " AND responsable != @responsable";

            if (!dropListPrioridad.SelectedItem.ToString().Equals("cualquiera"))
                query += " AND prioridad = @prioridad";
            else
                query += " AND prioridad != @prioridad";

            if (!dropListCategoria.SelectedItem.ToString().Equals("cualquiera"))
                query += " AND categoria = @categoria";
            else
                query += " AND categoria != @categoria";

            query += " ORDER BY fch_actualizacion DESC";

            return query;
        }

        protected void ReiniciarFiltro(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }

        protected void CargarNumIncidencias()
        {
            MySqlConnection conc = con.Conectar();
            command = new MySqlCommand("SELECT COUNT(*) As Count FROM incidencia", conc);
            object o = command.ExecuteScalar();
            lbNumIncidencias.Text = "(1 - 20 / " + o.ToString() + ")";
            command.Dispose();
            conc.Close();
        }

        protected void VerPrimera(object sender, EventArgs e)
        {

        }

        protected void VerAnterior(object sender, EventArgs e)
        {

        }

        protected void VerSiguiente(object sender, EventArgs e)
        {

        }

        protected void VerUltima(object sender, EventArgs e)
        {

        }

        protected void Salir(object sender, EventArgs e)
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