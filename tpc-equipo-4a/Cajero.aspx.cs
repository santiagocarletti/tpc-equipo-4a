using negocio;
using System;
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
            ComboNegocio negocio = new ComboNegocio();
            ComboDetalleNegocio detalleNegocio = new ComboDetalleNegocio();
            ListaCombos = negocio.listar();

            if (!IsPostBack)
            {
                //foreach (var combo in ListaCombos)
                //{
                //    combo.Detalles = detalleNegocio.DetallesPorCombo(combo.Id);
                //}

                Session.Add("listaCombos", ListaCombos);
                repCombosCaja.DataSource = Session["listaCombos"];
                repCombosCaja.DataBind();
            }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int idCombo = int.Parse(btn.CommandArgument);
        }
    }
}