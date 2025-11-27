//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Text;
//using System.Text.RegularExpressions;
//using System.Threading.Tasks;

//namespace negocio
//{
//    public static class Validaciones
//    {        

//        public static void ValidarNombre(string nombre)
//        {
//            if (string.IsNullOrWhiteSpace(nombre))
//                throw new Exception("El nombre no puede estar vacío.");

//            if (nombre.Length < 3)
//                throw new Exception("El nombre debe tener al menos 3 caracteres.");

//            if (Regex.IsMatch(nombre, @"^\d+$"))
//                throw new Exception("El nombre no puede contener solo números.");
//        }

//        public static void ValidarContraseña(string contraseña)
//        {
//            if (string.IsNullOrWhiteSpace(contraseña))
//                throw new Exception("La contraseña no puede estar vacía.");

//            if (contraseña.Length < 3)
//                throw new Exception("La contraseña debe tener al menos 3 caracteres.");
//        }
//    }
//}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Web.UI.WebControls;

namespace negocio
{
    public static class Validaciones
    {
        public static void ValidarTextoNoVacio(string valor, string nombreCampo)
        {
            if (string.IsNullOrWhiteSpace(valor))
                throw new Exception($"El campo '{nombreCampo}' no puede estar vacío ni contener solo espacios.");
        }

        public static void ValidarNombre(string nombre)
        {
            ValidarTextoNoVacio(nombre, "Nombre");

            if (nombre.Length < 3)
                throw new Exception("El nombre debe tener al menos 3 caracteres.");

            if (Regex.IsMatch(nombre, @"^\d+$"))
                throw new Exception("El nombre no puede contener solo números.");
        }
        public static void ValidarNombreUnico(string nombre, List<string> nombresExistentes, int? idActual = null, string entidad = "elemento")
        {
            if (nombresExistentes != null && nombresExistentes.Any(n =>
                n.Trim().Equals(nombre.Trim(), StringComparison.OrdinalIgnoreCase)))
            {
                throw new Exception($"Ya existe un {entidad} con el nombre '{nombre}'.");
            }
        }

        public static void ValidarContraseña(string contraseña)
        {
            ValidarTextoNoVacio(contraseña, "Contraseña");

            if (contraseña.Length < 3)
                throw new Exception("La contraseña debe tener al menos 3 caracteres.");
        }

        public static void ValidarDropDown(DropDownList ddl, string nombreCampo)
        {
            if (ddl == null || ddl.SelectedValue == "-1" || string.IsNullOrEmpty(ddl.SelectedValue))
                throw new Exception($"Debe seleccionar una opción válida en '{nombreCampo}'.");
        }

        public static int ValidarMinutosPreparacion(string valor)
        {
            if (string.IsNullOrWhiteSpace(valor))
                return 0;

            int minutos;
            if (!int.TryParse(valor, out minutos))
                throw new Exception("Los minutos de preparación deben ser un número entero.");

            if (minutos < 0)
                throw new Exception("Los minutos no pueden ser negativos.");

            return minutos;
        }
        public static int ValidarMinutosPreparacion(TextBox textBox, string nombreCampo = "Minutos de preparación")
        {
            if (textBox == null)
                throw new Exception($"El control '{nombreCampo}' no existe.");

            return ValidarMinutosPreparacion(textBox.Text);
        }

        public static void ValidarTexto(TextBox txt, string nombreCampo)
        {
            if (txt == null || string.IsNullOrWhiteSpace(txt.Text))
                throw new Exception($"El campo '{nombreCampo}' no puede estar vacío.");
        }

        public static void ValidarTextoOpcional(TextBox txt)
        {
            if (txt == null)
                return;

            // Normalizar: si es solo espacios, dejarlo vacío
            if (string.IsNullOrWhiteSpace(txt.Text))
                txt.Text = "";
        }

        public static void ValidarCantidad(string valor, string nombreCampo)
        {
            if (!int.TryParse(valor, out int cantidad) || cantidad < 0)
                throw new Exception($"El campo '{nombreCampo}' debe ser un número entero válido.");
        }

        public static void ValidarComboTieneProductos(List<int> cantidades)
        {
            bool alguno = false;

            foreach (var c in cantidades)
                if (c > 0)
                    alguno = true;

            if (!alguno)
                throw new Exception("El combo debe tener al menos un producto con cantidad mayor a 0.");
        }
        public static void ValidarProductoTieneIngredientes(List<int> cantidades)
        {
            if (cantidades == null || !cantidades.Any() || cantidades.All(c => c == 0))
                throw new Exception("El producto debe tener al menos un ingrediente con cantidad mayor a 0.");
        }
    }

}




