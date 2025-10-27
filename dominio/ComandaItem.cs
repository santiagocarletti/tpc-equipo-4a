using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
    public class ComandaItem
    {
        public int Id { get; set; }
        public Producto Producto { get; set; }
        public Combo Combo { get; set; }
        public int Cantidad { get; set; }
        public string Comentario { get; set; } //bien cocido, sal aparte,etc.

        //modificaciones
    }
}
