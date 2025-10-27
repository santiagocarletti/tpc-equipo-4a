using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
    internal class Usuario
    {
        //Propuesta: Loguearse ingresando solo contraseña
        public int Id { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string Contraseña { get; set; }
        public RolUsuario Rol { get; set; }
    }
    public enum RolUsuario
    {
        Encargado,
        Cajero,
        Planca,
        Freidora,
        Frios,
        Despacho
    }
}
