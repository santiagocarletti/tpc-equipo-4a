<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="IngredienteEdicion.aspx.cs" Inherits="tpc_equipo_4a.IngredienteEdicion" %>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />

    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f5f8ff;
        }

        .card {
            border: none;
            border-radius: 1rem;
            box-shadow: 0 0.75rem 1.5rem rgba(33, 150, 243, 0.1);
        }

        .card-header {
            background-color: #2196f3;
            color: #fff;
            border-radius: 1rem 1rem 0 0;
            padding: 1.25rem 1.5rem;
        }

            .card-header h5 {
                margin: 0;
                font-weight: 600;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

                .card-header h5 .material-symbols-outlined {
                    font-size: 1.4rem;
                }

        .form-label {
            font-weight: 500;
            color: #1565c0;
        }

        .form-control, .form-select {
            border-radius: 0.5rem;
            padding: 0.6rem 0.75rem;
        }

        .btn-primary {
            background-color: #2196f3;
            border-color: #2196f3;
            font-weight: 500;
        }

            .btn-primary:hover {
                background-color: #1976d2;
                border-color: #1976d2;
            }

        .btn-outline-secondary {
            border-radius: 0.5rem;
            font-weight: 500;
        }

            .btn-outline-secondary:hover {
                background-color: #bbdefb;
                color: #0d47a1;
            }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-5">
        <div class="card mx-auto" style="max-width: 600px;">
            <div class="card-header">
                <h5>
                    <span class="material-symbols-outlined">restaurant_menu</span>
                    <asp:Label ID="lblTitulo" runat="server" Text="Editar Producto"></asp:Label>
                </h5>
            </div>

            <div class="card-body bg-white">
                <div class="mb-3">
                    <label for="txtNombre" class="form-label">Nombre del producto</label>
                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Ej: Hamburguesa Doble"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label for="ddlSector" class="form-label">Sector</label>
                    <asp:DropDownList ID="ddlSector" runat="server" CssClass="form-select"></asp:DropDownList>
                </div>

                <div class="mb-3">
                    <label for="txtMinutos" class="form-label">Minutos de preparación</label>
                    <asp:TextBox ID="txtMinutos" runat="server" CssClass="form-control" TextMode="Number" placeholder="Ej: 15"></asp:TextBox>
                </div>

                <div class="d-flex justify-content-between align-items-center mt-4">
                    <a href="Ingrediente.aspx" class="btn btn-outline-secondary d-flex align-items-center">
                        <span class="material-symbols-outlined me-1">arrow_back</span> Cancelar
                    </a>

                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar cambios"
                        CssClass="btn btn-primary d-flex align-items-center"
                        OnClick="btnGuardar_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>