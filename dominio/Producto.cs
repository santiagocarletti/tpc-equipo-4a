using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace dominio
{
    public class Producto
    {
        public int Id { get; set; }
        public string Nombre { get; set; }        
        public int MinutosPreparacion { get; set; }        
        public bool Activo { get; set; }
        public Sector Sector { get; set; }

        //Para uso en ComboEdicion
        public List<ComboDetalle> DetallesCombo { get; set; } = new List<ComboDetalle>();
        public int IdGrupo { get; set; }
        public GrupoProducto Grupo { get; set; }
    }
}
