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

                datos.setearConsulta(@"SELECT U.Id AS IdUsuario, U.NombreUsuario, R.Id as IdRol, R.Nombre AS Rol, U.Activo FROM Usuarios U LEFT JOIN RolUsuarios R ON R.Id = U.IdRol;");
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
        public Usuario obtenerPorId(int idUsuario)
        {
            AccesoDatos datos = new AccesoDatos();
            Usuario usuario = new Usuario();

            try
            {
                datos.setearConsulta(@"SELECT U.Id AS IdUsuario, U.NombreUsuario,U.Contraseña, R.Id as IdRol, R.Nombre AS Rol, U.Activo FROM Usuarios U LEFT JOIN RolUsuarios R ON R.Id = U.IdRol WHERE U.Id = @id;");
                datos.setearParametro("@id", idUsuario);
                datos.ejecutarLectura();

                if (datos.Lectorbd.Read())
                {
                    usuario.Id = Convert.ToInt32(datos.Lectorbd["IdUsuario"]);
                    usuario.NombreUsuario = Convert.ToString(datos.Lectorbd["NombreUsuario"]);
                    usuario.Contraseña = Convert.ToString(datos.Lectorbd["Contraseña"]);
                    usuario.Activo = Convert.ToBoolean(datos.Lectorbd["Activo"]);

                    usuario.Rol = new RolUsuario();

                    if (datos.Lectorbd["IdRol"] != DBNull.Value)
                        usuario.Rol.Id = Convert.ToInt32(datos.Lectorbd["IdRol"]);

                    if (datos.Lectorbd["Rol"] != DBNull.Value)
                        usuario.Rol.Descripcion = Convert.ToString(datos.Lectorbd["Rol"]);
                }

                return usuario;
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

        public void guardar(Usuario usuario)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                if (usuario.Id == 0)
                {
                    //Agregar nuevo
                    datos.setearConsulta("INSERT INTO Usuarios(NombreUsuario, Contraseña, Activo, IdRol) VALUES(@nombreUsuario,@contraseña,1, @idRol)");
                    datos.setearParametro("@id", usuario.Id);
                }
                else
                {
                    //Modificar
                    datos.setearConsulta("UPDATE Usuarios SET NombreUsuario = @nombreUsuario, Contraseña = @contraseña, IdRol = @idRol WHERE Id = @id");
                    datos.setearParametro("@id", usuario.Id);
                }

                datos.setearParametro("@nombreUsuario", usuario.NombreUsuario);
                datos.setearParametro("@contraseña", usuario.Contraseña);
                datos.setearParametro("@activo", usuario.Activo);
                datos.setearParametro("@idRol", usuario.Rol.Id);

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

