using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace negocio
{
    public class UsuarioNegocio
    {
        public List<Usuario> listar()
        {
            List<Usuario> lista = new List<Usuario>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT U.Id, U.NombreUsuario, R.Id AS IdRol, R.Nombre AS Rol, U.Activo FROM Usuarios U LEFT JOIN RolUsuarios R ON U.IdRol = R.Id");

                datos.ejecutarLectura();

                while (datos.Lectorbd.Read())
                {
                    int idArtBD = Convert.ToInt32(datos.Lectorbd["Id"]);

                    Usuario aux = new Usuario();
                    aux.NombreUsuario = Convert.ToString(datos.Lectorbd["NombreUsuario"]);
                    //Evaluar cómo menejar relación entre usuario(s) y Rol(es)
                    aux.RolUsuarioId = Convert.ToInt32(datos.Lectorbd["IdRol"]);
                    aux.Activo = Convert.ToBoolean(datos.Lectorbd["Activo"]);

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
