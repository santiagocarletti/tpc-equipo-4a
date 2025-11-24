using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tpc_equipo_4a
{
    public partial class MasterPage : System.Web.UI.MasterPage
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                AplicarEstadoNavbar();
            }

        }
        private void AplicarEstadoNavbar()
        {

            string currentPage = System.IO.Path.GetFileName(Request.Path);
            if (currentPage.Equals("Login.aspx", StringComparison.OrdinalIgnoreCase))
            {
                lnkLogin.Visible = false;
                return;
            }


            var usuario = Session["Usuario"] as dominio.Usuario;

            if (usuario == null)
            {

                lnkLogin.Visible = true;
                lnkLoginText.InnerText = "Login";
                brandLink.HRef = ResolveUrl("~/Login.aspx");
                brandLink.Attributes.Remove("class");
            }
            else
            {

                lnkLogin.Visible = true;
                lnkLoginText.InnerText = "Cerrar sesión";

                lnkLogin.Controls.Clear();
                lnkLogin.Controls.Add(new LiteralControl("<span class=\"material-symbols-outlined\">logout</span> "));
                lnkLogin.Controls.Add(new LiteralControl("<span id=\"lnkLoginTextInner\">" + HttpUtility.HtmlEncode(lnkLoginText.InnerText) + "</span>"));


                string rol = usuario.Rol?.Descripcion ?? string.Empty;
                if (!rol.Equals("Encargado", StringComparison.OrdinalIgnoreCase))
                {

                    brandLink.HRef = "javascript:void(0);";
                    string existing = brandLink.Attributes["class"] ?? "";
                    if (!existing.Contains("disabled-link"))
                        brandLink.Attributes["class"] = (existing + " disabled-link").Trim();
                }
                else
                {

                    brandLink.HRef = ResolveUrl("~/Default.aspx");
                    string existing = brandLink.Attributes["class"] ?? "";
                    brandLink.Attributes["class"] = existing.Replace("disabled-link", "").Trim();
                }
            }
        }
        protected void lnkLogin_Click(object sender, EventArgs e)
        {
            var usuario = Session["Usuario"] as dominio.Usuario;

            if (usuario == null)
            {

                Response.Redirect("~/Login.aspx", false);
                return;
            }

            Session.Clear();
            Session.Abandon();

            Response.Redirect("~/Login.aspx", false);
        }
    }
}