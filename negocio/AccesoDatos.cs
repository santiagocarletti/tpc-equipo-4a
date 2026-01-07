using dominio;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace negocio
{
    public class AccesoDatos
    {
        private SqlConnection conexionbd;
        private SqlCommand comando;
        private SqlDataReader lector;

        public SqlDataReader Lectorbd
        {
            get { return lector; }
        }
        public AccesoDatos()
        {
            conexionbd = new SqlConnection("server=.\\SQLEXPRESS; database=COCINA_DB_V515; integrated security=true");
            comando = new SqlCommand();
        }
        public void setearConsulta(string consulta)
        {
            comando.CommandType = System.Data.CommandType.Text;
            comando.CommandText = consulta;
        }
        public void ejecutarLectura()
        {
            comando.Connection = conexionbd;
            try
            {
                conexionbd.Open();
                lector = comando.ExecuteReader();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void setearParametro(string nombre, object valor)
        {
            comando.Parameters.AddWithValue(nombre, valor);
        }
        public void cerrarConexion()
        {
            if (lector != null)
                lector.Close();
            conexionbd.Close();
        }
        public void ejecutarAccion()
        {
            comando.Connection = conexionbd;
            try
            {
                conexionbd.Open();
                comando.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public int ejecutarAccionConReturn()
        {
            comando.Connection = conexionbd;
            try
            {
                conexionbd.Open();
                return int.Parse(comando.ExecuteScalar().ToString());
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void limpiarParametros()
        {
            comando.Parameters.Clear();
        }
        public void ejecutarMasAcciones()
        {
            try
            {
                comando.Connection = conexionbd;
                comando.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
