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
    public partial class Usuario : System.Web.UI.Page
    {
        public List<dominio.Usuario> ListaUsuarios { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UsuarioNegocio negocio = new UsuarioNegocio();

                ListaUsuarios = negocio.listar();
                Session.Add("listaUsuarios", ListaUsuarios);

                repUsuarios.DataSource = Session["listaUsuarios"];
                repUsuarios.DataBind();
            }
        }
        protected void txtBuscar_TextChanged(object sender, EventArgs e)
        {
            List<dominio.Usuario> lista = (List<dominio.Usuario>)Session["listaUsuarios"];
            List<dominio.Usuario> listaFiltrada = lista.FindAll(x => x.NombreUsuario.ToUpper().Contains(txtBuscar.Text.ToUpper()));

            repUsuarios.DataSource = listaFiltrada;
            repUsuarios.DataBind();

        }
        protected void btnCambiarEstadoUsuario_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int idUsuario = Convert.ToInt32(btn.CommandArgument);

            UsuarioNegocio negocio = new UsuarioNegocio();
            negocio.cambiarEstadoUsuario(idUsuario);

            repUsuarios.DataSource = negocio.listar();
            repUsuarios.DataBind();
        }
        protected void btnEditar_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int idUsuario = Convert.ToInt32(btn.CommandArgument);

            Session["UsuarioId"] = idUsuario;

            Response.Redirect("UsuarioEdicion.aspx");
        }
        protected void btnNuevoUsuario_Click(object sender, EventArgs e)
        {
            Session.Remove("UsuarioId");
            Response.Redirect("UsuarioEdicion.aspx");
        }
    }
}