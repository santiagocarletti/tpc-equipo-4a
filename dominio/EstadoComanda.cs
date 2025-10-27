using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
    public class EstadoComanda
    {
        public int Id { get; set; }
        public int Nombre { get; set; } //"en preparación", "lista","llamar cliente", "entregada", etc.
        public string Descripcion { get; set; }
    }
}
