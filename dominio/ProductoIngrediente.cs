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
        public string NombreIngrediente { get; set; }
        public bool EsOpcional { get; set; }
        public int IdSector { get; set; }
        public string NombreSector { get; set; }
        public bool Activo { get; set; }
        public int MinutosPreparacion { get; set; }
        //Para listar Ingredientes por Producto
        public Producto Producto { get; set; }
    }
}
