using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
    public class Ingrediente
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public int IdSector { get; set; }
        public string NombreSector { get; set; }
        public int MinutosPreparacion { get; set; }
        public bool Activo { get; set; }
    }
}
