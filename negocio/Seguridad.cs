using dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI;

namespace negocio
{
    public static class Seguridad
    {
        public static bool EsEncargado(Usuario user) =>
            user?.Rol?.Descripcion.Equals("Encargado", StringComparison.OrdinalIgnoreCase) ?? false;

        public static bool EsCajero(Usuario user) =>
            user?.Rol?.Descripcion.Equals("Cajero", StringComparison.OrdinalIgnoreCase) ?? false;

        public static bool EsCocinero(Usuario user) =>
            user?.Rol?.Descripcion.Equals("Cocinero", StringComparison.OrdinalIgnoreCase) ?? false;

        public static bool EsDespachante(Usuario user) =>
            user?.Rol?.Descripcion.Equals("Despachante", StringComparison.OrdinalIgnoreCase) ?? false;

        public static void ValidarAcceso(Usuario user, Page page)
        {
            if (page == null) throw new ArgumentNullException(nameof(page));

            if (user == null)
            {
                page.Response.Redirect("~/Login.aspx", false);
                return;
            }

            if (EsEncargado(user)) return;


            string ruta = page.Request.Url.AbsolutePath.ToLowerInvariant();


            string paginaPermitida = user.Rol?.PaginaInicio?.ToLowerInvariant();

            
        }

    }
}
