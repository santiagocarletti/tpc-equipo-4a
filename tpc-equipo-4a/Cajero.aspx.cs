using negocio;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tpc_equipo_4a
{
    public partial class Cajero : System.Web.UI.Page
    {
        public List<dominio.Combo> ListaCombos { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                ComboNegocio negocio = new ComboNegocio();
                //ComboDetalleNegocio detalleNegocio = new ComboDetalleNegocio();
                ListaCombos = negocio.listar();
                //foreach (var combo in ListaCombos)
                //{
                //    combo.Detalles = detalleNegocio.DetallesPorCombo(combo.Id);
                //}

                Session.Add("listaCombos", ListaCombos);
                repCombosCaja.DataSource = Session["listaCombos"];
                repCombosCaja.DataBind();

                Session["listaCombos"] = ListaCombos;
            }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int idCombo = int.Parse(btn.CommandArgument);
        }

        protected void btnCatCombos_Click(object sender, EventArgs e)
        {
            panelCombos.Visible = true;
            repCombosCaja.DataSource = Session["listaCombos"];
            repCombosCaja.DataBind();
        }

        protected void btnCatHamburguesas_Click(object sender, EventArgs e)
        {
            panelCombos.Visible = false;
        }

        protected void btnCatBebidas_Click(object sender, EventArgs e)
        {
            panelCombos.Visible = false;
        }

        protected void btnCatPapas_Click(object sender, EventArgs e)
        {
            panelCombos.Visible = false;
        }
    }
}