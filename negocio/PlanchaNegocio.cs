using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace negocio
{
    public class PlanchaNegocio
    {
        public List<PedidoPlancha> ListarPedidosPlancha()
        {
            List<PedidoPlancha> lista = new List<PedidoPlancha>();
            Dictionary<int, PedidoPlancha> dict = new Dictionary<int, PedidoPlancha>();

            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.limpiarParametros();
                datos.setearConsulta(@" SELECT c.Id AS IdComanda, c.NumeroComanda AS NumeroComanda, c.FechaCreacion,
                CASE 
                WHEN ci.IdCombo IS NOT NULL THEN co.Nombre
                ELSE p.Nombre
                END  AS NombreItem,
                SUM(ci.Cantidad) AS Cantidad
                FROM Comandas c
                JOIN ComandaItems ci   ON ci.IdComanda = c.Id
                LEFT JOIN Combos    co ON co.Id = ci.IdCombo
                LEFT JOIN Productos p  ON p.Id = ci.IdProducto
                WHERE c.IdEstadoComanda = 3
                AND ((ci.IdProducto IS NOT NULL AND p.IdSector = 2)
                OR
                (ci.IdCombo IS NOT NULL AND EXISTS(
                SELECT 1
                FROM ComboDetalles cd
                JOIN Productos p2 ON p2.Id = cd.IdProducto
                WHERE cd.IdCombo = ci.IdCombo
                AND p2.IdSector = 2)))
                GROUP BY c.Id, c.NumeroComanda, c.FechaCreacion,
                CASE WHEN ci.IdCombo IS NOT NULL THEN co.Nombre ELSE p.Nombre END
                ORDER BY c.FechaCreacion, c.Id; ");

                datos.ejecutarLectura();

                while (datos.Lectorbd.Read())
                {
                    int id = (int)datos.Lectorbd["IdComanda"];

                    if (!dict.TryGetValue(id, out PedidoPlancha ped))
                    {
                        ped = new PedidoPlancha
                        {
                            IdComanda = id,
                            NumeroComanda = datos.Lectorbd["NumeroComanda"].ToString(),
                            FechaCreacion = (DateTime)datos.Lectorbd["FechaCreacion"],
                            ProductosTexto = "",
                            Comentarios = "Sin comentarios"
                        };

                        dict.Add(id, ped);
                        lista.Add(ped);
                    }

                    string item = datos.Lectorbd["NombreItem"].ToString();
                    int cant = Convert.ToInt32(datos.Lectorbd["Cantidad"]);

                    if (!string.IsNullOrEmpty(ped.ProductosTexto))
                        ped.ProductosTexto += "<br />";

                    ped.ProductosTexto += $"{cant}x {item}";
                }
            }
            finally
            {
                datos.cerrarConexion();
            }

            foreach (var p in lista)
                p.TiempoTranscurrido = FormatearTiempo(p.FechaCreacion);

            return lista;
        }

        private string FormatearTiempo(DateTime fecha)
        {
            var dif = DateTime.Now - fecha;

            if (dif.TotalMinutes < 1)
                return "Hace segundos";
            if (dif.TotalHours < 1)
                return $"Hace {(int)dif.TotalMinutes} min";
            if (dif.TotalHours < 24)
                return $"Hace {(int)dif.TotalHours} h";

            return fecha.ToString("dd/MM HH:mm");
        }
    }
}
