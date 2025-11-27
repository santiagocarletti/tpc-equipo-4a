using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
    public class ReporteIngrediente
    {
        public int IdIngrediente { get; set; }
        public string NombreIngrediente { get; set; }
        public string SectorOrigen { get; set; }
        public string UsuarioReporta { get; set; }
        public DateTime FechaHoraReporte { get; set; }
        public string Estado { get; set; } // "Pendiente", "Resuelto"

        public ReporteIngrediente()
        {
            FechaHoraReporte = DateTime.Now;
            Estado = "Pendiente";
        }

        public string TiempoTranscurrido
        {
            get
            {
                TimeSpan diferencia = DateTime.Now - FechaHoraReporte;

                if (diferencia.TotalMinutes < 1)
                    return "Hace menos de 1 min";
                else if (diferencia.TotalMinutes < 60)
                    return $"Hace {(int)diferencia.TotalMinutes} min";
                else if (diferencia.TotalHours < 24)
                    return $"Hace {(int)diferencia.TotalHours} hr";
                else
                    return $"Hace {(int)diferencia.TotalDays} días";
            }
        }
    }
}
    
