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
    [Serializable]
    public class IngredienteEdicionItem
    {
        public int IdProductoIngrediente { get; set; }
        public int IdIngrediente { get; set; }
        public string Nombre { get; set; }
        public bool Incluir { get; set; }
        public bool EsOpcional { get; set; }
        public int Cantidad { get; set; }
        public bool EsDelProducto { get; set; }
    }
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
                    nombre = "— Combo " + combo.Nombre;
                }
                else if (item.ProductoId > 0)
                {
                    var prod = prodNeg.obtenerPorId(item.ProductoId);

                    if (esProductoHijo)
                        nombre = "— " + prod.Nombre;
                    else
                        nombre = "— " + prod.Nombre;
                }
                //Detalle de ingredientes
                List<string> detalle = new List<string>();
                if (item.ProductoId > 0)
                {
                    var pin = new ProductoIngredienteNegocio();
                    var ingredientesBD = pin.IngredientesPorProducto(item.ProductoId);

                    foreach (var ing in ingredientesBD)
                    {
                        string nombreIng = ing.Ingrediente.Nombre;

                        // SIN X
                        if (item.ModificadoresTexto.Any(m => m == $"Sin {nombreIng}"))
                        {
                            detalle.Add($"- Sin {nombreIng}");
                            continue;
                        }

                        //Extra (xCant.)
                        var extra = item.ModificadoresTexto
                            .FirstOrDefault(m => m.StartsWith($"Extra {nombreIng}"));

                        if (extra != null)
                        {
                            detalle.Add($"- {extra}");
                            continue;
                        }

                        //Cantidad preestablecida
                        if (item.IngredientesSeleccionados.Contains(ing.IdIngrediente))
                        {
                            detalle.Add($"- {nombreIng}");
                        }
                    }
                }
                vista.Add(new
                {
                    Nombre = nombre,
                    Cantidad = item.Cantidad,
                    EsCombo = esCombo,
                    EsHijo = esProductoHijo,
                    Clave = item.IdentificadorUnico,

                    DetalleIngredientes = string.Join("<br/>", detalle),
                    Comentario = (!esProductoHijo && !string.IsNullOrEmpty(item.Comentario)
                ? "Comentario: " + item.Comentario
                : "")

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

            // Obtener ingredientes desde DB
            var ingNeg = new ProductoIngredienteNegocio();
            var ingredientesBD = ingNeg.IngredientesPorProducto(idProducto);

            Carrito.Add(new ComandaItem
            {
                ProductoId = idProducto,
                Cantidad = 1,
                Comentario = "",
                IdentificadorUnico = GenerarIdentificador(),
                ComboId = 0,
                IngredientesSeleccionados = ingredientesBD.Select(i => i.IdIngrediente).ToList()
            });

            CargarPedidoActual();
        }
        protected void btnConfirmarPedido_Click(object sender, EventArgs e)
        {
            if (Carrito.Count == 0)
                return;

            ComandaNegocio comNeg = new ComandaNegocio();
            ComandaItemNegocio itemNeg = new ComandaItemNegocio();
            ComandaItemModificadorNegocio modNeg = new ComandaItemModificadorNegocio();

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

                //Guarda item y recupera el Id insertado
                int idItem = itemNeg.AgregarYDevolverId(item);
                item.Id = idItem;

                //Guardar Modificadores, si existen
                if (item.ModificadoresTexto != null)
                {
                    foreach (var texto in item.ModificadoresTexto)
                    {
                        modNeg.Agregar(new ComandaItemModificador
                        {
                            IdComandaItem = idItem,
                            Descripcion = texto
                        });
                    }
                }
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

            //Clave única del Combo padre
            string clavePadre = GenerarIdentificador();

            //Agregar Combo principal
            Carrito.Add(new ComandaItem
            {
                ComboId = idCombo,
                Cantidad = 1,
                Comentario = "",
                IdentificadorUnico = clavePadre
            });

            //Agregar productos hijos (cada uno con su propia clave)
            foreach (RepeaterItem item in repGruposCombo.Items)
            {
                var rbl = (RadioButtonList)item.FindControl("rblOpciones");
                if (rbl != null && !string.IsNullOrEmpty(rbl.SelectedValue))
                {
                    int idProducto = int.Parse(rbl.SelectedValue);

                    var ingNeg = new ProductoIngredienteNegocio();
                    var ingredientesBD = ingNeg.IngredientesPorProducto(idProducto);

                    Carrito.Add(new ComandaItem
                    {
                        ProductoId = idProducto,
                        Cantidad = 1,
                        Comentario = "",
                        ComboId = idCombo,
                        IdentificadorUnico = GenerarIdentificador(),
                        IdentificadorPadre = clavePadre,
                        IngredientesSeleccionados = ingredientesBD.Select(i => i.IdIngrediente).ToList()
                    });
                }
            }
            //Refrescar vista
            CargarPedidoActual();

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
        protected void btnEditarItem_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string clave = btn.CommandArgument;

            hfItemEnEdicion.Value = clave;

            var item = Carrito.FirstOrDefault(x => x.IdentificadorUnico == clave);
            if (item == null)
                return;

            //Combo padre sin Ingredientes
            if (item.ComboId > 0 && item.ProductoId == 0)
            {
                lblTituloEdicionItem.Text = "Editar combo";
                repIngredientesEdicion.DataSource = null;
                repIngredientesEdicion.DataBind();
                txtComentarioEdicion.Text = item.Comentario;
            }
            else
            {
                //Producto suelto o hijo
                var prodNeg = new ProductoNegocio();
                var prod = prodNeg.obtenerPorId(item.ProductoId);

                lblTituloEdicionItem.Text = "Editar: " + prod.Nombre;

                //Ingredientes del Producto por defecto
                var ingNeg = new ProductoIngredienteNegocio();
                var ingredientesBD = ingNeg.IngredientesPorProducto(item.ProductoId);

                //Lista final
                List<IngredienteEdicionItem> lista = new List<IngredienteEdicionItem>();

                foreach (var ing in ingredientesBD)
                {
                    int cantidad = 1;
                    //Por defecto
                    bool incluir = true;
                    //Por defecto

                    string nombre = ing.Ingrediente.Nombre;

                    //Buscar 'Sin X'
                    if (item.ModificadoresTexto.Any(m => m == $"Sin {nombre}"))
                    {
                        incluir = false;
                        cantidad = 0;
                    }

                    //Buscar 'Extra X (xCant.)' o 'Extra X'
                    var extra = item.ModificadoresTexto
                                    .FirstOrDefault(m => m.StartsWith($"Extra {nombre}"));

                    //Si existe un Extra
                    if (extra != null)
                    {
                        incluir = true;

                        int pos1 = extra.IndexOf("(x");
                        int pos2 = extra.IndexOf(")");

                        if (pos1 >= 0 && pos2 > pos1)
                        {
                            string num = extra.Substring(pos1 + 2, pos2 - (pos1 + 2));

                            if (int.TryParse(num, out int n) && n > 1)
                                cantidad = n;
                            else
                                cantidad = 2;
                        }
                        else
                        {
                            cantidad = 2;
                        }
                    }
                    //Si el cajero modificó IngredientesSeleccionados
                    if (item.IngredientesSeleccionados != null)
                    {
                        incluir = item.IngredientesSeleccionados.Contains(ing.IdIngrediente);
                        if (!incluir)
                            cantidad = 0;
                    }

                    lista.Add(new IngredienteEdicionItem
                    {
                        IdProductoIngrediente = ing.Id,
                        IdIngrediente = ing.IdIngrediente,
                        Nombre = nombre,
                        EsOpcional = ing.EsOpcional,
                        EsDelProducto = true,
                        Incluir = incluir,
                        Cantidad = cantidad
                    });
                }

                repIngredientesEdicion.DataSource = lista;
                repIngredientesEdicion.DataBind();

                txtComentarioEdicion.Text = item.Comentario;
            }

            //Si es hijo de un Combo, sin comentario
            bool esHijoCombo = item.ComboId > 0 && item.ProductoId > 0;
            divComentarioEdicion.Visible = !esHijoCombo;

            ScriptManager.RegisterStartupScript(this, GetType(),
                "MostrarPanelEdicion", "mostrarPanelEdicion();", true);
        }
        protected void btnGuardarEdicion_Click(object sender, EventArgs e)
        {
            string clave = hfItemEnEdicion.Value;
            var item = Carrito.FirstOrDefault(x => x.IdentificadorUnico == clave);
            if (item == null)
                return;

            item.Comentario = txtComentarioEdicion.Text.Trim();

            item.IngredientesSeleccionados.Clear();
            item.ModificadoresTexto.Clear();
            item.CantidadesIngredientes.Clear();

            foreach (RepeaterItem repItem in repIngredientesEdicion.Items)
            {
                var hf = (HiddenField)repItem.FindControl("hfIdIngrediente");
                var lbl = (Label)repItem.FindControl("lblNombreIngrediente");
                var txtCant = (TextBox)repItem.FindControl("txtCantidadIng");

                int idIng = int.Parse(hf.Value);
                string nombreIng = lbl.Text;

                int cant = 1;
                int.TryParse(txtCant.Text, out cant);

                //0: Sin X Ingrediente
                if (cant == 0)
                {
                    item.CantidadesIngredientes[idIng] = 0;
                    item.ModificadoresTexto.Add("Sin " + nombreIng);
                    continue;
                }

                //>= 1
                item.IngredientesSeleccionados.Add(idIng);
                item.CantidadesIngredientes[idIng] = cant;

                //Cantidad por defecto
                if (cant == 1)
                    continue;

                //Extra
                item.ModificadoresTexto.Add($"Extra {nombreIng} (x{cant})");
            }

            CargarPedidoActual();

            ScriptManager.RegisterStartupScript(
                this, GetType(),
                "OcultarEdicion", "ocultarPanelEdicion();", true
            );
        }
        protected void btnEliminarItem_Click(object sender, EventArgs e)
        {
            var btn = (Button)sender;
            string clave = btn.CommandArgument;

            var carrito = Carrito;

            var item = carrito.FirstOrDefault(x => x.IdentificadorUnico == clave);
            if (item == null) return;

            //Si es Combo, borra sus hijos
            if (item.ComboId > 0 && item.ProductoId == 0)
            {
                carrito.Remove(item);

                carrito.RemoveAll(x => x.IdentificadorPadre == clave);
            }
            else
            {
                //Producto suelto o hijo
                carrito.Remove(item);
            }

            CargarPedidoActual();
        }
    }
}