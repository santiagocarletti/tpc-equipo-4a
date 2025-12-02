using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace negocio
{
    public class ComandaItemModificadorNegocio
    {
        public void EliminarPorItem(int idComandaItem)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("DELETE FROM ComandaItemModificadores WHERE IdComandaItem = @id");
                datos.setearParametro("@id", idComandaItem);
                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        public void Agregar(ComandaItemModificador m)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(
                    "INSERT INTO ComandaItemModificadores (IdComandaItem, Descripcion) VALUES (@item, @desc)");

                datos.setearParametro("@item", m.IdComandaItem);
                datos.setearParametro("@desc", m.Descripcion);

                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

    }
}
