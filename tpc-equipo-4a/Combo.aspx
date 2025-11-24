<%@ Page Title="Gestionar Combos" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Combo.aspx.cs" Inherits="tpc_equipo_4a.Combo" %>

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
            color: #1565c0;
        }

        .card {
            border: none;
            border-radius: 1rem;
            box-shadow: 0 0.75rem 1.25rem rgba(0, 0, 0, 0.08);
            overflow: hidden;
            background-color: #ffffff;
        }

        .combo-card {
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

            .combo-card:hover {
                transform: translateY(-2px);
                box-shadow: 0 1rem 1.6rem rgba(0, 0, 0, 0.12);
            }

        .combo-header {
            padding-bottom: .25rem;
        }

        .combo-title {
            margin: 0;
            font-size: 1.15rem;
            font-weight: 700;
            color: #1565c0;
        }

        .combo-subtitle {
            font-size: .9rem;
            color: #616161;
        }

        .table-sm thead th {
            font-weight: 600;
            font-size: 0.8rem;
            text-transform: uppercase;
        }

        .badge {
            font-weight: 500;
            padding: 0.35em 0.75em;
            font-size: 0.8rem;
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
            color: #CFD8DC;
        }

        .form-control {
            background-color: #ECEFF1;
            border: none;
            color: #424242;
        }

            .form-control::placeholder {
                color: #616161;
            }

            .form-control:focus {
                background-color: #CFD8DC;
                box-shadow: 0 0 0 0.2rem rgba(33, 150, 243, 0.25);
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
                <span class="material-symbols-outlined">fastfood</span>
                Gestión de Combos
            </h1>

            <asp:Button
                ID="btnNuevoCombo"
                runat="server"
                CssClass="btn btn-primary d-flex align-items-center gap-1"
                Text="+ Nuevo combo"
                OnClick="btnNuevoCombo_Click" />
        </div>

        <div class="card mb-4">
            <div class="card-header d-flex justify-content-between align-items-center flex-wrap gap-3">
                <div class="w-100 w-sm-auto" style="max-width: 420px;">
                    <div class="input-group input-group-sm">
                        <span class="input-group-text bg-white border-end-0">
                            <span class="material-symbols-outlined text-primary" style="font-size: 1.25rem;">search</span>
                        </span>
                        <asp:TextBox
                            ID="txtBuscar"
                            runat="server"
                            CssClass="form-control border-start-0"
                            Placeholder="Buscar combo"
                            AutoPostBack="true"
                            OnTextChanged="txtBuscar_TextChanged" />
                    </div>
                </div>
            </div>
        </div>

        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
            <asp:Repeater ID="repCombos" runat="server">
                <ItemTemplate>
                    <div class="col">
                        <div class="card combo-card h-100">
                            <div class="card-body d-flex flex-column">
                                <div class="combo-header mb-2">
                                    <h5 class="combo-title"><%# Eval("Nombre") %></h5>
                                    <p class="combo-subtitle mb-0"><%# Eval("Descripcion") %></p>
                                </div>

                                <table class="table table-sm mb-3">
                                    <thead>
                                        <tr>
                                            <th>Producto</th>
                                            <th class="text-end">Cant.</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%# string.Join("",
                                            ((System.Collections.Generic.List<dominio.ComboDetalle>)Eval("Detalles"))
                                                .Select(d =>
                                                    "<tr>" +
                                                        "<td>" + (d.Producto != null ? d.Producto.Nombre : d.IdProducto.ToString()) + "</td>" +
                                                        "<td class='text-end'>" + d.Cantidad + "</td>" +
                                                    "</tr>"
                                                )
                                        ) %>
                                    </tbody>
                                </table>

                                <div class="mb-3">
                                    <span class="fw-semibold">Estado:</span>
                                    <span class='badge <%# (bool)Eval("Activo") ? "badge-success" : "badge-secondary" %>'>
                                        <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
                                    </span>
                                </div>

                                <div class="mt-auto d-flex gap-2 pt-1">
                                    <asp:LinkButton
                                        ID="btnEditar"
                                        runat="server"
                                        CssClass="btn btn-action btn-edit"
                                        CommandArgument='<%# Eval("Id") %>'
                                        OnClick="btnEditar_Click"
                                        ToolTip="Editar combo">
                                        <span class="material-symbols-outlined">edit</span>
                                    </asp:LinkButton>

                                    <asp:LinkButton
                                        ID="btnCambiarEstadoCombo"
                                        runat="server"
                                        CssClass="btn btn-action btn-delete"
                                        CommandArgument='<%# Eval("Id") %>'
                                        OnClick="btnCambiarEstadoCombo_Click"
                                        ToolTip='<%# (bool)Eval("Activo") ? "Desactivar" : "Activar" %>'>
                                        <span class="material-symbols-outlined">
                                            <%# (bool)Eval("Activo") ? "delete" : "add" %>
                                        </span>
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mt-4">
            <a href="Encargado.aspx" class="btn btn-outline-secondary d-flex align-items-center gap-1">
                <span class="material-symbols-outlined">arrow_back</span> Volver
            </a>
            <span class="text-muted small">Mostrando combos activos e inactivos.</span>
        </div>

    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>