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
    public partial class ComboEdicion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
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
                //
                //Asociación temporal para vistas
                foreach (var p in productos)
                    p.DetallesCombo = detalles;

                repProductosCombo.DataSource = productos;
                repProductosCombo.DataBind();
            }
        }
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            ComboNegocio comboNeg = new ComboNegocio();
            ComboDetalleNegocio detNegocio = new ComboDetalleNegocio();

            int idCombo;

            if (Session["ComboId"] == null)
            {
                dominio.Combo nuevoCombo = new dominio.Combo();
                nuevoCombo.Nombre = txtNombre.Text.Trim();
                nuevoCombo.Descripcion = txtDescripcion.Text.Trim();
                nuevoCombo.Activo = true;

                idCombo = comboNeg.AgregarYDevolverId(nuevoCombo);
                Session["ComboId"] = idCombo;
            }
            else
            {
                idCombo = (int)Session["ComboId"];

                dominio.Combo comboEditado = new dominio.Combo();
                comboEditado.Id = idCombo;
                comboEditado.Nombre = txtNombre.Text.Trim();
                comboEditado.Descripcion = txtDescripcion.Text.Trim();
                comboEditado.Activo = true;

                comboNeg.guardar(comboEditado);
            }

            foreach (RepeaterItem item in repProductosCombo.Items)
            {
                HiddenField hfIdProducto = (HiddenField)item.FindControl("hfIdProducto");
                HiddenField hfIdDetalle = (HiddenField)item.FindControl("hfIdDetalle");
                CheckBox chk = (CheckBox)item.FindControl("chkSeleccionado");
                TextBox txtCant = (TextBox)item.FindControl("txtCantidad");

                int idProducto = int.Parse(hfIdProducto.Value);
                int idDetalle = int.Parse(hfIdDetalle.Value);

                bool seleccionado = chk.Checked;
                int cantidad = 0;

                int.TryParse(txtCant.Text, out cantidad);

                if (seleccionado && idDetalle == 0)
                {
                    detNegocio.Agregar(new ComboDetalle
                    {
                        IdCombo = idCombo,
                        IdProducto = idProducto,
                        Cantidad = cantidad
                    });
                }
                else if (seleccionado && idDetalle > 0)
                {
                    detNegocio.Modificar(new ComboDetalle
                    {
                        Id = idDetalle,
                        IdCombo = idCombo,
                        IdProducto = idProducto,
                        Cantidad = cantidad
                    });
                }
                else if (!seleccionado && idDetalle > 0)
                {
                    detNegocio.Eliminar(idDetalle);
                }
            }

            Session.Remove("ComboId");
            Response.Redirect("Combo.aspx");
        }

    }
}