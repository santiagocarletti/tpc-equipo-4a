using dominio;
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
            var user = (dominio.Usuario)Session["Usuario"];
            Seguridad.ValidarAcceso(user, this);

            if (!IsPostBack)
            {
                ComboNegocio negocio = new ComboNegocio();
                ListaCombos = negocio.listar();
                ListaCombos = ListaCombos.Where(x => x.Activo).ToList();

                Session.Add("listaCombos", ListaCombos);
                repCombosCaja.DataSource = Session["listaCombos"];
                repCombosCaja.DataBind();

                Session["listaCombos"] = ListaCombos;

                //BOTONES SECTORES
                SectorNegocio sectorNeg = new SectorNegocio();
                List<Sector> sectores = sectorNeg.listar();

                repSectores.DataSource = sectores;
                repSectores.DataBind();
                //
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
            panelProductosSectores.Visible = false;
        }
        public List<dominio.Producto> ListaProductos { get; set; }
        protected void btnSector_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int idSector = int.Parse(btn.CommandArgument);

            panelCombos.Visible = false;
            panelProductosSectores.Visible = true;

            ProductoNegocio negocio = new ProductoNegocio();
            repProductosCaja.DataSource = negocio.listar(idSector);
            repProductosCaja.DataBind();
        }
    }
}