<%@ Page Title="Edición de Usuario - Equipo 4A" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="UsuarioEdicion.aspx.cs" Inherits="tpc_equipo_4a.UsuarioEdicion" %>

<asp:Content ID="Content4" ContentPlaceHolderID="TitleContent" runat="server">
    Edición de Usuario - Equipo 4A
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />

    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #ECEFF1;
        }

        .fade-in {
            animation: fadeIn 0.5s ease-out forwards;
        }

        @keyframes fadeIn {
            0% {
                opacity: 0;
                transform: translateY(10px);
            }

            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .card {
            background-color: #ffffff;
            border: none;
            border-radius: 1rem;
            box-shadow: 0 1rem 2rem rgba(0, 0, 0, 0.1);
            max-width: 600px;
        }

        .card-header {
            background-color: transparent;
            border-bottom: none;
            text-align: center;
            padding-top: 2rem;
        }

            .card-header .material-symbols-outlined {
                font-size: 3rem;
                color: #424242;
            }

            .card-header h5 {
                margin-top: 0.5rem;
                font-size: 1.8rem;
                font-weight: 700;
                color: #424242;
            }

        label.form-label {
            font-weight: 500;
            color: #424242;
        }

        .form-control, .form-select {
            border-radius: 0.75rem;
            border: 1px solid #cfd8dc;
            padding: 0.75rem 1rem;
            background-color: #f8f9fa;
            color: #424242;
            transition: all 0.2s ease-in-out;
        }

            .form-control:focus, .form-select:focus {
                border-color: #2196F3;
                box-shadow: 0 0 0 0.25rem rgba(33, 150, 243, 0.25);
            }

        .btn-primary {
            background-color: #2196F3;
            border-color: #2196F3;
            color: #fff;
            font-weight: 600;
            border-radius: 0.75rem;
            padding: 0.6rem 1.5rem;
            transition: all 0.3s ease-in-out;
        }

            .btn-primary:hover {
                background-color: #1976D2;
                border-color: #1976D2;
                transform: translateY(-1px);
                box-shadow: 0 6px 16px rgba(25, 118, 210, 0.3);
            }

        .btn-outline-secondary {
            border-radius: 0.75rem;
            border-color: #1976D2;
            color: #1976D2;
            font-weight: 600;
            padding: 0.6rem 1.2rem;
            transition: all 0.3s ease-in-out;
        }

            .btn-outline-secondary:hover {
                background-color: #E3F2FD;
                color: #0D47A1;
            }

        .btn .material-symbols-outlined {
            vertical-align: middle;
            font-size: 1.3rem;
        }

        .card-footer {
            border-top: 1px solid #CFD8DC;
            background-color: #fff;
            padding: 1rem 1.5rem;
        }

        .text-muted {
            color: #757575 !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content6" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-5 fade-in d-flex justify-content-center align-items-center" style="min-height: 80vh;">
        <div class="card w-100">
            <div class="card-header">
                <span class="material-symbols-outlined">person_add</span>
                <h5>
                    <asp:Label ID="Label1" runat="server" Text="Agregar / Editar Usuario"></asp:Label></h5>
            </div>

            <div class="card-body px-5 py-4">
                <div class="mb-3">
                    <label for="txtNombreUsuario" class="form-label">Nombre de Usuario</label>
                    <asp:TextBox ID="txtNombreUsuario" runat="server" CssClass="form-control" placeholder="Ingrese el nombre del usuario"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label for="txtContraseña" class="form-label">Contraseña</label>
                    <%--<asp:TextBox ID="txtContraseña" runat="server" CssClass="form-control" TextMode="Password" placeholder="Ingrese la nueva contraseña"></asp:TextBox>--%>
                    <asp:TextBox ID="txtContraseña" runat="server" CssClass="form-control" placeholder="Ingrese la nueva contraseña"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label for="ddlRol" class="form-label">Rol</label>
                    <asp:DropDownList ID="ddlRol" runat="server" CssClass="form-select"></asp:DropDownList>
                </div>
            </div>

            <div class="card-footer d-flex justify-content-between align-items-center">
                <a href="Usuario.aspx" class="btn btn-outline-secondary d-flex align-items-center">
                    <span class="material-symbols-outlined me-1">arrow_back</span> Cancelar
                </a>
                <asp:Button
                    ID="Button1"
                    runat="server"
                    Text="Aceptar"
                    CssClass="btn btn-primary d-flex align-items-center gap-1"
                    OnClick="btnGuardar_Click" />

            </div>
        </div>
    </div>
</asp:Content>

