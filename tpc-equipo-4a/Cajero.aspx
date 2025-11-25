<%@ Page Title="Cajero - Toma de Pedidos" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Cajero.aspx.cs" Inherits="tpc_equipo_4a.Cajero" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Cajero - Toma de Pedidos
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
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
            padding-bottom: 3rem;
        }

        h1.h2 {
            font-weight: 700;
            color: #1565c0;
        }

        .card {
            border: none;
            border-radius: 1rem;
            box-shadow: 0 0.75rem 1.25rem rgba(0, 0, 0, 0.08);
        }

        .card-header {
            background-color: #ffffff;
            border-bottom: 1px solid #CFD8DC;
        }

        .card-footer {
            background-color: #ffffff;
            border-top: 1px solid #CFD8DC;
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

        .btn-outline-primary {
            border-color: #2196F3;
            color: #2196F3;
            border-radius: 999px;
            font-weight: 500;
        }

            .btn-outline-primary:hover {
                background-color: #E3F2FD;
                color: #0D47A1;
            }

        .btn-outline-secondary {
            border-radius: 0.6rem;
        }

        .product-card {
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
            border-radius: 0.9rem;
        }

            .product-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.10);
            }

        .quantity-control {
            width: 60px;
        }

        .order-item {
            background-color: #f8f9fa;
            border-radius: 0.9rem;
        }

        .modification-btn {
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
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main class="container main-content fade-in">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1 class="h2 fw-bold d-flex align-items-center gap-2">
                <span class="material-symbols-outlined text-primary">shopping_cart</span>
                Toma de Pedidos
            </h1>
        </div>

        <div class="row g-4">
            <div class="col-lg-7">
                <div class="card mb-4">
                    <div class="card-body">

                        <div class="input-group mb-3">
                            <span class="input-group-text bg-white border-end-0">
                                <span class="material-symbols-outlined text-primary">search</span>
                            </span>
                            <asp:TextBox ID="txtBuscar" runat="server"
                                CssClass="form-control border-start-0"
                                placeholder="Buscar productos"></asp:TextBox>
                        </div>

                        <div class="d-flex flex-wrap gap-2">
                            <asp:Button ID="btnCatCombos" runat="server"
                                Text="Combos"
                                CssClass="btn btn-outline-primary rounded-pill"
                                OnClick="btnCatCombos_Click" />

                            <div class="d-flex flex-wrap gap-2">
                                <asp:Repeater ID="repSectores" runat="server">
                                    <ItemTemplate>
                                        <asp:Button ID="btnSector" runat="server"
                                            Text='<%# Eval("Nombre") %>'
                                            CssClass="btn btn-outline-primary rounded-pill"
                                            CommandArgument='<%# Eval("Id") %>'
                                            OnClick="btnSector_Click" />
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-xl-4 g-3"
                    id="panelCombos" runat="server" visible="true">

                    <asp:Repeater ID="repCombosCaja" runat="server">
                        <ItemTemplate>
                            <div class="col">
                                <div class="card h-100 product-card">
                                    <div class="card-body text-center">
                                        <h5 class="card-title mb-2 fw-semibold"><%# Eval("Nombre") %></h5>
                                        <p class="text-secondary mb-3 small"><%# Eval("Descripcion") %></p>

                                        <asp:Button ID="btnAgregar"
                                            runat="server"
                                            Text="Añadir"
                                            CssClass="btn btn-primary btn-sm w-100"
                                            CommandArgument='<%# Eval("Id") %>'
                                            OnClick="btnAgregar_Click" />
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <div class="row g-3 mt-2" id="panelProductosSectores" runat="server" visible="false">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body p-0">
                                <table class="table table-hover mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th class="ps-4">Nombre</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        <asp:Repeater ID="repProductosCaja" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <td class="ps-4 align-middle">
                                                        <%# Eval("Nombre") %>
                                                    </td>
                                                    <td class="text-end pe-4 align-middle">
                                                        <asp:Button ID="btnAgregarProd"
                                                            runat="server"
                                                            Text="Añadir"
                                                            CssClass="btn btn-sm btn-primary"
                                                            CommandArgument='<%# Eval("Id") %>'
                                                            OnClick="btnAgregarProd_Click" />
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-5">
                <div class="card sticky-top" style="top: 100px;">

                    <div class="card-header bg-white">
                        <h4 class="mb-0 fw-semibold">Pedido Actual</h4>
                    </div>
                    <div class="card-body" style="max-height: 500px; overflow-y: auto;">
                        <asp:Repeater ID="repPedido" runat="server">
                            <ItemTemplate>
                                <div class="order-item p-3 mb-3">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <h6 class="mb-0 fw-semibold"><%# Eval("Nombre") %></h6>
                                    </div>
                                    <div class="d-flex align-items-center gap-2">
                                        <div class="btn-group btn-group-sm">

                                            <%-- Botón Restar
                                            <asp:Button ID="btnRestar" runat="server"
                                                Text="-"
                                                CssClass="btn btn-outline-secondary"
                                                CommandArgument='<%# Eval("IdTemp") %>'
                                                OnClick="btnRestar_Click" />
                                            --%>

                                            <span class="btn btn-outline-secondary quantity-control">
                                                <%# Eval("Cantidad") %>
                                            </span>

                                            <%-- Botón Sumar
                                            <asp:Button ID="btnSumar" runat="server"
                                                Text="+"
                                                CssClass="btn btn-outline-secondary"
                                                CommandArgument='<%# Eval("IdTemp") %>'
                                                OnClick="btnSumar_Click" />
                                            --%>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                    <div class="card-footer bg-white">
                        <div class="d-grid gap-2">
                            <asp:Button ID="btnConfirmarPedido" runat="server"
                                Text="Confirmar Pedido"
                                CssClass="btn btn-primary btn-lg"
                                OnClick="btnConfirmarPedido_Click" />

                            <div class="row g-2">
                                <div class="col">
                                    <asp:Button ID="btnCancelar" runat="server"
                                        Text="Cancelar"
                                        CssClass="btn btn-outline-danger w-100" />
                                </div>
                                <div class="col">
                                    <asp:Button ID="btnLimpiar" runat="server"
                                        Text="Limpiar"
                                        CssClass="btn btn-outline-secondary w-100" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

</asp:Content>
