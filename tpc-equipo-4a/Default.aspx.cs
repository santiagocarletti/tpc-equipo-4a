using dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

namespace tpc_equipo_4a
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Para inicio de Comandas en Cajero. Cajero por defecto
            if (Session["UsuarioId"] == null)
                Session["UsuarioId"] = 9;
        }
    }
}