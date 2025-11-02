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
                if (Session["ProductoId"] != null)
                {
                    ProductoNegocio negocio = new ProductoNegocio();
                    int id = (int)Session["ProductoId"];
                    dominio.Producto prod = negocio.obtenerPorId(id);

                    txtNombre.Text = prod.Nombre;
                    txtMinutos.Text = prod.MinutosPreparacion.ToString();

                    SectorNegocio secNegocio = new SectorNegocio();
                    List<Sector> sectores = secNegocio.listar();
                    ddlSector.DataSource = sectores;
                    ddlSector.DataTextField = "Nombre";
                    ddlSector.DataValueField = "Id";
                    ddlSector.DataBind();

                    ddlSector.SelectedValue = prod.Sector.Id.ToString();
                }
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            Session.Remove("ProductoId");
            Response.Redirect("Producto.aspx");
        }
    }
}