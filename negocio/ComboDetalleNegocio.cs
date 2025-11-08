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
                //datos.setearConsulta("SELECT CD.Id AS IdComboDetalle, CD.IdCombo, CD.IdProducto, CD.Cantidad AS CantidadProducto FROM ComboDetalles CD WHERE CD.IdCombo = @idCombo");
                datos.setearConsulta("SELECT CD.Id AS IdComboDetalle, CD.IdCombo, P.Nombre AS NombreProducto, CD.IdProducto, CD.Cantidad AS CantidadProducto FROM ComboDetalles CD LEFT JOIN Productos P ON CD.IdProducto = P.Id WHERE CD.IdCombo = @idCombo");

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
                    prodAux.Nombre = Convert.ToString(datos.Lectorbd["NombreProducto"]);
                    //prodAux.Nombre = Convert.ToString(datos.Lectorbd["NombreProducto"]);

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
