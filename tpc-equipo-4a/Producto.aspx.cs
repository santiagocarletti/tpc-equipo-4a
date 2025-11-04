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
    public partial class Producto : System.Web.UI.Page
    {
        public List<dominio.Producto> ListaProductos { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            ProductoNegocio negocio = new ProductoNegocio();
            ListaProductos = negocio.listar();

            if (!IsPostBack)
            {
                repProductos.DataSource = ListaProductos;
                repProductos.DataBind();

                SectorNegocio secNegocio = new SectorNegocio();
                List<Sector> sectores = secNegocio.listar();
                sectores = sectores.Skip(1).Take(sectores.Count - 2).ToList();
                sectores.Insert(0, new Sector { Id = -1, Nombre = "Todos" });

                repSectores.DataSource = sectores;
                repSectores.DataBind();
            }
        }

        protected void btnCambiarEstadoProducto_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int idProducto = Convert.ToInt32(btn.CommandArgument);

            ProductoNegocio negocio = new ProductoNegocio();
            negocio.cambiarEstadoProducto(idProducto);

            repProductos.DataSource = negocio.listar();
            repProductos.DataBind();
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int idProducto = Convert.ToInt32(btn.CommandArgument);

            Session["ProductoId"] = idProducto;

            Response.Redirect("ProductoEdicion.aspx");
        }

        protected void btnNuevoProducto_Click(object sender, EventArgs e)
        {
            Session.Remove("ProductoId");
            Response.Redirect("ProductoEdicion.aspx");
        }
        protected void btnFiltrarSector_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int idSector = Convert.ToInt32(btn.CommandArgument);

            ProductoNegocio negocio = new ProductoNegocio();
            repProductos.DataSource = negocio.listar(idSector);
            repProductos.DataBind();
        }
    }
}