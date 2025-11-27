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
        
        protected void btnToggleNotificaciones_Click(object sender, EventArgs e)
        {            
            panelNotificaciones.Visible = !panelNotificaciones.Visible;
        }
        protected void repReportes_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Resolver")
            {
                try
                {
                    int index = int.Parse(e.CommandArgument.ToString());

                    List<ReporteIngrediente> reportes =
                        (List<ReporteIngrediente>)Application["ReportesIngredientes"];

                    if (reportes != null && index >= 0 && index < reportes.Count)
                    {
                        reportes[index].Estado = "Resuelto";                       
                        Application["ReportesIngredientes"] = reportes;
                        
                        CargarReportes();
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("Error al resolver reporte: " + ex.Message);
                }
            }
        }


        private void CargarReportes()
        {
            try
            {
                List<ReporteIngrediente> reportes = new List<ReporteIngrediente>();

                if (Application["ReportesIngredientes"] != null)
                {
                    reportes = (List<ReporteIngrediente>)Application["ReportesIngredientes"];
                }
                                

                reportes = reportes
                    .OrderBy(r => r.Estado == "Resuelto" ? 1 : 0)
                    .ThenByDescending(r => r.FechaHoraReporte)
                    .ToList();
                
                int reportesPendientes = reportes.Count(r => r.Estado == "Pendiente");
                                
                lblContadorReportes.Text = reportesPendientes.ToString();
                lblContadorReportes.Visible = reportesPendientes > 0;
                                
                if (reportes.Count > 0)
                {
                    repReportes.DataSource = reportes;
                    repReportes.DataBind();
                    divSinReportes.Visible = false;
                }
                else
                {
                    repReportes.DataSource = null;
                    repReportes.DataBind();
                    divSinReportes.Visible = true;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error al cargar reportes: " + ex.Message);
                lblContadorReportes.Visible = false;
            }
        }        

        private string GenerarIdentificador()
        {
            return Guid.NewGuid().ToString("N");
        }

        private class GrupoOpcionesCombo
        {
            public int IdGrupo { get; set; }
            public string NombreGrupo { get; set; }
            public List<dominio.Producto> Productos { get; set; }
        }

        private void CargarConfiguracionCombo(int idCombo)
        {
            ComboDetalleNegocio detNeg = new ComboDetalleNegocio();
            List<ComboDetalle> detalles = detNeg.DetallesPorCombo(idCombo);

            List<GrupoOpcionesCombo> grupos = new List<GrupoOpcionesCombo>();

            foreach (var det in detalles)
            {
                if (det.Producto == null)
                    continue;

                int idGrupo = det.Producto.IdGrupo;
                if (idGrupo <= 0)
                    continue;

                var grupoExistente = grupos.FirstOrDefault(g => g.IdGrupo == idGrupo);

                //Crea grupo si no existía
                if (grupoExistente == null)
                {
                    grupoExistente = new GrupoOpcionesCombo
                    {
                        IdGrupo = idGrupo,
                        NombreGrupo = det.Producto.Grupo != null ?
                                      det.Producto.Grupo.Nombre :
                                      "Grupo " + idGrupo,
                        Productos = new List<dominio.Producto>()
                    };

                    grupos.Add(grupoExistente);
                }

                grupoExistente.Productos.Add(det.Producto);
            }

            repGruposCombo.DataSource = grupos;
            repGruposCombo.DataBind();
        }

        protected void repGruposCombo_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item &&
                e.Item.ItemType != ListItemType.AlternatingItem)
                return;

            GrupoOpcionesCombo grupo = (GrupoOpcionesCombo)e.Item.DataItem;

            RadioButtonList rbl = (RadioButtonList)e.Item.FindControl("rblOpciones");

            //Carga productos del grupo
            rbl.DataTextField = "Nombre";
            rbl.DataValueField = "Id";
            rbl.DataSource = grupo.Productos;
            rbl.DataBind();

            if (rbl.Items.Count > 0)
                rbl.SelectedIndex = 0;
        }

        public List<dominio.Combo> ListaCombos { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Verificar que el usuario esté logueado
            if (Session["Usuario"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                CargarReportes();
                ComboNegocio negocio = new ComboNegocio();
                ListaCombos = negocio.listar();
                ListaCombos = ListaCombos.Where(x => x.Activo).ToList();

                Session.Add("listaCombos", ListaCombos);
                repCombosCaja.DataSource = Session["listaCombos"];
                repCombosCaja.DataBind();

                Session["listaCombos"] = ListaCombos;
                               
                SectorNegocio sectorNeg = new SectorNegocio();
                List<Sector> sectores = sectorNeg.listar();

                repSectores.DataSource = sectores;
                repSectores.DataBind();
            }

            
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int idCombo = int.Parse(btn.CommandArgument);

            //Guarda temporalmente el Id del Combo
            hfIdComboSeleccionado.Value = idCombo.ToString();

            //Carga Grupos y Productos al Overlay
            CargarConfiguracionCombo(idCombo);

            ScriptManager.RegisterStartupScript(
                this,
                GetType(),
                "MostrarPanelCombo",
                "mostrarPanelCombo();",
                true
            );
        }

        private void CargarPedidoActual()
        {
            ProductoNegocio prodNeg = new ProductoNegocio();
            ComboNegocio comboNeg = new ComboNegocio();

            var vista = new List<dynamic>();

            foreach (var item in Carrito)
            {
                string nombre = "";
                bool esCombo = item.ComboId > 0 && item.ProductoId == 0;
                bool esProductoHijo = item.ProductoId > 0 && item.ComboId > 0;

                if (esCombo)
                {
                    var combo = comboNeg.obtenerPorId(item.ComboId);
                    
                    nombre = combo.Nombre;
                }
                else if (item.ProductoId > 0)
                {
                    var prod = prodNeg.obtenerPorId(item.ProductoId);

                    if (esProductoHijo)
                    {
                        //Producto del Combo
                        nombre = "— " + prod.Nombre;
                    }
                    else
                    {
                        //Producto suelto
                        nombre = "— " + prod.Nombre;
                    }
                }
                vista.Add(new
                {
                    Nombre = nombre,
                    Cantidad = item.Cantidad,
                    EsCombo = esCombo,
                    EsHijo = esProductoHijo,
                    Clave = item.IdentificadorUnico
                });
            }

            repPedido.DataSource = vista;
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

            //Producto
            var item = Carrito.FirstOrDefault(x => x.ProductoId == idProducto);

            Carrito.Add(new ComandaItem
            {
                ProductoId = idProducto,
                Cantidad = 1,
                Comentario = "",
                IdentificadorUnico = GenerarIdentificador(),
                ComboId = 0
            });

            CargarPedidoActual();
        }

        protected void btnConfirmarPedido_Click(object sender, EventArgs e)
        {
            if (Carrito.Count == 0)
                return;

            ComandaNegocio comNeg = new ComandaNegocio();
            ComandaItemNegocio itemNeg = new ComandaItemNegocio();

            int idUsuario = (int)Session["UsuarioId"];   
            int idEstadoInicial = 1;                     
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

        protected void btnConfirmarCombo_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(hfIdComboSeleccionado.Value))
                return;

            int idCombo = int.Parse(hfIdComboSeleccionado.Value);

            string clave = GenerarIdentificador();

            //Combo como item principal
            Carrito.Add(new ComandaItem
            {
                ComboId = idCombo,
                Cantidad = 1,
                Comentario = "",
                IdentificadorUnico = clave
            });

            //Un producto seleccionado por grupo
            foreach (RepeaterItem item in repGruposCombo.Items)
            {
                var rbl = (RadioButtonList)item.FindControl("rblOpciones");
                if (rbl != null && !string.IsNullOrEmpty(rbl.SelectedValue))
                {
                    int idProducto = int.Parse(rbl.SelectedValue);

                    Carrito.Add(new ComandaItem
                    {
                        ProductoId = idProducto,
                        Cantidad = 1,
                        Comentario = "",
                        ComboId = idCombo,
                        IdentificadorUnico = clave
                    });
                }
            }

            //Actualizar vista del carrito
            CargarPedidoActual();

            //Ocultar overlay
            ScriptManager.RegisterStartupScript(
                this,
                GetType(),
                "OcultarPanelCombo",
                "ocultarPanelCombo();",
                true
            );
        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx", false);
        }
    }
}