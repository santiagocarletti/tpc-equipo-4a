using dominio;
using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tpc_equipo_4a
{
    public partial class IngredienteEdicion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SectorNegocio secNegocio = new SectorNegocio();
                List<Sector> sectores = secNegocio.listar();

                sectores.Insert(0, new Sector { Id = -1, Nombre = "" });

                ddlSector.DataSource = sectores;
                ddlSector.DataTextField = "Nombre";
                ddlSector.DataValueField = "Id";
                ddlSector.DataBind();

                if (Session["IngredienteId"] != null)
                {
                    IngredienteNegocio negocio = new IngredienteNegocio();
                    int id = (int)Session["IngredienteId"];
                    dominio.Ingrediente ing = negocio.obtenerPorId(id);

                    txtNombre.Text = ing.Nombre.ToString();
                    txtMinutos.Text = ing.MinutosPreparacion.ToString();

                    ddlSector.SelectedValue = ing.IdSector.ToString();
                }
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            IngredienteNegocio negocio = new IngredienteNegocio();
            dominio.Ingrediente ing = new dominio.Ingrediente();

            //MODIFICACION
            if (Session["IngredienteId"] != null)
                ing.Id = (int)Session["IngredienteId"];

            ing.Nombre = txtNombre.Text;
            ing.MinutosPreparacion = int.Parse(txtMinutos.Text);

            ing.IdSector = int.Parse(ddlSector.SelectedValue);

            negocio.guardar(ing);

            Session.Remove("IngredienteId");
            Response.Redirect("Ingrediente.aspx");
        }
    }
}