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

                //Grupos de producto
                GrupoProductoNegocio grupoNeg = new GrupoProductoNegocio();
                List<GrupoProducto> grupos = grupoNeg.listar();
                grupos.Insert(0, new GrupoProducto { Id = -1, Nombre = "" });

                ddlGrupo.DataSource = grupos;
                ddlGrupo.DataTextField = "Nombre";
                ddlGrupo.DataValueField = "Id";
                ddlGrupo.DataBind();

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

                    //Preseleccionar grupo
                    ddlGrupo.SelectedValue = prod.IdGrupo.ToString();
                }
            }
        }
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            ProductoNegocio prodNeg = new ProductoNegocio();
            ProductoIngredienteNegocio pinNeg = new ProductoIngredienteNegocio();

            int idProducto = Session["ProductoId"] != null
                ? (int)Session["ProductoId"]
                : 0;   //Producto nuevo

            //Datos base del Producto
            dominio.Producto p = new dominio.Producto
            {
                Id = idProducto,
                Nombre = txtNombre.Text.Trim(),
                MinutosPreparacion = int.TryParse(txtMinutos.Text, out var m) ? m : 0,
                Sector = new Sector { Id = int.TryParse(ddlSector.SelectedValue, out var s) ? s : -1 },
                IdGrupo = int.Parse(ddlGrupo.SelectedValue),
                //Activo = true
            };
            //Si es nuevo, guarda y obtengo Id
            idProducto = prodNeg.guardar(p);

            foreach (RepeaterItem item in repIngredientes.Items)
            {
                HiddenField hfProdIngId = (HiddenField)item.FindControl("hfIdProductoIngrediente");
                HiddenField hfIngredId = (HiddenField)item.FindControl("hfIdIngrediente");
                CheckBox chkOpcional = (CheckBox)item.FindControl("chkOpcional");
                TextBox txtCantidad = (TextBox)item.FindControl("txtCantidad");

                int idProdIng = int.TryParse(hfProdIngId?.Value, out var x) ? x : 0;
                int idIngred = int.TryParse(hfIngredId?.Value, out var y) ? y : 0;
                int cantidad = int.TryParse(txtCantidad?.Text, out var z) ? z : 0;
                bool esOpcional = chkOpcional != null && chkOpcional.Checked;

                if (cantidad > 0)
                {
                    if (idProdIng == 0)
                    {
                        //AGREGAR
                        pinNeg.Agregar(new ProductoIngrediente
                        {
                            IdProducto = idProducto,
                            IdIngrediente = idIngred,
                            Cantidad = cantidad,
                            EsOpcional = esOpcional
                        });
                    }
                    else
                    {
                        //MODFICAR
                        pinNeg.Modificar(new ProductoIngrediente
                        {
                            Id = idProdIng,
                            IdProducto = idProducto,
                            IdIngrediente = idIngred,
                            Cantidad = cantidad,
                            EsOpcional = esOpcional
                        });
                    }
                }
                else
                //Cantidad = 0
                {
                    if (idProdIng > 0)
                    {
                        //ELIMINAR
                        pinNeg.Eliminar(idProdIng);
                    }
                }
            }

            Session.Remove("ProductoId");
            Response.Redirect("Producto.aspx");
        }
    }
}