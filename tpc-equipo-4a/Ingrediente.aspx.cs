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
    public partial class Ingrediente : System.Web.UI.Page
    {
        public List<dominio.Ingrediente> ListaIngredientes { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            IngredienteNegocio negocio = new IngredienteNegocio();
            ListaIngredientes = negocio.listar();

            if (!IsPostBack)
            {
                Session.Add("listaIngredientes", ListaIngredientes);
                repIngredientes.DataSource = Session["listaIngredientes"];
                repIngredientes.DataBind();

                //SectorNegocio secNegocio = new SectorNegocio();
                //List<Sector> sectores = secNegocio.listar();

                //sectores = sectores.Skip(1).Take(sectores.Count - 2).ToList();
                //sectores.Insert(0, new Sector { Id = -1, Nombre = "Todos" });

                //repSectores.DataSource = sectores;
                //repSectores.DataBind();
            }
        }

        protected void btnNuevoIngrediente_Click(object sender, EventArgs e)
        {
            Session.Remove("IngredienteId");
            Response.Redirect("IngredienteEdicion.aspx");
        }

        protected void btnFiltrarSector_Click(object sender, EventArgs e)
        {

        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int idIngrediente = Convert.ToInt32(btn.CommandArgument);

            Session["IngredienteId"] = idIngrediente;

            Response.Redirect("IngredienteEdicion.aspx");
        }

        protected void btnCambiarEstadoIngrediente_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int idIngrediente = Convert.ToInt32(btn.CommandArgument);

            IngredienteNegocio negocio = new IngredienteNegocio();
            negocio.cambiarEstadoIngrediente(idIngrediente);

            repIngredientes.DataSource = negocio.listar();
            repIngredientes.DataBind();
        }
    }
}