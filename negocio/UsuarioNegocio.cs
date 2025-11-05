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

                datos.setearConsulta(@"SELECT U.Id AS IdUsuario, U.NombreUsuario, R.Id AS IdRol, R.Nombre AS Rol, U.Activo FROM Usuarios U LEFT JOIN RolUsuarios R ON R.IdUsuario = U.Id ");
                datos.ejecutarLectura();
                while (datos.Lectorbd.Read())
                {
                    Usuario aux = new Usuario();
                    aux.Id = Convert.ToInt32(datos.Lectorbd["IdUsuario"]);
                    aux.NombreUsuario = Convert.ToString(datos.Lectorbd["NombreUsuario"]);

                    if (datos.Lectorbd["Rol"] != DBNull.Value)
                    {
                        aux.Rol = new RolUsuario
                        {
                            Id = Convert.ToInt32(datos.Lectorbd["IdRol"]),
                            Descripcion = Convert.ToString(datos.Lectorbd["Rol"])
                        };
                    }

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


        public void cambiarEstadoUsuario(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(
                    "UPDATE Usuarios SET Activo = CASE WHEN Activo = 1 THEN 0 ELSE 1 END WHERE Id = @Id");
                datos.setearParametro("@Id", id);
                datos.ejecutarAccion();
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
