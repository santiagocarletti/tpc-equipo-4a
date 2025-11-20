using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;
using negocio;

namespace tpc_equipo_4a
{
    public partial class ProductoEdicion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SectorNegocio secNegocio = new SectorNegocio();
                List<Sector> sectores = secNegocio.listar();

                sectores.Insert(0, new Sector { Id = -1, Nombre = ""});

                ddlSector.DataSource = sectores;
                ddlSector.DataTextField = "Nombre";
                ddlSector.DataValueField = "Id";
                ddlSector.DataBind();

                if (Session["ProductoId"] != null)
                {
                    ProductoNegocio negocio = new ProductoNegocio();
                    int id = (int)Session["ProductoId"];
                    dominio.Producto prod = negocio.obtenerPorId(id);

                    txtNombre.Text = prod.Nombre;
                    txtMinutos.Text = prod.MinutosPreparacion.ToString();

                    ddlSector.SelectedValue = prod.Sector.Id.ToString();

                    ProductoIngredienteNegocio ingNegocio = new ProductoIngredienteNegocio();

                    //CARGAR REPEATER
                    List<ProductoIngrediente> ingredientes = ingNegocio.ListarTodosParaProducto(id);
                    repIngredientes.DataSource = ingredientes;
                    repIngredientes.DataBind();
                    //
                }
            }
        }
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            ProductoNegocio negocio = new ProductoNegocio();
            dominio.Producto prod = new dominio.Producto();

            //MODIFICACION
            if (Session["ProductoId"] != null)
                prod.Id = (int)Session["ProductoId"];

            prod.Nombre = txtNombre.Text;
            prod.MinutosPreparacion = int.Parse(txtMinutos.Text);
            prod.Sector = new dominio.Sector();
            prod.Sector.Id = int.Parse(ddlSector.SelectedValue);

            negocio.guardar(prod);

            Session.Remove("ProductoId");
            Response.Redirect("Producto.aspx");
        }
    }
}