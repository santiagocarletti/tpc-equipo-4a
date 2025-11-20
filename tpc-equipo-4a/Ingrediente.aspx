<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Ingrediente.aspx.cs" Inherits="tpc_equipo_4a.Ingrediente" %>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />

    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f5f8ff;
        }

        h1.h2 {
            color: #1565c0;
            font-weight: 700;
        }

        .main-content {
            padding-top: 2rem;
            padding-bottom: 2rem;
        }

        .card {
            border: none;
            border-radius: 1rem;
            box-shadow: 0 0.75rem 1.5rem rgba(33, 150, 243, 0.08);
            overflow: hidden;
        }

        .card-header {
            background-color: #ffffff;
            border-bottom: 1px solid #e3f2fd;
            padding: 1rem 1.5rem;
        }

        .table thead th {
            font-weight: 600;
            color: #1976d2;
            text-transform: uppercase;
            font-size: 0.85rem;
            background-color: #e3f2fd;
        }

        .table-hover tbody tr:hover {
            background-color: #eaf3ff;
        }

        .btn-primary {
            background-color: #2196f3;
            border-color: #2196f3;
            font-weight: 500;
            border-radius: 0.5rem;
            transition: all 0.2s ease-in-out;
        }

        .btn-primary:hover {
            background-color: #1976d2;
            border-color: #1976d2;
            transform: translateY(-1px);
        }

        .btn-outline-secondary {
            border-radius: 0.5rem;
            font-weight: 500;
        }

        .btn-outline-secondary:hover {
            background-color: #bbdefb;
            color: #0d47a1;
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

        .btn-action-edit {
            background-color: #e3f2fd;
            color: #1565c0;
        }

        .btn-action-edit:hover {
            background-color: #bbdefb;
            transform: scale(1.05);
        }

        .btn-action-delete {
            background-color: #ffebee;
            color: #c62828;
        }

        .btn-action-delete:hover {
            background-color: #ffcdd2;
            transform: scale(1.05);
        }

        .badge.bg-success {
            background-color: #2196f3 !important;
        }

        .fade-in {
            animation: fadeIn 0.4s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>

    <main class="main-content container fade-in">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap">
            <h1 class="h2 fw-bold mb-0 d-flex align-items-center">
                <span class="material-symbols-outlined me-2">restaurant_menu</span>
                Gestión de Ingredientes
            </h1>

            <asp:Button
                ID="btnNuevoIngrediente"
                runat="server"
                CssClass="btn btn-primary d-flex align-items-center"
                Text="+ Nuevo Ingrediente"
                OnClick="btnNuevoIngrediente_Click" />
        </div>

        <div class="card">
            <div class="card-header d-flex flex-wrap justify-content-between align-items-center gap-2">
                <div class="input-group input-group-sm" style="max-width: 300px;">
                    <span class="input-group-text bg-white border-end-0">
                        <span class="material-symbols-outlined text-primary" style="font-size: 1.25rem;">search</span>
                    </span>
<%--                    <asp:TextBox
                        ID="txtBuscar"
                        runat="server"
                        CssClass="form-control border-start-0"
                        Placeholder="Buscar ingrediente."
                        AutoPostBack="true"
                        OnTextChanged="txtBuscar_TextChanged" />--%>
                </div>

                <div class="d-flex flex-wrap gap-2">
                    <asp:Repeater ID="repSectores" runat="server">
                        <ItemTemplate>
                            <asp:Button
                                ID="btnFiltrarSector"
                                runat="server"
                                Text='<%# Eval("Nombre") %>'
                                CssClass="btn btn-outline-secondary btn-sm"
                                CommandArgument='<%# Eval("Id") %>'
                                OnClick="btnFiltrarSector_Click" />
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-hover mb-0 align-middle">
                    <thead>
                        <tr>
                            <th class="ps-4">Nombre</th>
                            <th>Sector</th>
                            <th>Minutos Prep.</th>
                            <th>Estado</th>
                            <th class="text-end pe-4">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%--  --%>
                        <asp:Repeater ID="repIngredientes" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td class="ps-4 fw-medium"><%# Eval("Nombre") %></td>
                                    <td><%# Eval("NombreSector") %></td>
                                    <td><%# Eval("MinutosPreparacion") %></td>
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
                                            ToolTip="Editar ingrediente">
                                            <span class="material-symbols-outlined">edit</span>
                                        </asp:LinkButton>

                                        <asp:LinkButton
                                            ID="btnCambiarEstadoIngrediente"
                                            runat="server"
                                            CssClass='<%# "btn btn-action " + ((bool)Eval("Activo") ? "btn-action-delete" : "btn-action-edit") %>'
                                            CommandArgument='<%# Eval("Id") %>'
                                            OnClick="btnCambiarEstadoIngrediente_Click"
                                            ToolTip='<%# (bool)Eval("Activo") ? "Desactivar" : "Activar" %>'>
                                            <span class="material-symbols-outlined">
                                                <%# (bool)Eval("Activo") ? "delete" : "check" %>
                                            </span>
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                        <%--  --%>
                    </tbody>
                </table>
            </div>

            <div class="card-footer bg-white d-flex justify-content-between align-items-center py-3">
                <a href="Encargado.aspx" class="btn btn-outline-secondary d-flex align-items-center">
                    <span class="material-symbols-outlined me-1">arrow_back</span> Volver
                </a>
                <span class="text-muted small d-none d-sm-block">Mostrando todos los ingredientes</span>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>