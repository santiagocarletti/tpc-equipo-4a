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
    }
}