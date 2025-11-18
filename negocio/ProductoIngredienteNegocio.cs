using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace negocio
{
    public class ProductoIngredienteNegocio
    {
        public List<ProductoIngrediente> IngredientesPorProducto(int idProducto)
        {
            List<ProductoIngrediente> lista = new List<ProductoIngrediente>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT P.Id AS IdProducto, P.Nombre AS NombreProducto, PRIN.Id AS IdProdIng, PRIN.NombreIngrediente, PRIN.EsOpcional, PRIN.IdSector, PRIN.Activo, S.Nombre AS NombreSector, PRIN.MinutosPreparacion FROM ProductoIngredientes PRIN LEFT JOIN Productos P ON PRIN.IdProducto = P.Id LEFT JOIN Sectores S ON PRIN.IdSector = S.Id WHERE PRIN.IdProducto = @idProducto;");

                datos.setearParametro("@idProducto", idProducto);

                datos.ejecutarLectura();

                while (datos.Lectorbd.Read())
                {
                    int idProductoIngredienteBD = Convert.ToInt32(datos.Lectorbd["IdProdIng"]);

                    ProductoIngrediente aux = new ProductoIngrediente();
                    aux.Id = Convert.ToInt32(datos.Lectorbd["IdProdIng"]);
                    aux.IdProducto = Convert.ToInt32(datos.Lectorbd["IdProducto"]);
                    aux.NombreIngrediente = Convert.ToString(datos.Lectorbd["NombreIngrediente"]);
                    aux.EsOpcional = Convert.ToBoolean(datos.Lectorbd["EsOpcional"]);
                    aux.IdSector = Convert.ToInt32(datos.Lectorbd["IdSector"]);
                    aux.Activo = Convert.ToBoolean(datos.Lectorbd["Activo"]);
                    aux.MinutosPreparacion = Convert.ToInt32(datos.Lectorbd["MinutosPreparacion"]);
                    aux.NombreSector = Convert.ToString(datos.Lectorbd["NombreSector"]);
                    Producto prodAux = new Producto();
                    prodAux.Id = Convert.ToInt32(datos.Lectorbd["IdProducto"]);
                    prodAux.Nombre = Convert.ToString(datos.Lectorbd["NombreProducto"]);
                    
                    aux.Producto = prodAux;

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
