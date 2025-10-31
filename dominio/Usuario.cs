using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
    public class Usuario
    {
        
        public int Id { get; set; }
        public string NombreUsuario { get; set; }        
        public string Contraseña { get; set; }
        public bool Activo { get; set; }
        //public List<RolUsuario> Roles { get; set; } = new List<RolUsuario>();
        //Siguiente línea: Provisorio hasta ver si se tiene lista de roles o un Rol
        public RolUsuario Rol { get; set; }
    }
    
}
