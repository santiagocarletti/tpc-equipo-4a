using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;

namespace tpc_equipo_4a
{
    public partial class Combo : System.Web.UI.Page
    {
        public List<dominio.Combo> ListaCombos { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ComboNegocio negocio = new ComboNegocio();
                ListaCombos = negocio.listar();

                repCombos.DataSource = ListaCombos;
                repCombos.DataBind();
            }
        }

        protected void btnCambiarEstadoCombo_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int idCombo = Convert.ToInt32(btn.CommandArgument);

            ComboNegocio negocio = new ComboNegocio();
            negocio.cambiarEstadoCombo(idCombo);

            repCombos.DataSource = negocio.listar();
            repCombos.DataBind();
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int idCombo = Convert.ToInt32(btn.CommandArgument);

            Session["ComboId"] = idCombo;
            Response.Redirect("ComboEdicion.aspx");
        }

        protected void btnNuevoCombo_Click(object sender, EventArgs e)
        {
            Session.Remove("ComboId");
            Response.Redirect("ComboEdicion.aspx");
        }

        protected void btnDuplicar_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int idCombo = Convert.ToInt32(btn.CommandArgument);

            ComboNegocio negocio = new ComboNegocio();
            negocio.duplicarCombo(idCombo);

            repCombos.DataSource = negocio.listar();
            repCombos.DataBind();
        }


    }
}