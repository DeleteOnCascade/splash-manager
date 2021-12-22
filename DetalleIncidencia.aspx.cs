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
                this.getIncidencia();
            }
        }

        private void getIncidencia()
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


            command = new MySqlCommand("select * from nota where id_incidencia = @incidencia", conc);
            command.Parameters.AddWithValue("@incidencia", lb_IdIncidencia.Text);
            command.ExecuteNonQuery();
            dt = new DataTable();
            da = new MySqlDataAdapter(command);
            da.Fill(dt);
            ListView1.DataSource = dt;
            ListView1.DataBind();


            command.Dispose();
            conc.Close();
        }

        protected void btAgregar_Click(object sender, EventArgs e)
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

            if (n>0)
            {
                Response.Redirect("DetalleIncidencia.aspx?id="+lb_IdIncidencia.Text);
                cmd.Dispose();
                conn.Close();
            }
        }
    }
}