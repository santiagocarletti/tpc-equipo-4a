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
        public int ComandaId { get; set; }
        public Comanda Comanda { get; set; }

        public int ProductoId { get; set; }
        public Producto Producto { get; set; }

        public int ComboId { get; set; }
        public Combo Combo { get; set; }

        public int Cantidad { get; set; }
        public string Comentario { get; set; } //bien cocido, sal aparte,etc.

        //modificaciones
        public List<ComandaItemModificador> Modificadores { get; set; } = new List<ComandaItemModificador>();
        //Para carrito
        public string IdentificadorUnico { get; set; }
        //Para edición en Caja
        public List<int> IngredientesSeleccionados { get; set; } = new List<int>();
        //Para agrupar hijos con su combo
        public string IdentificadorPadre { get; set; }
        //Para ComandaItemModificadores
        public List<string> ModificadoresTexto { get; set; } = new List<string>();
        //Para persistir en el editor de Caja, las modificaciones antes de guardar en BD
        public Dictionary<int, int> CantidadesIngredientes { get; set; } = new Dictionary<int, int>();

    }
}
