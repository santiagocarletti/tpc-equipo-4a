using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace negocio
{
    public static class Validaciones
    {        
                       
        public static void ValidarNombre(string nombre)
        {
            if (string.IsNullOrWhiteSpace(nombre))
                throw new Exception("El nombre no puede estar vacío.");

            if (nombre.Length < 3)
                throw new Exception("El nombre debe tener al menos 3 caracteres.");
                       
            if (Regex.IsMatch(nombre, @"^\d+$"))
                throw new Exception("El nombre no puede contener solo números.");
        }

        public static void ValidarContraseña(string contraseña)
        {
            if (string.IsNullOrWhiteSpace(contraseña))
                throw new Exception("La contraseña no puede estar vacía.");

            if (contraseña.Length < 3)
                throw new Exception("La contraseña debe tener al menos 3 caracteres.");
        }
    }
}
