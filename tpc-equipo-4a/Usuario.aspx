<%@ Page Title="Gestión de Usuarios - Burger Joint" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Usuario.aspx.cs" Inherits="tpc_equipo_4a.Usuario" %>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />

    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f9fa;
        }

        .main-content {
            padding-top: 2rem;
            padding-bottom: 2rem;
        }

        h1.h2 {
            color: #212529;
            font-weight: 700;
        }

        .card {
            border: none;
            border-radius: 1rem;
            box-shadow: 0 0.75rem 1.5rem rgba(0, 0, 0, 0.06);
            overflow: hidden;
        }

        .card-header {
            background-color: #fff;
            border-bottom: 1px solid #dee2e6;
            padding: 1rem 1.5rem;
        }

        .card-footer {
            border-top: 1px solid #dee2e6;
        }

        .table thead th {
            font-weight: 600;
            color: #6c757d;
            text-transform: uppercase;
            font-size: 0.85rem;
            background-color: #fafafa;
            letter-spacing: 0.02rem;
        }

        .table-hover tbody tr:hover {
            background-color: #f1fdf9;
        }

        .table td, .table th {
            vertical-align: middle;
        }

        .btn-success {
            background-color: #004d40;
            border-color: #004d40;
            color: #fff;
            font-weight: 500;
            border-radius: 0.5rem;
            transition: all 0.2s ease-in-out;
        }

            .btn-success:hover {
                background-color: #00382e;
                transform: translateY(-1px);
            }

        .btn-outline-secondary {
            border-radius: 0.5rem;
            font-weight: 500;
        }

            .btn-outline-secondary:hover {
                background-color: #6c757d;
                color: #fff;
            }

        .btn-action {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 38px;
            height: 38px;
            border-radius: 50%;
            border: 1px solid transparent;
            transition: all 0.2s ease-in-out;
        }

        .btn-action-edit {
            background-color: #e0f2f1;
            color: #004d40;
        }

            .btn-action-edit:hover {
                background-color: #b2dfdb;
                color: #00382e;
                transform: scale(1.05);
            }

        .btn-action-delete {
            background-color: #ffebee;
            color: #c62828;
        }

            .btn-action-delete:hover {
                background-color: #ffcdd2;
                color: #b71c1c;
                transform: scale(1.05);
            }

        .btn-action .material-symbols-outlined {
            font-size: 1.25rem;
            line-height: 1;
        }

        .badge.bg-success {
            background-color: #004d40 !important;
        }

        .badge {
            font-weight: 500;
            padding: 0.45em 0.7em;
            font-size: 0.85rem;
        }

        .input-group-text {
            border-radius: 0.5rem 0 0 0.5rem !important;
        }

        .form-control {
            border-radius: 0 0.5rem 0.5rem 0 !important;
        }

        .card-header .btn-outline-secondary {
            font-size: 0.875rem;
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
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap">
            <h1 class="h2 fw-bold mb-0 d-flex align-items-center">
                <span class="material-symbols-outlined">manage_accounts</span>
                Gestión de Usuarios
            </h1>

            <asp:Button
                ID="NuevoUsuario"
                runat="server"
                CssClass="btn btn-success d-flex align-items-center"
                Text="+ Nuevo Usuario"
                OnClick="btnNuevoUsuario_Click" />
        </div>

        <div class="card">
            <div class="card-header bg-white border-0 pb-0">
                <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3">

                    
                    <div class="flex-grow-1" style="max-width: 350px;">
                        <div class="input-group input-group-sm shadow-sm rounded">
                            <span class="input-group-text bg-white border-end-0">
                                <span class="material-symbols-outlined text-muted" style="font-size: 1.25rem;">search</span>
                            </span>
                            <asp:TextBox
                                ID="txtBuscar"
                                runat="server"
                                CssClass="form-control border-start-0"
                                Placeholder="Buscar usuario..."
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
                                    <td class="ps-4">
                                        <div class="fw-medium"><%# Eval("NombreUsuario") %></div>
                                    </td>
                                    <td><%# Eval("Rol") %></td>
                                    <td>
                                        <span class='badge rounded-pill <%# (bool)Eval("Activo") ? "bg-success" : "bg-secondary" %>'>
                                            <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
                                        </span>
                                    </td>
                                    <td class="text-end pe-3">
                                        <asp:LinkButton
                                            ID="btnEditar"
                                            runat="server"
                                            CssClass="btn btn-action btn-action-edit me-1"
                                            CommandArgument='<%# Eval("Id") %>'
                                            OnClick="btnEditar_Click"
                                            ToolTip="Editar Usuario">
                                            <span class="material-symbols-outlined">edit</span>
                                        </asp:LinkButton>

                                        <asp:LinkButton
                                            ID="btnCambiarEstadoUsuario"
                                            runat="server"
                                            CssClass='<%# "btn btn-action " + ((bool)Eval("Activo") ? "btn-action-delete" : "btn-action-edit") %>'
                                            CommandArgument='<%# Eval("Id") %>'
                                            OnClick="btnCambiarEstadoUsuario_Click"
                                            ToolTip='<%# (bool)Eval("Activo") ? "Desactivar" : "Activar" %>'>
                                        <span class="material-symbols-outlined">
                                            <%# (bool)Eval("Activo") ? "delete" : "check" %>
                                        </span>
                                        </asp:LinkButton>

                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>

            <div class="card-footer bg-white d-flex justify-content-between align-items-center py-3">
                <a href="Encargado.aspx" class="btn btn-outline-secondary d-flex align-items-center">
                    <span class="material-symbols-outlined me-1">arrow_back</span> Volver
                </a>
                <span class="text-muted small d-none d-sm-block">Mostrando usuarios activos e inactivos</span>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>


<%--<%@ Page Title="Gestión de Usuarios - Burger Joint" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Usuario.aspx.cs" Inherits="tpc_equipo_4a.Usuario" %>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />

    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f5f7f8;
        }

        .main-content {
            padding-top: 2rem;
            padding-bottom: 2rem;
        }

        h1.h2 {
            color: #212529;
            font-weight: 700;
        }

        .card {
            border: none;
            border-radius: 1rem;
            box-shadow: 0 0.75rem 1.5rem rgba(0, 0, 0, 0.06);
            overflow: hidden;
            transition: box-shadow 0.3s ease;
        }

            .card:hover {
                box-shadow: 0 1rem 2rem rgba(0, 0, 0, 0.08);
            }

        .card-header {
            background-color: #fff;
            border-bottom: 1px solid #dee2e6;
            padding: 1rem 1.5rem;
            position: sticky;
            top: 0;
            z-index: 10;
        }

        .table thead th {
            font-weight: 600;
            color: #6c757d;
            text-transform: uppercase;
            font-size: 0.85rem;
            background-color: #f9fafb;
            letter-spacing: 0.02rem;
        }

        .table-hover tbody tr:hover {
            background-color: #e8f5e9;
        }

        .btn-success {
            background-color: #00796b;
            border-color: #00796b;
            color: #fff;
            font-weight: 500;
            border-radius: 0.6rem;
            transition: all 0.25s ease-in-out;
        }

            .btn-success:hover {
                background-color: #004d40;
                transform: translateY(-1px);
            }

        .btn-outline-secondary {
            border-radius: 0.5rem;
            font-weight: 500;
            transition: all 0.25s ease;
        }

            .btn-outline-secondary.active {
                background-color: #00796b;
                color: #fff;
                border-color: #00796b;
            }

            .btn-outline-secondary:hover {
                background-color: #6c757d;
                color: #fff;
            }

        .btn-action {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 38px;
            height: 38px;
            border-radius: 50%;
            border: 1px solid transparent;
            transition: all 0.2s ease-in-out;
        }

        .btn-action-edit {
            background-color: #e0f2f1;
            color: #004d40;
        }

            .btn-action-edit:hover {
                background-color: #b2dfdb;
                color: #00382e;
                transform: scale(1.1);
            }

        .btn-action-delete {
            background-color: #ffebee;
            color: #c62828;
        }

            .btn-action-delete:hover {
                background-color: #ffcdd2;
                color: #b71c1c;
                transform: scale(1.1);
            }

        .badge {
            font-weight: 500;
            padding: 0.45em 0.7em;
            font-size: 0.85rem;
        }

            .badge.bg-success {
                background-color: #00796b !important;
            }

            .badge.bg-secondary {
                background-color: #9e9e9e !important;
            }

        .input-group-text {
            border-radius: 0.5rem 0 0 0.5rem !important;
            background-color: #fff;
        }

        .form-control {
            border-radius: 0 0.5rem 0.5rem 0 !important;
        }

            .form-control:focus {
                box-shadow: 0 0 0 0.15rem rgba(0, 121, 107, 0.25);
                border-color: #00796b;
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
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap">
            <h1 class="h2 fw-bold mb-0 d-flex align-items-center">
                <span class="material-symbols-outlined me-2 text-success">manage_accounts</span>
                Gestión de Usuarios
            </h1>

            <asp:Button
                ID="NuevoUsuario"
                runat="server"
                CssClass="btn btn-success d-flex align-items-center gap-2"
                Text='+ Nuevo Usuario'
                OnClick="btnNuevoUsuario_Click" />
        </div>

        <div class="card">
            <div class="card-header bg-white border-0 pb-0">
                <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3">

                    <div class="flex-grow-1" style="max-width: 350px;">
                        <div class="input-group input-group-sm shadow-sm rounded">
                            <span class="input-group-text bg-white border-end-0">
                                <span class="material-symbols-outlined text-muted" style="font-size: 1.25rem;">search</span>
                            </span>
                            <asp:TextBox
                                ID="txtBuscar"
                                runat="server"
                                CssClass="form-control border-start-0"
                                Placeholder="Buscar usuario..."
                                AutoPostBack="true"
                                OnTextChanged="txtBuscar_TextChanged" />
                        </div>
                    </div>

                    <div class="text-center text-md-end">
                        <div class="btn-group btn-group-sm shadow-sm" role="group">
                            <asp:Repeater ID="repSectores" runat="server">
                                <ItemTemplate>
                                    <asp:Button
                                        ID="btnFiltrarSector"
                                        runat="server"
                                        Text='<%# Eval("Nombre") %>'
                                        CssClass="btn btn-outline-secondary"
                                        CommandArgument='<%# Eval("Id") %>'
                                        OnClick="btnFiltrarSector_Click" />
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
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
                                    <td class="ps-4 fw-medium text-dark"><%# Eval("NombreUsuario") %></td>
                                    <td><%# Eval("Rol") %></td>
                                    <td>
                                        <span class='badge rounded-pill <%# (bool)Eval("Activo") ? "bg-success" : "bg-secondary" %>'>
                                            <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
                                        </span>
                                    </td>
                                    <td class="text-end pe-3">
                                        <asp:LinkButton
                                            ID="btnEditar"
                                            runat="server"
                                            CssClass="btn btn-action btn-action-edit me-1"
                                            CommandArgument='<%# Eval("Id") %>'
                                            OnClick="btnEditar_Click"
                                            ToolTip="Editar Usuario">
                                            <span class="material-symbols-outlined">edit</span>
                                        </asp:LinkButton>

                                        <asp:LinkButton
                                            ID="btnCambiarEstadoUsuario"
                                            runat="server"
                                            CssClass='<%# "btn btn-action " + ((bool)Eval("Activo") ? "btn-action-delete" : "btn-action-edit") %>'
                                            CommandArgument='<%# Eval("Id") %>'
                                            OnClick="btnCambiarEstadoUsuario_Click"
                                            ToolTip='<%# (bool)Eval("Activo") ? "Desactivar" : "Activar" %>'>
                                            <span class="material-symbols-outlined">
                                                <%# (bool)Eval("Activo") ? "delete" : "check" %>
                                            </span>
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>

            <div class="card-footer bg-white d-flex justify-content-between align-items-center py-3">
                <a href="Encargado.aspx" class="btn btn-outline-secondary d-flex align-items-center gap-1">
                    <span class="material-symbols-outlined">arrow_back</span> Volver
                </a>
                <span class="text-muted small d-none d-sm-block">Mostrando usuarios activos e inactivos</span>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
--%>
