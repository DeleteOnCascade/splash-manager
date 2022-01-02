using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using MySql.Data.MySqlClient;

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
            lbUsername.Text = "Usuario: " + Session["username"];

            if (!this.IsPostBack)
            {
                this.getListView();
            }
        }

        private void getListView()
        {
            MySqlConnection conc = con.Conectar();
            command = new MySqlCommand("select id_incidencia, categoria, prioridad, estado, responsable, fch_actualizacion, motivo  from incidencia", conc);
            command.ExecuteNonQuery();
            dt = new DataTable();
            da = new MySqlDataAdapter(command);
            da.Fill(dt);
            ListView1.DataSource = dt;
            ListView1.DataBind();
            command.Dispose();
            conc.Close();
        }

        protected void btLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

        protected void btBuscar_Click(object sender, EventArgs e)
        {
            Response.Redirect("DetalleIncidencia.aspx?id=" + tbIncidencia.Text);
        }
    }
}