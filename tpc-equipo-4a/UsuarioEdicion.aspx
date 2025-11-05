<%@ Page Title="Edición de Usuario - Burger Joint" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="UsuarioEdicion.aspx.cs" Inherits="tpc_equipo_4a.UsuarioEdicion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Edición de Usuario - Equipo 4A
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />

    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f9fa;
        }

        .card {
            border: none;
            border-radius: 1rem;
            box-shadow: 0 0.75rem 1.5rem rgba(0, 0, 0, 0.08);
        }

        .card-header {
            background-color: #fff;
            border-bottom: 1px solid #dee2e6;
            padding: 1.25rem 1.5rem;
        }

            .card-header h5 {
                margin: 0;
                font-weight: 600;
                color: #212529;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

                .card-header h5 .material-symbols-outlined {
                    font-size: 1.4rem;
                    color: #004d40;
                }

        label.form-label {
            font-weight: 500;
            color: #495057;
        }

        .form-control, .form-select {
            border-radius: 0.5rem;
            padding: 0.6rem 0.75rem;
        }

        .btn-success {
            background-color: #004d40;
            border-color: #004d40;
        }

            .btn-success:hover {
                background-color: #00382e;
                border-color: #00332a;
            }

        .btn-outline-secondary:hover {
            background-color: #6c757d;
            color: #fff;
        }

        .container {
            max-width: 600px;
        }

        .btn i, .btn .material-symbols-outlined {
            vertical-align: middle;
            font-size: 1.2rem;
        }

        .breadcrumb {
            background: none;
            padding: 0;
        }

        .breadcrumb-item + .breadcrumb-item::before {
            color: #6c757d;
        }

        .breadcrumb-item a {
            text-decoration: none;
            color: #004d40;
        }

        .breadcrumb-item.active {
            color: #6c757d;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container py-5">        
        <div class="card mx-auto">
            <div class="card-header">
                <h5>
                    <span class="material-symbols-outlined">edit</span>
                    <asp:Label ID="lblTitulo" runat="server" Text="Editar Usuario"></asp:Label>
                </h5>
            </div>

            <div class="card-body">
                <div class="mb-3">
                    <label for="txtNombreUsuario" class="form-label">Nombre de Usuario</label>
                    <asp:TextBox ID="txtNombreUsuario" runat="server" CssClass="form-control" placeholder="Ingrese el nombre del usuario"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label for="ddlRol" class="form-label">Rol</label>
                    <asp:DropDownList ID="ddlRol" runat="server" CssClass="form-select"></asp:DropDownList>
                </div>

                <div class="mb-3">
                    <label for="txtContraseña" class="form-label">Contraseña</label>
                    <asp:TextBox ID="txtContraseña" runat="server" CssClass="form-control" TextMode="Password" placeholder="Ingrese la nueva contraseña"></asp:TextBox>
                </div>

                <div class="d-flex justify-content-between align-items-center mt-4">
                    <a href="Usuario.aspx" class="btn btn-outline-secondary d-flex align-items-center">
                        <span class="material-symbols-outlined me-1">arrow_back</span> Cancelar
                    </a>
                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar cambios"
                        CssClass="btn btn-success d-flex align-items-center"
                        OnClick="btnGuardar_Click" />
                </div>
            </div>
        </div>
    </div>

</asp:Content>

