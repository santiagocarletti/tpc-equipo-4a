<%@ Page Title="Gestión de Usuarios - Equipo 4A" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Usuario.aspx.cs" Inherits="tpc_equipo_4a.Usuario" %>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />

    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #ECEFF1;
            color: #424242;
        }

        .main-content {
            padding-top: 2rem;
            padding-bottom: 2rem;
        }

        h1.h2 {
            font-weight: 700;
            color: #424242;
        }

        .card {
            border: none;
            border-radius: 1rem;
            box-shadow: 0 0.75rem 1.25rem rgba(0, 0, 0, 0.08);
            overflow: hidden;
            background-color: #ffffff;
        }

        .card-header {
            background-color: #ffffff;
            border-bottom: 1px solid #CFD8DC;
            padding: 1.25rem 1.5rem;
        }

        .card-footer {
            background-color: #ffffff;
            border-top: 1px solid #CFD8DC;
        }

        .table thead th {
            font-weight: 600;
            color: #ffffff;
            background-color: #1976D2;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.03rem;
        }

        .table-hover tbody tr:hover {
            background-color: #E3F2FD;
        }

        .table td, .table th {
            vertical-align: middle;
        }

        .btn-primary {
            background-color: #2196F3;
            border-color: #2196F3;
            font-weight: 600;
            color: #fff;
            border-radius: 0.6rem;
            box-shadow: 0 4px 10px rgba(33, 150, 243, 0.3);
            transition: all 0.25s ease-in-out;
        }

            .btn-primary:hover {
                background-color: #1976D2;
                border-color: #1976D2;
                transform: translateY(-2px);
                box-shadow: 0 6px 14px rgba(25, 118, 210, 0.35);
            }

        .btn-outline-secondary {
            border-color: #1976D2;
            color: #1976D2;
            border-radius: 0.6rem;
            font-weight: 500;
        }

            .btn-outline-secondary:hover {
                background-color: #E3F2FD;
                color: #0D47A1;
            }

        .btn-action {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 38px;
            height: 38px;
            border-radius: 50%;
            transition: all 0.2s ease-in-out;
        }

        .btn-edit {
            background-color: #FFD54F;
            color: #424242;
        }

            .btn-edit:hover {
                background-color: #FFCA28;
                transform: scale(1.1);
            }

        .btn-delete {
            background-color: #EF5350;
            color: white;
        }

            .btn-delete:hover {
                background-color: #E53935;
                transform: scale(1.1);
            }

        .badge {
            font-weight: 500;
            padding: 0.45em 0.75em;
            font-size: 0.85rem;
            border-radius: 0.5rem;
        }

        .badge-success {
            background-color: #66BB6A !important;
        }

        .badge-secondary {
            background-color: #757575 !important;
        }

        .input-group-text {
            background-color: #caf0ff;
            border: none;
            color: #424242;
        }

        .form-control {
            background-color: #caf0ff;
            border: none;
            color: #757575;
        }

            .form-control::placeholder {
                color: #616161;
            }

            .form-control:focus {
                background-color: #CFD8DC;
                box-shadow: 0 0 0 0.2rem rgba(33, 150, 243, 0.25);
            }

        .fade-in {
            animation: fadeIn 0.4s ease-in-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>


    <main class="main-content container fade-in">


        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-3">
            <h1 class="h2 fw-bold d-flex align-items-center gap-2">
                <span class="material-symbols-outlined text-primary">manage_accounts</span>
                Gestión de Usuarios
            </h1>

            <asp:Button
                ID="NuevoUsuario"
                runat="server"
                CssClass="btn btn-primary d-flex align-items-center gap-1"
                Text="+ Nuevo Usuario"
                OnClick="btnNuevoUsuario_Click" />
        </div>

        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center flex-wrap gap-3">
                <div class="w-100 w-sm-auto" style="max-width: 350px;">
                    <div class="input-group input-group-sm">
                        <span class="input-group-text">
                            <span class="material-symbols-outlined">search</span>
                        </span>
                        <asp:TextBox
                            ID="txtBuscar"
                            runat="server"
                            CssClass="form-control"
                            Placeholder="Buscar usuario"
                            AutoPostBack="true"
                            OnTextChanged="txtBuscar_TextChanged" />
                    </div>
                </div>
                <div class="text-center text-md-end">
                    <div class="btn-group btn-group-sm" role="group">
                        <asp:Repeater ID="repSectores" runat="server">
                            <ItemTemplate>
                                <asp:Button ID="btnFiltrarSector" runat="server"
                                    Text='<%# Eval("Nombre") %>'
                                    CssClass="btn btn-outline-secondary"
                                    CommandArgument='<%# Eval("Id") %>'
                                    OnClick="btnFiltrarSector_Click" />
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-hover mb-0 align-middle">
                    <thead>
                        <tr>
                            <th class="ps-4">Usuario</th>
                            <th>Rol</th>
                            <th>Estado</th>
                            <th class="text-end pe-4">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>

                        <asp:Repeater ID="repUsuarios" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td class="ps-4 fw-medium"><%# Eval("NombreUsuario") %></td>
                                    <td><%# Eval("Rol") %></td>
                                    <td>
                                        <span class='badge <%# (bool)Eval("Activo") ? "badge-success" : "badge-secondary" %>'>
                                            <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
                                        </span>
                                    </td>
                                    <td class="text-end pe-3">
                                        <asp:LinkButton
                                            ID="btnEditar"
                                            runat="server"
                                            CssClass="btn btn-action btn-edit me-1"
                                            CommandArgument='<%# Eval("Id") %>'
                                            OnClick="btnEditar_Click"
                                            ToolTip="Editar Usuario">
                                            <span class="material-symbols-outlined">edit</span>
                                        </asp:LinkButton>

                                        <asp:LinkButton
                                            ID="btnCambiarEstadoUsuario"
                                            runat="server"
                                            CssClass="btn btn-action btn-delete"
                                            CommandArgument='<%# Eval("Id") %>'
                                            OnClick="btnCambiarEstadoUsuario_Click"
                                            ToolTip='<%# (bool)Eval("Activo") ? "Desactivar" : "Activar" %>'>
                                            <span class="material-symbols-outlined">
                                                <%# (bool)Eval("Activo") ? "delete" : "add" %>
                                            </span>
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>

            <div class="card-footer d-flex justify-content-between align-items-center flex-wrap gap-2 py-3">
                <a href="Encargado.aspx" class="btn btn-outline-secondary d-flex align-items-center gap-1">
                    <span class="material-symbols-outlined">arrow_back</span> Volver
                </a>
                <span class="text-muted small">Mostrando usuarios activos e inactivos.</span>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>

