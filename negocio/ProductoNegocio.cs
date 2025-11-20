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
        public List<Producto> listar(int idSector = -1)
        {
            List<Producto> lista = new List<Producto>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                string consulta = @"SELECT P.Id, P.Nombre, P.MinutosPreparacion, P.Activo, S.Id AS IdSector, S.Nombre AS Sector FROM PRODUCTOS P LEFT JOIN Sectores S ON P.IdSector = S.Id";

                if (idSector != -1)
                    consulta += " WHERE S.Id = @idSector";

                datos.setearConsulta(consulta);

                if (idSector != -1)
                    datos.setearParametro("@idSector", idSector);

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
            try
            {
                AccesoDatos datosProd = new AccesoDatos();
                datosProd.setearConsulta("UPDATE Productos SET Activo = CASE WHEN Activo = 1 THEN 0 ELSE 1 END WHERE Id = @Id");
                datosProd.setearParametro("@Id", id);
                datosProd.ejecutarAccion();
                datosProd.cerrarConexion();

                //DESACTIVA COMBOS QUE CONTENGAN EL PRODUCTO
                AccesoDatos datosCombos = new AccesoDatos();
                datosCombos.setearConsulta(@"UPDATE Combos SET Activo = 0 WHERE Id IN (SELECT DISTINCT IdCombo FROM ComboDetalles WHERE IdProducto = @IdProducto)");
                datosCombos.setearParametro("@IdProducto", id);
                datosCombos.ejecutarAccion();
                datosCombos.cerrarConexion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                //datos.cerrarConexion();
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
        public void guardar(Producto producto)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                if (producto.Id == 0)
                {
                    //Agregar nuevo
                    datos.setearConsulta("INSERT INTO Productos(Nombre, MinutosPreparacion, Activo, IdSector) VALUES(@nombre, @minutos, 1, @idSector)");
                    datos.setearParametro("@id", producto.Id);
                }
                else
                {
                    //Modificar
                    datos.setearConsulta("UPDATE Productos SET Nombre = @nombre, MinutosPreparacion = @minutos, IdSector = @idSector WHERE Id = @id");
                    datos.setearParametro("@id", producto.Id);
                }

                datos.setearParametro("@nombre", producto.Nombre);
                datos.setearParametro("@minutos", producto.MinutosPreparacion);
                datos.setearParametro("@activo", producto.Activo);
                datos.setearParametro("@idSector", producto.Sector.Id);

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
