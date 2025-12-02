using System;
using System.Collections.Generic;
using System.Linq;
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
                try
                {
                    CargarDropdowns();
                    CargarIngredientes();

                    // Si es edición, cargar datos del producto
                    if (Session["ProductoId"] != null)
                    {
                        lblTitulo.Text = "Editar Producto";

                        ProductoNegocio negocio = new ProductoNegocio();
                        int id = (int)Session["ProductoId"];
                        dominio.Producto prod = negocio.obtenerPorId(id);

                        if (prod != null)
                        {
                            txtNombre.Text = prod.Nombre;
                            txtMinutos.Text = prod.MinutosPreparacion.ToString();
                            ddlSector.SelectedValue = prod.Sector.Id.ToString();
                            ddlGrupo.SelectedValue = prod.IdGrupo.ToString();
                        }
                    }
                    else
                    {
                        lblTitulo.Text = "Nuevo Producto";
                    }
                }
                catch (Exception ex)
                {
                    MostrarError("Error al cargar la página: " + ex.Message);
                }
            }
        }
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                Validaciones.ValidarTexto(txtNombre, "Nombre del producto");
                Validaciones.ValidarNombre(txtNombre.Text.Trim());
                Validaciones.ValidarDropDown(ddlSector, "Sector");
                Validaciones.ValidarDropDown(ddlGrupo, "Grupo");
                int minutosPreparacion = Validaciones.ValidarMinutosPreparacion(txtMinutos);

                List<int> cantidades = new List<int>();
                foreach (RepeaterItem item in repIngredientes.Items)
                {
                    TextBox txtCant = (TextBox)item.FindControl("txtCantidad");
                    if (txtCant != null)
                    {
                        Validaciones.ValidarCantidad(txtCant.Text, "Cantidad");

                        int cant = 0;
                        int.TryParse(txtCant.Text, out cant);
                        cantidades.Add(cant);
                    }
                }

                foreach (RepeaterItem item in repIngredientes.Items)
                {
                    TextBox txtCant = (TextBox)item.FindControl("txtCantidad");
                    if (txtCant != null && !string.IsNullOrWhiteSpace(txtCant.Text))
                    {
                        Validaciones.ValidarCantidad(txtCant.Text, "Cantidad");
                    }
                }

                ProductoNegocio prodNeg = new ProductoNegocio();
                List<dominio.Producto> productos = prodNeg.listar();

                int? idActual = null;
                if (Session["ProductoId"] != null)
                    idActual = (int)Session["ProductoId"];

                List<string> nombresExistentes = productos
                    .Where(p => !idActual.HasValue || p.Id != idActual.Value)
                    .Select(p => p.Nombre)
                    .ToList();

                Validaciones.ValidarNombreUnico(
                    txtNombre.Text.Trim(),
                    nombresExistentes,
                    idActual,
                    "producto"
                );


                ProductoIngredienteNegocio pinNeg = new ProductoIngredienteNegocio();
                int idProducto = idActual ?? 0;
                //Si es nuevo = 0

                dominio.Producto producto = new dominio.Producto
                {
                    Id = idProducto,
                    Nombre = txtNombre.Text.Trim(),
                    MinutosPreparacion = minutosPreparacion,
                    Sector = new Sector { Id = int.Parse(ddlSector.SelectedValue) },
                    IdGrupo = int.Parse(ddlGrupo.SelectedValue),
                    Activo = true
                };

                idProducto = prodNeg.guardar(producto);

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
                    
                    {
                        if (idProdIng > 0)
                        {
                            pinNeg.Eliminar(idProdIng);
                        }
                    }
                }

                Session.Remove("ProductoId");
                Response.Redirect("Producto.aspx");
            }
            catch (Exception ex)
            {
                MostrarError(ex.Message);
            }
        }
        private void CargarDropdowns()
        {
            try
            {                
                SectorNegocio secNegocio = new SectorNegocio();
                List<Sector> sectores = secNegocio.listar();

                ddlSector.DataSource = sectores;
                ddlSector.DataTextField = "Nombre";
                ddlSector.DataValueField = "Id";
                ddlSector.DataBind();
                ddlSector.Items.Insert(0, new ListItem("-- Seleccione Sector --", "-1"));
                
                GrupoProductoNegocio grupoNeg = new GrupoProductoNegocio();
                List<GrupoProducto> grupos = grupoNeg.listar();

                ddlGrupo.DataSource = grupos;
                ddlGrupo.DataTextField = "Nombre";
                ddlGrupo.DataValueField = "Id";
                ddlGrupo.DataBind();
                ddlGrupo.Items.Insert(0, new ListItem("-- Seleccione Grupo --", "-1"));
            }
            catch (Exception ex)
            {
                MostrarError("Error al cargar dropdowns: " + ex.Message);
            }
        }
        private void CargarIngredientes()
        {
            try
            {
                ProductoIngredienteNegocio ingNegocio = new ProductoIngredienteNegocio();
                int idProducto = Session["ProductoId"] != null ? (int)Session["ProductoId"] : 0;

                List<ProductoIngrediente> ingredientes = ingNegocio.ListarTodosParaProducto(idProducto);
                repIngredientes.DataSource = ingredientes;
                repIngredientes.DataBind();
            }
            catch (Exception ex)
            {
                MostrarError("Error al cargar ingredientes: " + ex.Message);
            }
        }
        private void MostrarError(string mensaje)
        {
            errorText.InnerText = mensaje;
            errorMsg.Visible = true;
        }
    }
}