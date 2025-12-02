using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using dominio;
using negocio;

namespace tpc_equipo_4a
{
    public partial class ComboEdicion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    ProductoNegocio prodNegocio = new ProductoNegocio();
                    ComboDetalleNegocio detNegocio = new ComboDetalleNegocio();
                    ComboNegocio comboNeg = new ComboNegocio();

                    List<dominio.Producto> productos = prodNegocio.listar();
                    List<ComboDetalle> detalles = new List<ComboDetalle>();

                    if (Session["ComboId"] != null)
                    {
                        int idCombo = (int)Session["ComboId"];

                        dominio.Combo combo = comboNeg.obtenerPorId(idCombo);
                        txtNombre.Text = combo.Nombre;
                        txtDescripcion.Text = combo.Descripcion;

                        detalles = detNegocio.DetallesPorCombo(idCombo);
                    }

                    //Asociar detalles a cada producto
                    foreach (var p in productos)
                        p.DetallesCombo = detalles;

                    repProductosCombo.DataSource = productos;
                    repProductosCombo.DataBind();
                }
                catch (Exception ex)
                {
                    MostrarError(ex.Message);
                }
            }
        }
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                // Validaciones
                Validaciones.ValidarTexto(txtNombre, "Nombre del combo");
                Validaciones.ValidarNombre(txtNombre.Text.Trim());
                Validaciones.ValidarTextoOpcional(txtDescripcion);

                List<int> cantidades = new List<int>();
                foreach (RepeaterItem item in repProductosCombo.Items)
                {
                    TextBox txtCant = (TextBox)item.FindControl("txtCantidad");
                    Validaciones.ValidarCantidad(txtCant.Text, "Cantidad");

                    int cant = 0;
                    int.TryParse(txtCant.Text, out cant);
                    cantidades.Add(cant);
                }

                Validaciones.ValidarComboTieneProductos(cantidades);

                ComboNegocio comboNeg = new ComboNegocio();
                List<dominio.Combo> combos = comboNeg.listar();

                int? idActual = null;
                if (Session["ComboId"] != null)
                    idActual = (int)Session["ComboId"];

                // Filtrar nombres existentes excluyendo el actual (en caso de edición)
                List<string> nombresExistentes = combos
                    .Where(c => !idActual.HasValue || c.Id != idActual.Value)
                    .Select(c => c.Nombre)
                    .ToList();

                Validaciones.ValidarNombreUnico(
                    txtNombre.Text.Trim(),
                    nombresExistentes,
                    idActual,
                    "combo"
                );

                // Guardado de combo
                ComboDetalleNegocio detNegocio = new ComboDetalleNegocio();

                int idCombo;

                if (Session["ComboId"] == null)
                {
                    dominio.Combo nuevo = new dominio.Combo
                    {
                        Nombre = txtNombre.Text.Trim(),
                        Descripcion = txtDescripcion.Text.Trim(),
                        Activo = true
                    };

                    idCombo = comboNeg.AgregarYDevolverId(nuevo);
                    Session["ComboId"] = idCombo;
                }
                else
                {
                    idCombo = (int)Session["ComboId"];

                    dominio.Combo editado = new dominio.Combo
                    {
                        Id = idCombo,
                        Nombre = txtNombre.Text.Trim(),
                        Descripcion = txtDescripcion.Text.Trim(),
                        Activo = true
                    };

                    comboNeg.guardar(editado);
                }

                // Guardado de detalles
                foreach (RepeaterItem item in repProductosCombo.Items)
                {
                    HiddenField hfIdProducto = (HiddenField)item.FindControl("hfIdProducto");
                    HiddenField hfIdDetalle = (HiddenField)item.FindControl("hfIdDetalle");
                    TextBox txtCant = (TextBox)item.FindControl("txtCantidad");

                    int idProducto = int.Parse(hfIdProducto.Value);
                    int idDetalle = int.Parse(hfIdDetalle.Value);

                    int cantidad = 0;
                    int.TryParse(txtCant.Text, out cantidad);

                    if (cantidad > 0)
                    {
                        if (idDetalle == 0)
                        {
                            detNegocio.Agregar(new ComboDetalle
                            {
                                IdCombo = idCombo,
                                IdProducto = idProducto,
                                Cantidad = cantidad
                            });
                        }
                        else
                        {
                            detNegocio.Modificar(new ComboDetalle
                            {
                                Id = idDetalle,
                                IdCombo = idCombo,
                                IdProducto = idProducto,
                                Cantidad = cantidad
                            });
                        }
                    }
                    else if (idDetalle != 0)
                    {
                        detNegocio.Eliminar(idDetalle);
                    }
                }

                Session.Remove("ComboId");
                Response.Redirect("Combo.aspx");
            }
            catch (Exception ex)
            {
                MostrarError(ex.Message);
            }
        }

        private void MostrarError(string mensaje)
        {
            errorText.InnerText = mensaje;
            errorMsg.Visible = true;
        }
    }
}
