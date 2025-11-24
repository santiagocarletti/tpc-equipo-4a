using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace negocio
{
    public class ComandaNegocio
    {
        public int AgregarYDevolverId(Comanda c)
        {
            int estadoInicial = 3;
            //En preparación

            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(@"INSERT INTO Comandas (NumeroComanda, FechaCreacion, IdEstadoComanda, IdUsuarioCajero) OUTPUT INSERTED.Id VALUES (@num, @fecha, @estado, @usuario)");

                datos.setearParametro("@num", c.NumeroComanda);
                datos.setearParametro("@fecha", c.FechaCreacion);
                //datos.setearParametro("@estado", c.EstadoId);
                datos.setearParametro("@estado", estadoInicial);
                datos.setearParametro("@usuario", c.UsuarioId);

                datos.ejecutarLectura();

                if (datos.Lectorbd.Read())
                    return (int)datos.Lectorbd[0];

                return 0;
            }
            finally { datos.cerrarConexion(); }
        }
    }
}
