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
    public partial class UsuarioEdicion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                RolUsuarioNegocio rolNegocio = new RolUsuarioNegocio();
                List<RolUsuario> roles = rolNegocio.listar();

                roles.Insert(0, new RolUsuario { Id = -1, Descripcion = "" });

                ddlRol.DataSource = roles;
                ddlRol.DataTextField = "Descripcion";
                ddlRol.DataValueField = "Id";
                ddlRol.DataBind();

                if (Session["UsuarioId"] != null)
                {
                    UsuarioNegocio negocio = new UsuarioNegocio();
                    int id = (int)Session["UsuarioId"];
                    dominio.Usuario usuario = negocio.obtenerPorId(id);

                    txtNombreUsuario.Text = usuario.NombreUsuario;
                    txtContraseña.Text = usuario.Contraseña.ToString();
                    ddlRol.SelectedValue = usuario.Rol.Id.ToString();
                }
            }
        }
        
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            UsuarioNegocio negocio = new UsuarioNegocio();
            dominio.Usuario usuario = new dominio.Usuario();

            //MODIFICACION
            if (Session["UsuarioId"] != null)
                usuario.Id = (int)Session["UsuarioId"];

            usuario.NombreUsuario = txtNombreUsuario.Text;
            usuario.Contraseña = txtContraseña.Text;            
            usuario.Rol = new dominio.RolUsuario();
            usuario.Rol.Id = int.Parse(ddlRol.SelectedValue);

            negocio.guardar(usuario);

            Session.Remove("UsuarioId");
            Response.Redirect("Usuario.aspx");
        }
    }
}