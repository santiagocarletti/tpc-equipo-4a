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
            UsuarioNegocio negocio = new UsuarioNegocio();
            ListaUsuarios = negocio.listar();
            if (!IsPostBack)
            {
                Session.Add("listaUsuarios", ListaUsuarios);
                repUsuarios.DataSource = Session["listaUsuarios"];
                repUsuarios.DataBind();

                var filtros = new List<dynamic>
                {
                    new { Id = -1, Nombre = "Todos" },
                    new { Id = 1, Nombre = "Activos" },
                    new { Id = 0, Nombre = "Inactivos" }
                };

                repSectores.DataSource = filtros;
                repSectores.DataBind();
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
        protected void btnFiltrarSector_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int idFiltro = Convert.ToInt32(btn.CommandArgument);
            
            List<dominio.Usuario> filtrada;

            if (idFiltro == -1)
                filtrada = ListaUsuarios;
            else
                filtrada = ListaUsuarios.Where(u => u.Activo == (idFiltro == 1)).ToList();

            repUsuarios.DataSource = filtrada;
            repUsuarios.DataBind();
        }
    }
}