using dominio;
using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;

namespace tpc_equipo_4a
{
    public partial class IngredienteEdicion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    CargarDropdownSector();

                    if (Session["IngredienteId"] != null)
                    {
                        lblTitulo.Text = "Editar Ingrediente";

                        IngredienteNegocio negocio = new IngredienteNegocio();
                        int id = (int)Session["IngredienteId"];
                        dominio.Ingrediente ing = negocio.obtenerPorId(id);

                        if (ing != null)
                        {
                            txtNombre.Text = ing.Nombre;
                            txtMinutos.Text = ing.MinutosPreparacion.ToString();
                            ddlSector.SelectedValue = ing.IdSector.ToString();
                        }
                    }
                    else
                    {
                        lblTitulo.Text = "Nuevo Ingrediente";
                    }
                }
                catch (Exception ex)
                {
                    MostrarError("Error al cargar la página: " + ex.Message);
                }
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {

                Validaciones.ValidarTexto(txtNombre, "Nombre del ingrediente");
                Validaciones.ValidarNombre(txtNombre.Text.Trim());
                Validaciones.ValidarDropDown(ddlSector, "Sector");
                int minutosPreparacion = Validaciones.ValidarMinutosPreparacion(txtMinutos);

                // 5. Validar que el nombre no se repita
                IngredienteNegocio negocio = new IngredienteNegocio();
                List<dominio.Ingrediente> ingredientes = negocio.listar();

                int? idActual = null;
                if (Session["IngredienteId"] != null)
                    idActual = (int)Session["IngredienteId"];

                List<string> nombresExistentes = ingredientes
                    .Where(i => !idActual.HasValue || i.Id != idActual.Value)
                    .Select(i => i.Nombre)
                    .ToList();

                Validaciones.ValidarNombreUnico(
                    txtNombre.Text.Trim(),
                    nombresExistentes,
                    idActual,
                    "ingrediente"
                );


                dominio.Ingrediente ing = new dominio.Ingrediente
                {
                    Nombre = txtNombre.Text.Trim(),
                    MinutosPreparacion = minutosPreparacion,
                    IdSector = int.Parse(ddlSector.SelectedValue),
                    Activo = true
                };

               
                if (idActual.HasValue)
                    ing.Id = idActual.Value;

                negocio.guardar(ing);

                
                Session.Remove("IngredienteId");
                Response.Redirect("Ingrediente.aspx");
            }
            catch (Exception ex)
            {
                MostrarError(ex.Message);
            }
        }

        private void CargarDropdownSector()
        {
            try
            {
                SectorNegocio secNegocio = new SectorNegocio();
                List<Sector> sectores = secNegocio.listar();

                ddlSector.DataSource = sectores;
                ddlSector.DataTextField = "Nombre";
                ddlSector.DataValueField = "Id";
                ddlSector.DataBind();

                // Agregar opción por defecto al inicio
                ddlSector.Items.Insert(0, new ListItem("-- Seleccione Sector --", "-1"));
            }
            catch (Exception ex)
            {
                MostrarError("Error al cargar sectores: " + ex.Message);
            }
        }

        private void MostrarError(string mensaje)
        {
            errorText.InnerText = mensaje;
            errorMsg.Visible = true;
        }
    }
}