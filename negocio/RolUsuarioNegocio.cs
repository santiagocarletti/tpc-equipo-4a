using dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace negocio
{
    public class RolUsuarioNegocio
    {
        public List<RolUsuario> listar()
        {
            List<RolUsuario> lista = new List<RolUsuario>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT Id, Nombre FROM RolUsuarios");

                datos.ejecutarLectura();

                while (datos.Lectorbd.Read())
                {
                    int idRolUsuariosBD = Convert.ToInt32(datos.Lectorbd["Id"]);

                    RolUsuario aux = new RolUsuario();
                    aux.Id = Convert.ToInt32(datos.Lectorbd["Id"]);
                    aux.Descripcion = Convert.ToString(datos.Lectorbd["Nombre"]);

                    lista.Add(aux);
                }
                return lista;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
