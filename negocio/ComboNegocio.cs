using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace negocio
{
    public class ComboNegocio
    {
        public List<Combo> listar()
        {
            List<Combo> lista = new List<Combo>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT Id, Nombre, Descripcion, Activo FROM Combos");

                datos.ejecutarLectura();

                while (datos.Lectorbd.Read())
                {
                    int idArtBD = Convert.ToInt32(datos.Lectorbd["Id"]);

                    Combo aux = new Combo();
                    aux.Id = Convert.ToInt32(datos.Lectorbd["Id"]);
                    aux.Nombre = Convert.ToString(datos.Lectorbd["Nombre"]);
                    aux.Descripcion = Convert.ToString(datos.Lectorbd["Descripcion"]);
                    aux.Activo = Convert.ToBoolean(datos.Lectorbd["Activo"]);
                    
                    lista.Add(aux);
                }
                return lista;
            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void cambiarEstadoCombo(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta(
                    "UPDATE Combos SET Activo = CASE WHEN Activo = 1 THEN 0 ELSE 1 END WHERE Id = @Id");
                datos.setearParametro("@Id", id);
                datos.ejecutarAccion();
            }
            catch (Exception ex) 
            {

                throw ex; 
            }
            finally 
            { 
                datos.cerrarConexion(); 
            }
        }
    }
}
