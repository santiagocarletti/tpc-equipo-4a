using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using dominio;
using negocio;

namespace tpc_equipo_4a
{
    public partial class Plancha : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Usuario"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                try
                {
                    CargarUsuario();
                    CargarIngredientes();
                    CargarPedidos();
                }
                catch (Exception ex)
                {
                    MostrarMensaje("Error al cargar la página: " + ex.Message, false);
                }
            }
        }

        private void CargarUsuario()
        {
            try
            {
                dominio.Usuario usuario = Session["Usuario"] as dominio.Usuario;

                lblNombreUsuario.Text = usuario != null ? usuario.NombreUsuario : "Usuario";
            }
            catch
            {
                lblNombreUsuario.Text = "Usuario";
            }
        }

        private void CargarIngredientes()
        {
            try
            {
                IngredienteNegocio negocio = new IngredienteNegocio();
                List<dominio.Ingrediente> ingredientes = negocio.listar();

                ingredientes = ingredientes.FindAll(i => i.Activo);

                ddlIngredientes.DataSource = ingredientes;
                ddlIngredientes.DataTextField = "Nombre";
                ddlIngredientes.DataValueField = "Id";
                ddlIngredientes.DataBind();

                ddlIngredientes.Items.Insert(0, new ListItem("-- Seleccione Ingrediente --", "-1"));
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al cargar ingredientes: " + ex.Message, false);
            }
        }
        private void CargarPedidos()
        {
            try
            {
                PlanchaNegocio negocio = new PlanchaNegocio();
                var lista = negocio.ListarPedidosPlancha();

                repPedidos.DataSource = lista;
                repPedidos.DataBind();
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al cargar pedidos: " + ex.Message, false);
            }
        }

        protected void btnPedidoListo_Click(object sender, EventArgs e)
        {
            int idComanda = int.Parse(((Button)sender).CommandArgument);

            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.limpiarParametros();
                datos.setearConsulta("UPDATE Comandas SET IdEstadoComanda = 4 WHERE Id = @id");
                datos.setearParametro("@id", idComanda);
                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }

            CargarPedidos();
        }

        protected void btnReportar_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlIngredientes.SelectedValue == "-1")
                {
                    MostrarMensaje("Debe seleccionar un ingrediente.", false);
                    return;
                }

                int idIng = int.Parse(ddlIngredientes.SelectedValue);
                string nombreIng = ddlIngredientes.SelectedItem.Text;
                string usuario = ((dominio.Usuario)Session["Usuario"]).NombreUsuario;

                ReporteIngrediente reporte = new ReporteIngrediente
                {
                    IdIngrediente = idIng,
                    NombreIngrediente = nombreIng,
                    SectorOrigen = "Plancha",
                    UsuarioReporta = usuario,
                    FechaHoraReporte = DateTime.Now,
                    Estado = "Pendiente"
                };

                List<ReporteIngrediente> lista;

                if (Application["ReportesIngredientes"] == null)
                    lista = new List<ReporteIngrediente>();
                else
                    lista = (List<ReporteIngrediente>)Application["ReportesIngredientes"];

                lista.Add(reporte);
                Application["ReportesIngredientes"] = lista;

                MostrarMensaje($"Ingrediente '{nombreIng}' reportado exitosamente.", true);
                ddlIngredientes.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al reportar ingrediente: " + ex.Message, false);
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

        private void MostrarMensaje(string mensaje, bool exito)
        {
            divMensaje.Visible = true;
            spanMensaje.InnerText = mensaje;

            divMensaje.Attributes["class"] = exito ?
                "alert alert-success" :
                "alert alert-danger";
        }
    }
}
