<%@ Page Title="Cajero - Toma de Pedidos" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Cajero.aspx.cs" Inherits="tpc_equipo_4a.Cajero" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Cajero - Toma de Pedidos
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>
        .product-card {
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
        }

            .product-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            }

        .quantity-control {
            width: 60px;
        }

        .order-item {
            background-color: #f8f9fa;
            border-radius: 8px;
        }

        .modification-btn {
            font-size: 0.875rem;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row g-4">


        <div class="col-lg-7">

            <div class="card mb-4">
                <div class="card-body">

                    <div class="input-group mb-3">
                        <span class="input-group-text">
                            <span class="material-symbols-outlined">search</span>
                        </span>
                        <asp:TextBox ID="txtBuscar" runat="server"
                            CssClass="form-control"
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


            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-xl-4 g-3" id="panelCombos" runat="server" visible="true">

                <%--  --%>

                <asp:Repeater ID="repCombosCaja" runat="server">
                    <ItemTemplate>
                        <div class="col">
                            <div class="card h-100 product-card">
                                <div class="card-body text-center">
                                    <h5 class="card-title mb-3"><%# Eval("Nombre") %></h5>
                                    <p class="text-secondary mb-2"><%# Eval("Descripcion") %></p>

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

            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-xl-4 g-3" id="panelProductosSectores" runat="server" visible="false">

                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Nombre</th>
                        </tr>
                    </thead>

                    <tbody>
                        <asp:Repeater ID="repProductosCaja" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td class="d-flex justify-content-between">

                                        <%# Eval("Nombre") %>

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

        <div class="col-lg-5">
            <div class="card sticky-top" style="top: 100px;">


                <div class="card-header bg-white">
                    <h4 class="mb-0">Pedido Actual</h4>
                </div>


                <div class="card-body" style="max-height: 500px; overflow-y: auto;">

                    <!-- Pedido 1 -->
                    <div class="order-item p-3 mb-3">

                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <h6 class="mb-0 fw-semibold">Classic Burger</h6>
                            <span class="fw-semibold">#A103</span>
                        </div>

                        <asp:Repeater ID="repPedido" runat="server">
                            <ItemTemplate>
                                <div class="order-item p-3 mb-3">

                                    <h6><%# Eval("Nombre") %></h6>

                                    <div class="btn-group btn-group-sm">
<%--                                        <asp:Button ID="btnRestar" runat="server" Text="-"
                                            CommandArgument='<%# Eval("IdTemp") %>' OnClick="btnRestar_Click" />--%>
                                        <span class="btn btn-outline-secondary quantity-control"><%# Eval("Cantidad") %></span>
<%--                                        <asp:Button ID="btnSumar" runat="server" Text="+"
                                            CommandArgument='<%# Eval("IdTemp") %>' OnClick="btnSumar_Click" />--%>
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
                                OnClick="btnConfirmarPedido_Click"/>
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
</asp:Content>
