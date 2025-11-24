using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace negocio
{
    public class GrupoProductoNegocio
    {
        public List<GrupoProducto> listar()
        {
            List<GrupoProducto> lista = new List<GrupoProducto>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT Id, Nombre FROM GruposProducto");

                datos.ejecutarLectura();

                while (datos.Lectorbd.Read())
                {
                    GrupoProducto aux = new GrupoProducto();
                    aux.Id = (int)datos.Lectorbd["Id"];
                    aux.Nombre = (string)datos.Lectorbd["Nombre"];
                    lista.Add(aux);
                }

                return lista;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
