using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
    public class PedidoPlancha
    {
        public int IdComanda { get; set; }
        public string NumeroComanda { get; set; }
        public DateTime FechaCreacion { get; set; }
        public string ProductosTexto { get; set; }
        public string Comentarios { get; set; }
        public string TiempoTranscurrido { get; set; }
    }
}

