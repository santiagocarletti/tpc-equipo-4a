<%@ Page Title="Sector Plancha" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Plancha.aspx.cs" Inherits="tpc_equipo_4a.Plancha" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .sidebar {
            width: 250px;
            min-height: 100vh;
            background-color: #fff;
            border-right: 1px solid #dee2e6;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .sidebar i {
            font-size: 1.2rem;
        }

        .sidebar-footer {
            margin-top: auto;
            border-top: 1px solid #eee;
            padding-top: 1rem;
        }

        .btn-danger {
            background-color: #dc3545 !important;
            border-color: #dc3545 !important;
        }

        .btn-outline-danger:hover {
            background-color: #dc3545 !important;
            color: #fff !important;
        }

        .pedido-card {
            background: rgba(255,255,255,0.92);
            border: 1px solid rgba(0,0,0,0.08);
            border-radius: 0.75rem;
            box-shadow: 0 6px 18px rgba(0,0,0,0.08);
            transition: transform .15s ease, box-shadow .15s ease;
            backdrop-filter: saturate(120%) blur(1px);
        }

        .pedido-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 24px rgba(0,0,0,0.10);
        }

        .pedido-header {
            background-color: #f8d7da;
            color: #dc3545;
            border-bottom: 1px solid #dee2e6;
            border-radius: 0.75rem 0.75rem 0 0;
        }

        .pedido-body p {
            margin-bottom: 0.35rem;
        }

        .alert {
            border-radius: 0.5rem;
            margin-bottom: 0.75rem;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="d-flex">
                
        <nav class="sidebar p-3">
                        
            <div class="d-flex align-items-center mb-4">
                <div class="rounded-circle bg-danger d-flex align-items-center justify-content-center me-2" style="width: 40px; height: 40px;">
                    🍔
                </div>

                <div>
                    <h6 class="m-0 fw-bold">
                        <asp:Label ID="lblNombreUsuario" runat="server" Text="Usuario"></asp:Label>
                    </h6>
                    <small class="text-muted">Sector Plancha</small>
                </div>
            </div>

            
            <div class="sidebar-footer">
                
                <div id="divMensaje" runat="server" visible="false" class="alert" role="alert">
                    <span id="spanMensaje" runat="server"></span>
                </div>

                <div class="card p-3 shadow-sm">
                    <h6 class="fw-bold mb-2">Reportar ingrediente</h6>

                    <div class="mb-2">
                        <asp:DropDownList ID="ddlIngredientes" runat="server" CssClass="form-select"></asp:DropDownList>
                    </div>

                    <asp:Button ID="btnReportar" runat="server" Text="Reportar"
                        CssClass="btn btn-danger w-100"
                        OnClick="btnReportar_Click" />
                </div>
                
                <asp:Button ID="btnLogout" runat="server" Text="Cerrar sesión"
                    CssClass="btn btn-outline-danger w-100 mt-3"
                    OnClick="btnLogout_Click" />
            </div>

        </nav>

        
        <div class="container-fluid p-4">
            <h4 class="fw-bold mb-4">Sector Plancha</h4>
            
            <div class="row row-cols-1 row-cols-md-2 g-4">

                <asp:Repeater ID="repPedidos" runat="server">
                    <ItemTemplate>
                        <div class="col">
                            <div class="pedido-card shadow-sm">
                                <div class="pedido-header p-3 d-flex justify-content-between align-items-center">
                                    <h5 class="fw-bold">Pedido #<%# Eval("NumeroComanda") %></h5>
                                    <small><%# Eval("TiempoTranscurrido") %></small>
                                </div>

                                <div class="pedido-body p-3">
                                    <p class="fw-bold mb-2">Productos:</p>

                                    <asp:Literal
                                        ID="litProductos"
                                        runat="server"
                                        Text='<%# Eval("ProductosTexto") %>'
                                        Mode="PassThrough" />

                                    <p class="fw-bold mt-3 mb-1 text-danger">Comentarios:</p>
                                    <p><%# Eval("Comentarios") %></p>

                                    <div class="mt-3 text-end">
                                        <asp:Button
                                            ID="btnPedidoListo"
                                            runat="server"
                                            Text="Pedido Listo"
                                            CssClass="btn btn-danger"
                                            CommandArgument='<%# Eval("IdComanda") %>'
                                            OnClick="btnPedidoListo_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <a href="Cocina.aspx" class="btn btn-outline-secondary mt-4">Volver a Cocina</a>
        </div>

    </div>

</asp:Content>
