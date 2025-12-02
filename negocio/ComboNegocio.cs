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
                    Combo aux = new Combo();
                    aux.Id = Convert.ToInt32(datos.Lectorbd["Id"]);
                    aux.Nombre = Convert.ToString(datos.Lectorbd["Nombre"]);
                    aux.Descripcion = Convert.ToString(datos.Lectorbd["Descripcion"]);
                    aux.Activo = Convert.ToBoolean(datos.Lectorbd["Activo"]);

                    lista.Add(aux);
                }

                ComboDetalleNegocio detalleNegocio = new ComboDetalleNegocio();
                foreach (var combo in lista)
                {
                    combo.Detalles = detalleNegocio.DetallesPorCombo(combo.Id);
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
                datos.setearConsulta("UPDATE Combos SET Activo = CASE WHEN Activo = 1 THEN 0 ELSE 1 END WHERE Id = @Id");
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
        public Combo obtenerPorId(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            Combo combo = new Combo();

            try
            {
                datos.setearConsulta("SELECT Id, Nombre, Descripcion, Activo FROM Combos WHERE Id = @id");
                datos.setearParametro("@id", id);
                datos.ejecutarLectura();

                if (datos.Lectorbd.Read())
                {
                    combo.Id = Convert.ToInt32(datos.Lectorbd["Id"]);
                    combo.Nombre = Convert.ToString(datos.Lectorbd["Nombre"]);
                    combo.Descripcion = Convert.ToString(datos.Lectorbd["Descripcion"]);
                    combo.Activo = Convert.ToBoolean(datos.Lectorbd["Activo"]);
                }
                return combo;
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
        public void guardar(Combo combo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                if (combo.Id == 0)
                {
                    datos.setearConsulta("INSERT INTO Combos (Nombre, Descripcion, Activo) VALUES (@nombre, @desc, 0)");
                }
                else
                {
                    datos.setearConsulta("UPDATE Combos SET Nombre = @nombre, Descripcion = @desc, Activo = 0 WHERE Id = @id");
                    datos.setearParametro("@id", combo.Id);
                }

                datos.setearParametro("@nombre", combo.Nombre);
                datos.setearParametro("@desc", combo.Descripcion);
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
        public int AgregarYDevolverId(Combo combo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("INSERT INTO Combos (Nombre, Descripcion, Activo) OUTPUT INSERTED.Id VALUES (@nombre, @desc, 0)");

                datos.setearParametro("@nombre", combo.Nombre);
                datos.setearParametro("@desc", combo.Descripcion);
                datos.setearParametro("@activo", combo.Activo);

                datos.ejecutarLectura();

                int nuevoId = 0;
                if (datos.Lectorbd.Read())
                    nuevoId = Convert.ToInt32(datos.Lectorbd[0]);

                return nuevoId;
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
