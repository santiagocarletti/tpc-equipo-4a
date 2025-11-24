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
            ComboNegocio negocio = new ComboNegocio();
            ComboDetalleNegocio detalleNegocio = new ComboDetalleNegocio();
            ListaCombos = negocio.listar();

            if (!IsPostBack)
            {
                foreach (var combo in ListaCombos)
                {
                    combo.Detalles = detalleNegocio.DetallesPorCombo(combo.Id);
                }

                Session.Add("listaCombos", ListaCombos);
                repCombos.DataSource = Session["listaCombos"];
                repCombos.DataBind();
            }
        }

        protected void txtBuscar_TextChanged(object sender, EventArgs e)
        {
            List<dominio.Combo> lista = (List<dominio.Combo>)Session["listaCombos"];
            List<dominio.Combo> listaFiltrada = lista.FindAll(x => (x.Nombre ?? string.Empty).ToUpper().Contains((txtBuscar.Text ?? "").ToUpper()));

            repCombos.DataSource = listaFiltrada;
            repCombos.DataBind();
        }

        protected void btnCambiarEstadoCombo_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int idCombo = Convert.ToInt32(btn.CommandArgument);

            ComboNegocio comboNeg = new ComboNegocio();
            ComboDetalleNegocio detNeg = new ComboDetalleNegocio();

            // Validaciones Productos inactivos
            bool tieneInactivos = detNeg.TieneProductosInactivos(idCombo);

            dominio.Combo comboActual = comboNeg.obtenerPorId(idCombo);

            if (tieneInactivos && !comboActual.Activo)
            {
                return;
            }
            comboNeg.cambiarEstadoCombo(idCombo);

            repCombos.DataSource = comboNeg.listar();
            repCombos.DataBind();
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int idCombo = Convert.ToInt32(btn.CommandArgument);

            Session["ComboId"] = idCombo;
            Response.Redirect("ComboEdicion.aspx");
        }

        protected void btnNuevoCombo_Click(object sender, EventArgs e)
        {
            Session.Remove("ComboId");
            Response.Redirect("ComboEdicion.aspx");
        }
        //BOTON Y FUNCIONALIDAD DESACTIVADOS HASTA COMPLETAR O ELIMINAR
        //protected void btnDuplicar_Click(object sender, EventArgs e)
        //{
        //    Button btn = (Button)sender;
        //    int idCombo = Convert.ToInt32(btn.CommandArgument);

        //    ComboNegocio negocio = new ComboNegocio();
        //    negocio.duplicarCombo(idCombo);

        //    repCombos.DataSource = negocio.listar();
        //    repCombos.DataBind();
        //}


    }
}