using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
    public class ProductoIngrediente
    {
        public int Id { get; set; }
        public int IdProducto { get; set; }
        public int IdIngrediente { get; set; }
        public Ingrediente Ingrediente { get; set; }
        public bool EsOpcional { get; set; }
        public int Cantidad { get; set; }
    }
}
