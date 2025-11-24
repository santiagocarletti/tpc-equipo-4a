using dominio;
using negocio;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace tpc_equipo_4a
{
    public partial class Cajero : System.Web.UI.Page
    {
        public List<dominio.Combo> ListaCombos { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            var user = (dominio.Usuario)Session["Usuario"];
            Seguridad.ValidarAcceso(user, this);

            if (!IsPostBack)
            {
                ComboNegocio negocio = new ComboNegocio();
                ListaCombos = negocio.listar();
                ListaCombos = ListaCombos.Where(x => x.Activo).ToList();

                Session.Add("listaCombos", ListaCombos);
                repCombosCaja.DataSource = Session["listaCombos"];
                repCombosCaja.DataBind();

                Session["listaCombos"] = ListaCombos;

                //BOTONES SECTORES
                SectorNegocio sectorNeg = new SectorNegocio();
                List<Sector> sectores = sectorNeg.listar();

                repSectores.DataSource = sectores;
                repSectores.DataBind();
                //
            }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int idCombo = int.Parse(btn.CommandArgument);

            //Combo
            var item = Carrito.FirstOrDefault(x => x.ComboId == idCombo);

            if (item == null)
            {
                Carrito.Add(new ComandaItem
                {
                    ComboId = idCombo,
                    Cantidad = 1,
                    Comentario = ""
                });
            }
            else
            {
                item.Cantidad++;
            }

            CargarPedidoActual();
        }
        private void CargarPedidoActual()
        {
            //Vincular combo/producto para obtener nombre
            var mostrar = new List<dynamic>();

            ProductoNegocio prodNeg = new ProductoNegocio();
            ComboNegocio comboNeg = new ComboNegocio();

            foreach (var item in Carrito)
            {
                string nombre = "";

                if (item.ComboId > 0)
                    nombre = comboNeg.obtenerPorId(item.ComboId).Nombre;

                if (item.ProductoId > 0)
                    nombre = prodNeg.obtenerPorId(item.ProductoId).Nombre;

                mostrar.Add(new
                {
                    IdTemp = item.GetHashCode(), //Id virtual para manejar botones
                    Nombre = nombre,
                    Cantidad = item.Cantidad
                });
            }

            repPedido.DataSource = mostrar;
            repPedido.DataBind();
        }
        protected void btnCatCombos_Click(object sender, EventArgs e)
        {
            panelCombos.Visible = true;
            panelProductosSectores.Visible = false;
        }
        public List<dominio.Producto> ListaProductos { get; set; }
        protected void btnSector_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int idSector = int.Parse(btn.CommandArgument);

            panelCombos.Visible = false;
            panelProductosSectores.Visible = true;

            ProductoNegocio negocio = new ProductoNegocio();
            repProductosCaja.DataSource = negocio.listar(idSector);
            repProductosCaja.DataBind();
        }
        private List<ComandaItem> Carrito
        {
            get
            {
                if (Session["Carrito"] == null)
                    Session["Carrito"] = new List<ComandaItem>();
                return (List<ComandaItem>)Session["Carrito"];
            }
        }
        protected void btnAgregarProd_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int idProducto = int.Parse(btn.CommandArgument);

            // Producto
            var item = Carrito.FirstOrDefault(x => x.ProductoId == idProducto);

            if (item == null)
            {
                Carrito.Add(new ComandaItem
                {
                    ProductoId = idProducto,
                    Cantidad = 1,
                    Comentario = ""
                });
            }
            else
            {
                item.Cantidad++;
            }

            CargarPedidoActual();
        }
        private void MostrarPedidoActual()
        {
            if (Session["PedidoActual"] == null)
                return;

            var lista = (List<ComandaItem>)Session["PedidoActual"];

            //repPedidoActual.DataSource = lista;
            //repPedidoActual.DataBind();
        }

        protected void btnConfirmarPedido_Click(object sender, EventArgs e)
        {
            if (Carrito.Count == 0)
                return;

            ComandaNegocio comNeg = new ComandaNegocio();
            ComandaItemNegocio itemNeg = new ComandaItemNegocio();

            int idUsuario = (int)Session["UsuarioId"];   //Manejo provisorio en PageLoad
            int idEstadoInicial = 1;                     //Manejo provisorio en AgregarYDevolverId
            string numComanda = GenerarNumeroComanda();

            //Crear Comanda
            Comanda com = new Comanda
            {
                NumeroComanda = numComanda,
                FechaCreacion = DateTime.Now,
                EstadoId = idEstadoInicial,
                UsuarioId = idUsuario
            };

            int idComanda = comNeg.AgregarYDevolverId(com);

            //Guardar Items
            foreach (var item in Carrito)
            {
                item.ComandaId = idComanda;

                itemNeg.Agregar(item);
            }

            //Limpiar carrito
            Session["Carrito"] = null;

            Response.Redirect("Cajero.aspx");
        }
        private string GenerarNumeroComanda()
        {
            return DateTime.Now.ToString("HHmmss");
        }
    }
}