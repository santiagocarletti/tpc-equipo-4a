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
                datos.setearConsulta(@"SELECT PRIN.Id AS IdProductoIngrediente, PRIN.IdProducto, PRIN.IdIngrediente, PRIN.EsOpcional, PRIN.Cantidad, I.Nombre AS NombreIngrediente, I.MinutosPreparacion, I.Activo, S.Id AS IdSector, S.Nombre AS NombreSector FROM ProductoIngredientes PRIN LEFT JOIN Ingredientes I ON PRIN.IdIngrediente = I.Id LEFT JOIN Sectores S ON I.IdSector = S.Id WHERE PRIN.IdProducto = @idProducto;");

                datos.setearParametro("@idProducto", idProducto);

                datos.ejecutarLectura();

                while (datos.Lectorbd.Read())
                {

                    ProductoIngrediente aux = new ProductoIngrediente();
                    aux.Id = Convert.ToInt32(datos.Lectorbd["IdProductoIngrediente"]);
                    aux.IdProducto = Convert.ToInt32(datos.Lectorbd["IdProducto"]);
                    aux.IdIngrediente = Convert.ToInt32(datos.Lectorbd["IdIngrediente"]);
                    aux.EsOpcional = Convert.ToBoolean(datos.Lectorbd["EsOpcional"]);
                    aux.Cantidad = Convert.ToInt32(datos.Lectorbd["Cantidad"]);

                    Ingrediente ing = new Ingrediente();
                    ing.Id = aux.IdIngrediente;
                    ing.Nombre = Convert.ToString(datos.Lectorbd["NombreIngrediente"]);
                    ing.MinutosPreparacion = Convert.ToInt32(datos.Lectorbd["MinutosPreparacion"]);
                    ing.Activo = Convert.ToBoolean(datos.Lectorbd["Activo"]);
                    ing.IdSector = Convert.ToInt32(datos.Lectorbd["IdSector"]);
                    ing.NombreSector = Convert.ToString(datos.Lectorbd["NombreSector"]);

                    aux.Ingrediente = ing;

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
        public List<ProductoIngrediente> ListarTodosParaProducto(int idProducto)
        {
            IngredienteNegocio ingNegocio = new IngredienteNegocio();
            List<Ingrediente> todos = ingNegocio.listar();

            List<ProductoIngrediente> asociados = IngredientesPorProducto(idProducto);

            List<ProductoIngrediente> resultado = new List<ProductoIngrediente>();

            foreach (var ing in todos)
            {
                var prodIng = asociados.FirstOrDefault(a => a.IdIngrediente == ing.Id);

                ProductoIngrediente aux = new ProductoIngrediente
                {
                    IdIngrediente = ing.Id,
                    Ingrediente = ing,
                    EsOpcional = prodIng != null ? prodIng.EsOpcional : false,
                    Cantidad = prodIng != null ? prodIng.Cantidad : 0,
                    IdProducto = idProducto
                };

                resultado.Add(aux);
            }
            return resultado;
        }
    }
}
