using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
    public class Combo
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public bool Activo { get; set; }

        //crearia la clase ComboDetalle/ComboItem para ver como esta compuesto el combo
        public List<ComboDetalle> Detalles { get; set; } = new List<ComboDetalle>();
        public List<Producto> ProductosPermitidos { get; set; } = new List<Producto>();
    }
}
