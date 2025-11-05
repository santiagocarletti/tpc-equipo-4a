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

                repUsuarios.DataSource = ListaUsuarios;
                repUsuarios.DataBind();
            }
        }

        protected void btnCambiarEstadoUsuario_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int idUsuario = Convert.ToInt32(btn.CommandArgument);

            UsuarioNegocio negocio = new UsuarioNegocio();
            negocio.cambiarEstadoUsuario(idUsuario);

            repUsuarios.DataSource = negocio.listar();
            repUsuarios.DataBind();
        }
                
    }
}