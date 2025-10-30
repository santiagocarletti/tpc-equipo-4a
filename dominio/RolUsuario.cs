using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
    public class RolUsuario
    {
        public int Id { get; set; }
        public string Descripcion { get; set; } // encargado, cajero, plancha, freidora, armado, despacho, etc.
    }
}
