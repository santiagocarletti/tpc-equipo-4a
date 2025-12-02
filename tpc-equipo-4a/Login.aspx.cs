using negocio;
using dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tpc_equipo_4a
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Usuario"] != null)
            {
                var user = (dominio.Usuario)Session["Usuario"];
                Response.Redirect(user.Rol.PaginaInicio, false);
            }
        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string user = txtUsuario.Text.Trim();
            string pass = txtPassword.Text.Trim();

            UsuarioNegocio negocio = new UsuarioNegocio();
            dominio.Usuario usuario = negocio.Login(user, pass);

            if (usuario == null)
            {
                lblError.Visible = true;
                lblError.Text = "Usuario o contraseña incorrectos, o usuario inactivo.";
                return;
            }

            Session["Usuario"] = usuario;
            Response.Redirect(usuario.Rol.PaginaInicio, false);
        }
    }
}
