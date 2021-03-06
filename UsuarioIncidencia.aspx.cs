using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProyectoFinalDAM
{
    public partial class MisIncidencias : System.Web.UI.Page
    {
        Conexion con = new Conexion();
        MySqlCommand command;
        MySqlDataAdapter da;
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"]==null)
                Response.Redirect("./Login.aspx");
            lbUsername.Text = "Usuario: " + Session["username"];

            if (!this.IsPostBack)
            {
                this.getListView();
            }
        }

        private void getListView()
        {
            MySqlConnection conc = con.Conectar();
            command = new MySqlCommand("SELECT id_incidencia, categoria, prioridad, estado, responsable, fch_actualizacion, motivo  FROM incidencia " +
                "WHERE informador = @informador ORDER BY fch_actualizacion DESC", conc);
            command.Parameters.AddWithValue("@informador", Session["username"]);
            command.ExecuteNonQuery();
            dt = new DataTable();
            da = new MySqlDataAdapter(command);
            da.Fill(dt);
            listViewIncidencias.DataSource = dt;
            listViewIncidencias.DataBind();
            command.Dispose();
            conc.Close();
        }

        protected void listIncidencias_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            (listViewIncidencias.FindControl("dataPagerIncidencias") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            this.getListView();
        }

        protected void Salir(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("./Login.aspx");
        }

        protected void BuscarIncidencia(object sender, EventArgs e)
        {
            if (!tbIncidencia.Text.Equals(String.Empty))
                Response.Redirect("./DetalleIncidencia.aspx?id=" + tbIncidencia.Text);
        }  
    }
}