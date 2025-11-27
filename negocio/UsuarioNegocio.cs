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
        public void ValidarDuplicado(Usuario usuario)
        {
            List<Usuario> lista = listar();

            bool duplicado = lista.Any(u =>
                u.NombreUsuario.ToUpper() == usuario.NombreUsuario.ToUpper()
                && u.Id != usuario.Id
            );

            if (duplicado)
                throw new Exception("Ya existe un usuario con ese nombre.");
        }
        public Usuario Login(string usuario, string contraseña)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(@"SELECT U.Id, U.NombreUsuario, U.Contraseña, U.Activo, R.Id AS IdRol, R.Nombre AS RolNombre, R.PaginaInicio FROM Usuarios U INNER JOIN RolUsuarios R ON R.Id = U.IdRol WHERE U.NombreUsuario = @usuario AND U.Contraseña = @pass");
                datos.setearParametro("@usuario", usuario);
                datos.setearParametro("@pass", contraseña);

                datos.ejecutarLectura();

                if (datos.Lectorbd.Read())
                {
                    bool activo = (bool)datos.Lectorbd["Activo"];
                    if (!activo) return null;

                    Usuario nuevo = new Usuario();
                    nuevo.Id = (int)datos.Lectorbd["Id"];
                    nuevo.Contraseña = (string)datos.Lectorbd["Contraseña"];
                    nuevo.Activo = activo;

                    nuevo.Rol = new RolUsuario
                    {
                        Id = (int)datos.Lectorbd["IdRol"],
                        Descripcion = (string)datos.Lectorbd["RolNombre"],
                        PaginaInicio = (string)datos.Lectorbd["PaginaInicio"]
                    };

                    return nuevo;
                }

                return null;
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
        public bool ExisteContraseñaDuplicada(string contraseña, int? idActual = null)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                string query = "SELECT COUNT(*) FROM Usuarios WHERE Contraseña = @pass";

                // Si estamos editando un usuario, excluimos su propio ID
                if (idActual.HasValue)
                    query += " AND Id <> @idActual";

                datos.setearConsulta(query);
                datos.setearParametro("@pass", contraseña);

                if (idActual.HasValue)
                    datos.setearParametro("@idActual", idActual.Value);

                datos.ejecutarLectura();

                if (datos.Lectorbd.Read())
                {
                    int count = Convert.ToInt32(datos.Lectorbd[0]);
                    return count > 0; // Devuelve true si existe duplicado
                }

                return false;
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

