using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace negocio
{
    public class ComandaItemNegocio
    {
        public void Agregar(ComandaItem item)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(@"INSERT INTO ComandaItems (IdComanda, IdProducto, IdCombo, Cantidad, Comentario) VALUES (@com, @prod, @combo, @cant, @comentario)");

                datos.setearParametro("@com", item.ComandaId);
                datos.setearParametro("@prod", item.ProductoId == 0 ? (object)DBNull.Value : item.ProductoId);
                datos.setearParametro("@combo", item.ComboId == 0 ? (object)DBNull.Value : item.ComboId);
                datos.setearParametro("@cant", item.Cantidad);
                datos.setearParametro("@comentario", item.Comentario ?? "");

                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
