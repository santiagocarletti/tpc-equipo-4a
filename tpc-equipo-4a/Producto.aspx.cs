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
    }
}