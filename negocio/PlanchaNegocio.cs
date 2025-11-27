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
                datos.setearConsulta(@"
            SELECT 
                c.Id AS IdComanda,
                c.NumeroComanda,
                c.FechaCreacion,

                ci.IdCombo,
                co.Nombre AS NombreCombo,
                ci.Cantidad AS CantidadCombo,

                ci.IdProducto,
                p.Nombre AS NombreProducto,

                p.IdSector AS SectorProducto
            FROM Comandas c
            JOIN ComandaItems ci   ON ci.IdComanda = c.Id
            LEFT JOIN Combos    co ON co.Id = ci.IdCombo
            LEFT JOIN Productos p  ON p.Id = ci.IdProducto
            WHERE c.IdEstadoComanda = 3
            ORDER BY c.FechaCreacion ASC, c.Id ASC
        ");

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

                    int? idCombo = datos.Lectorbd["IdCombo"] as int?;
                    int? idProducto = datos.Lectorbd["IdProducto"] as int?;
                    int sector = datos.Lectorbd["SectorProducto"] as int? ?? 0;

                    // Si es COMBO
                    if (idCombo != null)
                    {
                        string nombreCombo = datos.Lectorbd["NombreCombo"].ToString();
                        int cantidadCombo = (int)datos.Lectorbd["CantidadCombo"];

                        // Si aún no se agregó ese combo a la tarjeta → agregar "1x Cheeseburger"
                        string lineaCombo = $"{cantidadCombo}x {nombreCombo}";

                        if (!ped.ProductosTexto.Contains(lineaCombo))
                        {
                            if (!string.IsNullOrEmpty(ped.ProductosTexto))
                                ped.ProductosTexto += "<br/>";

                            ped.ProductosTexto += $"<b>{lineaCombo}</b>";
                        }

                        // Ahora listar SOLO productos del sector Plancha pertenecientes al combo
                        if (sector == 2)
                        {
                            string nombreProd = datos.Lectorbd["NombreProducto"].ToString();

                            ped.ProductosTexto += $"<br/> - {nombreProd}";
                        }
                    }
                    else if (idProducto != null && sector == 2)
                    {
                        // PRODUCTO SUELTO DEL SECTOR
                        if (!string.IsNullOrEmpty(ped.ProductosTexto))
                            ped.ProductosTexto += "<br/>";

                        string nombreProd = datos.Lectorbd["NombreProducto"].ToString();
                        ped.ProductosTexto += $"1x {nombreProd}";
                    }
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
