using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
    public class ComboDetalle
    {
        public int Id { get; set; }

        public int IdCombo { get; set; }
        public Combo Combo { get; set; }
        public int IdProducto { get; set; }
        public Producto Producto { get; set; }

        public int Cantidad { get; set; }
    }
}
