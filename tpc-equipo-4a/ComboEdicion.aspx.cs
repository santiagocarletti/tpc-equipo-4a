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
                if (Session["ComboId"] != null)
                {
                    int id = (int)Session["ComboId"];
                    ComboNegocio negocio = new ComboNegocio();
                    dominio.Combo combo = negocio.obtenerPorId(id);

                    if (combo == null || combo.Id == 0)
                    {
                        Response.Redirect("Combo.aspx");
                        return;
                    }

                    txtNombre.Text = combo.Nombre;
                    txtDescripcion.Text = combo.Descripcion;
                }
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            ComboNegocio negocio = new ComboNegocio();
            dominio.Combo combo = new dominio.Combo();

            if (Session["ComboId"] != null)
                combo.Id = (int)Session["ComboId"];
            else
                combo.Id = 0;

            combo.Nombre = txtNombre.Text.Trim();
            combo.Descripcion = txtDescripcion.Text.Trim();

            negocio.guardar(combo);

            Session.Remove("ComboId");
            Response.Redirect("Combo.aspx");
        }

    }
}