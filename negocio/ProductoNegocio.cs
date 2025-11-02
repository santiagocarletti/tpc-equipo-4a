using dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace negocio
{
    public class ProductoNegocio
    {
        public List<Producto> listar()
        {
            List<Producto> lista = new List<Producto>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT P.Id, P.Nombre, P.MinutosPreparacion, P.Activo, S.Nombre AS Sector FROM PRODUCTOS P LEFT JOIN Sectores S ON P.IdSector = S.Id");

                datos.ejecutarLectura();

                while (datos.Lectorbd.Read())
                {
                    int idArtBD = Convert.ToInt32(datos.Lectorbd["Id"]);

                    Producto aux = new Producto();
                    aux.Id = Convert.ToInt32(datos.Lectorbd["Id"]);
                    aux.Nombre = Convert.ToString(datos.Lectorbd["Nombre"]);
                    aux.MinutosPreparacion = Convert.ToInt32(datos.Lectorbd["MinutosPreparacion"]);
                    aux.Activo = Convert.ToBoolean(datos.Lectorbd["Activo"]);
                    aux.Sector = new Sector();
                    aux.Sector.Nombre = Convert.ToString(datos.Lectorbd["Sector"]);

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
        public void cambiarEstadoProducto(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("UPDATE Productos SET Activo = CASE WHEN Activo = 1 THEN 0 ELSE 1 END WHERE Id = @Id");
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
        public Producto obtenerPorId(int idProducto)
        {
            AccesoDatos datos = new AccesoDatos();
            Producto prod = new Producto();

            try
            {
                datos.setearConsulta("SELECT P.Id, P.Nombre, P.MinutosPreparacion, P.Activo, S.Id AS IdSector, S.Nombre AS Sector FROM Productos P LEFT JOIN Sectores S ON P.IdSector = S.Id WHERE P.Id = @idProducto");
                datos.setearParametro("@idProducto", idProducto);
                datos.ejecutarLectura();

                while (datos.Lectorbd.Read())
                {
                    prod.Id = Convert.ToInt32(datos.Lectorbd["Id"]);
                    prod.Nombre = Convert.ToString(datos.Lectorbd["Nombre"]);
                    prod.MinutosPreparacion = Convert.ToInt32(datos.Lectorbd["MinutosPreparacion"]);
                    prod.Activo = Convert.ToBoolean(datos.Lectorbd["Activo"]);

                    //prod.Sector = new Sector
                    //{
                    //    Id = Convert.ToInt32(datos.Lectorbd["IdSector"]),
                    //    Nombre = Convert.ToString(datos.Lectorbd["Sector"])
                    //};

                    prod.Sector = new Sector();
                    prod.Sector.Id = Convert.ToInt32(datos.Lectorbd["IdSector"]);
                    prod.Sector.Nombre = Convert.ToString(datos.Lectorbd["Sector"]);
                }

                return prod;
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
