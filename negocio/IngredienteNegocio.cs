using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace negocio
{
    public class IngredienteNegocio
    {
        public List<Ingrediente> listar(int idSector = -1)
        {
            List<Ingrediente> lista = new List<Ingrediente>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                string consulta = @"SELECT I.Id, I.Nombre, I.MinutosPreparacion, I.Activo, S.Id AS IdSector, S.Nombre AS Sector FROM Ingredientes I LEFT JOIN Sectores S ON I.IdSector = S.Id";

                if (idSector != -1)
                    consulta += " WHERE S.Id = @idSector";

                datos.setearConsulta(consulta);

                if (idSector != -1)
                    datos.setearParametro("@idSector", idSector);

                datos.ejecutarLectura();

                while (datos.Lectorbd.Read())
                {
                    int idIngBD = Convert.ToInt32(datos.Lectorbd["Id"]);

                    Ingrediente aux = new Ingrediente();
                    aux.Id = Convert.ToInt32(datos.Lectorbd["Id"]);
                    aux.Nombre = Convert.ToString(datos.Lectorbd["Nombre"]);
                    aux.MinutosPreparacion = Convert.ToInt32(datos.Lectorbd["MinutosPreparacion"]);
                    aux.Activo = Convert.ToBoolean(datos.Lectorbd["Activo"]);
                    aux.IdSector = Convert.ToInt32(datos.Lectorbd["IdSector"]);
                    aux.NombreSector = Convert.ToString(datos.Lectorbd["Sector"]);

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
        public void cambiarEstadoIngrediente(int id)
        {
            try
            {
                AccesoDatos datosProd = new AccesoDatos();
                datosProd.setearConsulta("UPDATE Ingredientes SET Activo = CASE WHEN Activo = 1 THEN 0 ELSE 1 END WHERE Id = @Id");
                datosProd.setearParametro("@Id", id);
                datosProd.ejecutarAccion();
                datosProd.cerrarConexion();


                //DESACTIVAR PRODUCTOS QUE CONTENGAN EL INGREDIENTE ?
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
            }
        }
        public void guardar(Ingrediente ingrediente)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                if (ingrediente.Id == 0)
                {
                    //Agregar nuevo
                    datos.setearConsulta("INSERT INTO Ingredientes (Nombre, IdSector, MinutosPreparacion, Activo) VALUES (@nombre, @idSector, @minutos, 0)");
                    datos.setearParametro("@id", ingrediente.Id);
                }
                else
                {
                    //Modificar
                    datos.setearConsulta("UPDATE Ingredientes SET Nombre = @nombre, IdSector = @idSector, MinutosPreparacion = @minutos WHERE Id = @id");
                    datos.setearParametro("@id", ingrediente.Id);
                }

                datos.setearParametro("@nombre", ingrediente.Nombre);
                datos.setearParametro("@minutos", ingrediente.MinutosPreparacion);
                datos.setearParametro("@activo", ingrediente.Activo);
                datos.setearParametro("@idSector", ingrediente.IdSector);

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
        public Ingrediente obtenerPorId(int idIngrediente)
        {
            AccesoDatos datos = new AccesoDatos();
            Ingrediente ing = new Ingrediente();

            try
            {
                datos.setearConsulta(@"SELECT I.Id, I.Nombre, I.MinutosPreparacion, I.Activo, S.Id AS IdSector, S.Nombre AS Sector FROM Ingredientes I LEFT JOIN Sectores S ON I.IdSector = S.Id WHERE I.Id = @idIngrediente");

                datos.setearParametro("@idIngrediente", idIngrediente);
                datos.ejecutarLectura();

                if (datos.Lectorbd.Read())
                {
                    ing.Id = Convert.ToInt32(datos.Lectorbd["Id"]);
                    ing.Nombre = Convert.ToString(datos.Lectorbd["Nombre"]);
                    ing.MinutosPreparacion = Convert.ToInt32(datos.Lectorbd["MinutosPreparacion"]);
                    ing.Activo = Convert.ToBoolean(datos.Lectorbd["Activo"]);
                    ing.IdSector = Convert.ToInt32(datos.Lectorbd["IdSector"]);
                    ing.NombreSector = Convert.ToString(datos.Lectorbd["Sector"]);
                }

                return ing;
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
