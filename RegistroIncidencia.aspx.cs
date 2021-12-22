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

        protected void btEnviar_Click(object sender, EventArgs e)
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

                if (n>0)
                {
                    Response.Redirect("Home.aspx");
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
    }
}