using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace negocio
{
    public class SectorNegocio
    {
        public List<Sector> listar()
        {
            List<Sector> lista = new List<Sector>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT Id, Nombre FROM Sectores");

                datos.ejecutarLectura();

                while (datos.Lectorbd.Read())
                {
                    int idSecotrBD = Convert.ToInt32(datos.Lectorbd["Id"]);

                    Sector aux = new Sector();
                    aux.Id = Convert.ToInt32(datos.Lectorbd["Id"]);
                    aux.Nombre = Convert.ToString(datos.Lectorbd["Nombre"]);
                    
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
    }
}
