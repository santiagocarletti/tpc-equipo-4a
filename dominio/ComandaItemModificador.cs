using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
    public class ComandaItemModificador
    {
        public int Id { get; set; }
        public int ComandaItemId { get; set; }
        public ComandaItem ComandaItem { get; set; }
        public int ProductoModificadorId { get; set; }
        public ProductoModificador ProductoModificador { get; set; }
        public string Descripcion { get; set; }
    }
}
