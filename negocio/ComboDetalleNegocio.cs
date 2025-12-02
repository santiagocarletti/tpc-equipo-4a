using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace negocio
{
    public class ComboDetalleNegocio
    {
        public List<ComboDetalle> DetallesPorCombo(int idCombo)
        {
            List<ComboDetalle> lista = new List<ComboDetalle>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta(@"SELECT CD.Id AS IdComboDetalle, CD.IdCombo, CD.IdProducto, CD.Cantidad AS CantidadProducto, P.Nombre AS NombreProducto, P.IdGrupo, G.Nombre AS NombreGrupo FROM ComboDetalles CD INNER JOIN Productos P ON CD.IdProducto = P.Id LEFT JOIN GruposProducto G ON P.IdGrupo = G.Id WHERE CD.IdCombo = @idCombo");

                datos.setearParametro("@idCombo", idCombo);

                datos.ejecutarLectura();

                while (datos.Lectorbd.Read())
                {
                    int idComboDetalleBD = Convert.ToInt32(datos.Lectorbd["IdComboDetalle"]);

                    ComboDetalle aux = new ComboDetalle();
                    aux.Id = Convert.ToInt32(datos.Lectorbd["IdComboDetalle"]);
                    aux.IdCombo = Convert.ToInt32(datos.Lectorbd["IdCombo"]);
                    aux.IdProducto = Convert.ToInt32(datos.Lectorbd["IdProducto"]);
                    aux.Cantidad = Convert.ToInt32(datos.Lectorbd["CantidadProducto"]);
                    Producto prodAux = new Producto();
                    prodAux.Id = aux.IdProducto;
                    prodAux.Nombre = Convert.ToString(datos.Lectorbd["NombreProducto"]);

                    prodAux.IdGrupo = datos.Lectorbd["IdGrupo"] != DBNull.Value
                    ? Convert.ToInt32(datos.Lectorbd["IdGrupo"])
                    : 0;

                    prodAux.Grupo = new GrupoProducto
                    {
                        Id = prodAux.IdGrupo,
                        Nombre = Convert.ToString(datos.Lectorbd["NombreGrupo"])
                    };

                    GrupoProducto g = new GrupoProducto();
                    g.Id = prodAux.IdGrupo;
                    if (datos.Lectorbd["NombreGrupo"] != DBNull.Value)
                        g.Nombre = Convert.ToString(datos.Lectorbd["NombreGrupo"]);
                    else
                        g.Nombre = "";

                    prodAux.Grupo = g;

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
        public void Agregar(ComboDetalle detalle)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("INSERT INTO ComboDetalles (IdCombo, IdProducto, Cantidad) VALUES (@IdCombo, @IdProducto, @Cantidad)");
                datos.setearParametro("@IdCombo", detalle.IdCombo);
                datos.setearParametro("@IdProducto", detalle.IdProducto);
                datos.setearParametro("@Cantidad", detalle.Cantidad);
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
        public void Modificar(ComboDetalle detalle)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(
                    "UPDATE ComboDetalles SET IdProducto = @idProducto, Cantidad = @cantidad WHERE Id = @id");

                datos.setearParametro("@id", detalle.Id);
                datos.setearParametro("@idProducto", detalle.IdProducto);
                datos.setearParametro("@cantidad", detalle.Cantidad);

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
        public void Eliminar(int idDetalle)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("DELETE FROM ComboDetalles WHERE Id = @Id");
                datos.setearParametro("@Id", idDetalle);
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
        public bool TieneProductosInactivos(int idCombo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(@"SELECT COUNT(*) FROM ComboDetalles CD INNER JOIN Productos P ON P.Id = CD.IdProducto WHERE CD.IdCombo = @idCombo AND P.Activo = 0");
                datos.setearParametro("@idCombo", idCombo);

                int cantidad = (int)datos.ejecutarAccionConReturn();
                return cantidad > 0;
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
