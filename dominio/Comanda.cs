using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
    public class Comanda
    {
        public int Id { get; set; }
        public string NumeroComanda { get; set; }
        public DateTime FechaCreacion { get; set; }
        public Usuario Cajero { get; set; }
        public EstadoComanda Estado { get; set; }        
        public List<ComandaItem> Items { get; set; } = new List<ComandaItem>();

        

    }
}
