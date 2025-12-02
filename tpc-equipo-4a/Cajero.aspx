<%@ Page Title="Cajero - Toma de Pedidos" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Cajero.aspx.cs" Inherits="tpc_equipo_4a.Cajero" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Cajero - Toma de Pedidos
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet" />

    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #ECEFF1;
            color: #424242;
        }

        .main-content {
            padding-top: 2rem;
            padding-bottom: 4rem !important;
        }

        .logout-btn {
            position: fixed;
            bottom: 20px;
            left: 20px;
            z-index: 2000;
        }

            .logout-btn .btn {
                background: #b71c1c;
                color: white;
                font-weight: 600;
                border-radius: 12px;
                padding: 10px 18px;
                box-shadow: 0 4px 10px rgba(0,0,0,.2);
            }

                .logout-btn .btn:hover {
                    background: #9a0007;
                    transform: translateY(-2px);
                }

        .notificacion-badge {
            position: fixed;
            top: 110px;
            right: 25px;
            z-index: 1500;
        }

        .btn-notificacion {
            background-color: #dc3545;
            color: white;
            border: none;
            border-radius: 50%;
            width: 60px;
            height: 60px;
            font-size: 1.6rem;
            box-shadow: 0 6px 14px rgba(220, 53, 69, 0.4);
            transition: all .3s ease;
        }

            .btn-notificacion:hover {
                background-color: #c82333;
                transform: scale(1.1);
            }

        .badge-count {
            position: absolute;
            top: -4px;
            right: -6px;
            background-color: #fff;
            color: #dc3545;
            border: 2px solid #dc3545;
            border-radius: 50%;
            width: 23px;
            height: 23px;
            font-size: .75rem;
            font-weight: 700;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .notificaciones-panel {
            position: fixed;
            top: 180px;
            right: 25px;
            width: 350px;
            max-height: 500px;
            overflow-y: auto;
            z-index: 1400;
            background: white;
            border-radius: 0.75rem;
            box-shadow: 0 12px 35px rgba(0,0,0,0.22);
        }

        .reporte-item:hover {
            background: #f5f5f5;
        }

        .combo-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,.45);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 2000;
        }

        .combo-box {
            background: #fff;
            padding: 25px;
            border-radius: 14px;
            width: 480px;
            max-height: 80vh;
            overflow-y: auto;
            box-shadow: 0 6px 22px rgba(0,0,0,.25);
        }
    </style>

</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="notificacion-badge">
        <asp:Button ID="btnToggleNotificaciones" runat="server"
            CssClass="btn btn-notificacion"
            Text="🔔"
            OnClick="btnToggleNotificaciones_Click" />
        <asp:Label ID="lblContadorReportes" runat="server"
            CssClass="badge-count"
            Text="0"
            Visible="false"></asp:Label>
    </div>

    <div id="panelNotificaciones" runat="server" class="notificaciones-panel" visible="false">
        <div class="p-3 border-bottom bg-danger text-white rounded-top">
            <h6 class="m-0 fw-bold">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                Ingredientes Faltantes
            </h6>
        </div>

        <asp:Repeater ID="repReportes" runat="server" OnItemCommand="repReportes_ItemCommand">
            <ItemTemplate>
                <div class='reporte-item <%# (string)Eval("Estado") == "Pendiente" ? "reporte-nuevo" : "" %>'>
                    <div class="d-flex justify-content-between align-items-start">
                        <div class="flex-grow-1">
                            <h6 class="mb-1 fw-bold text-danger">
                                <i class="bi bi-egg-fill me-1"></i>
                                <%# Eval("NombreIngrediente") %>
                            </h6>
                            <small class="text-muted">
                                <i class="bi bi-geo-alt-fill"></i><%# Eval("SectorOrigen") %>
                            </small>
                            <br />
                            <small class="text-muted">
                                <i class="bi bi-person-fill"></i><%# Eval("UsuarioReporta") %>
                            </small>
                            <br />
                            <small class="text-muted">
                                <i class="bi bi-clock-fill"></i><%# Eval("TiempoTranscurrido") %>
                            </small>
                        </div>

                        <div class="ms-2">
                            <asp:Button ID="btnResolver" runat="server"
                                CommandName="Resolver"
                                CommandArgument='<%# Container.ItemIndex %>'
                                CssClass='<%# (string)Eval("Estado") == "Pendiente" ? "btn btn-sm btn-success btn-resolver" : "d-none" %>'
                                Text="Resolver"
                                Visible='<%# (string)Eval("Estado") == "Pendiente" %>' />
                            <span class='<%# (string)Eval("Estado") == "Resuelto" ? "badge bg-success" : "d-none" %>'>Resuelto
                            </span>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>


        <div id="divSinReportes" runat="server" class="p-4 text-center text-muted" visible="false">
            <i class="bi bi-check-circle" style="font-size: 3rem;"></i>
            <p class="mt-2 mb-0">No hay reportes pendientes</p>
        </div>
    </div>

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
                                            <th></th>
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
                                <div class="mb-3">

                                    <!-- Nombre -->
                                    <div class="d-flex justify-content-between align-items-center">

                                        <span class='<%# 
                                    (bool)Eval("EsCombo") 
                                        ? "fw-semibold text-dark"
                                        : (bool)Eval("EsHijo") 
                                            ? "ms-3"
                                            : "fw-semibold text-dark" %>'>

                                            <%# Eval("Nombre") %>
                                        </span>

                                        <div class="d-flex align-items-center gap-2">
                                            <span class="text-secondary small">x<%# Eval("Cantidad") %>
                                            </span>

                                            <asp:Button ID="btnEliminarItem"
                                                runat="server"
                                                Text="Eliminar"
                                                CssClass="btn btn-sm btn-outline-danger"
                                                Visible='<%# !(bool)Eval("EsHijo") %>'
                                                CommandArgument='<%# Eval("Clave") %>'
                                                OnClick="btnEliminarItem_Click" />

                                            <asp:Button ID="btnEditarItem"
                                                runat="server"
                                                Text="Editar"
                                                CssClass="btn btn-sm btn-outline-primary"
                                                CommandArgument='<%# Eval("Clave") %>'
                                                OnClick="btnEditarItem_Click" />

                                        </div>
                                    </div>

                                    <!-- COMENTARIO -->
                                    <asp:Panel runat="server" CssClass="ms-4 mt-1 fst-italic text-muted"
                                        Visible='<%# !String.IsNullOrEmpty(Eval("Comentario") as string) %>'>
                                        <asp:Literal ID="litComentario"
                                            runat="server"
                                            Text='<%# Eval("Comentario") %>' />
                                    </asp:Panel>

                                    <!-- INGR. -->
                                    <asp:Panel runat="server" CssClass="ms-4 mt-1 text-secondary small"
                                        Visible='<%# !String.IsNullOrEmpty(Eval("DetalleIngredientes") as string) %>'>
                                        <asp:Literal ID="litDetalleIngredientes"
                                            runat="server"
                                            Text='<%# Eval("DetalleIngredientes") %>' />
                                    </asp:Panel>

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


    <div id="panelCombo" class="combo-overlay" style="display: none;">
        <div class="combo-box">

            <h5 class="mb-3">Configurar Combo</h5>

            <asp:HiddenField ID="hfIdComboSeleccionado" runat="server" />

            <asp:Repeater
                ID="repGruposCombo"
                runat="server"
                OnItemDataBound="repGruposCombo_ItemDataBound">

                <ItemTemplate>
                    <div class="grupo-bloque">
                        <h6 class="fw-semibold"><%# Eval("NombreGrupo") %></h6>

                        <asp:RadioButtonList ID="rblOpciones"
                            runat="server"
                            RepeatDirection="Vertical"
                            CssClass="rbl-opciones">
                        </asp:RadioButtonList>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <div class="d-flex justify-content-end mt-3 gap-2">
                <asp:Button ID="btnCancelarCombo" runat="server"
                    Text="Cancelar"
                    CssClass="btn btn-outline-secondary"
                    OnClientClick="ocultarPanelCombo(); return false;" />

                <asp:Button ID="btnConfirmarCombo" runat="server"
                    Text="Añadir"
                    CssClass="btn btn-primary"
                    OnClick="btnConfirmarCombo_Click" />
            </div>

        </div>
    </div>

    <script>
        function mostrarPanelCombo() {
            document.getElementById('panelCombo').style.display = 'flex';
        }
        function ocultarPanelCombo() {
            document.getElementById('panelCombo').style.display = 'none';
        }
    </script>

    <!-- PANEL PARA EDICIÓN DE ITEM -->
    <div id="panelEdicionItem" class="combo-overlay" style="display: none;">
        <div class="combo-box">

            <h5 class="mb-3">
                <asp:Label ID="lblTituloEdicionItem" runat="server" Text="Editar ítem"></asp:Label>
            </h5>

            <!-- Guarda el IdentificadorUnico del item -->
            <asp:HiddenField ID="hfItemEnEdicion" runat="server" />

            <!-- INGREDIENTES DEL PRODUCTO EN EDICION -->
            <asp:Repeater ID="repIngredientesEdicion" runat="server">
                <ItemTemplate>
                    <div class="d-flex justify-content-between align-items-center mb-2">

                        <asp:HiddenField ID="hfEsDelProducto" runat="server"
                            Value='<%# Eval("EsDelProducto") %>' />

                        <asp:Label ID="lblNombreIngrediente" runat="server"
                            Text='<%# Eval("Nombre") %>' />

                        <asp:HiddenField ID="hfIdIngrediente" runat="server"
                            Value='<%# Eval("IdIngrediente") %>' />

                        <!-- Checkbox incluir / quitar -->
                        <asp:CheckBox ID="chkIncluir"
                            runat="server"
                            Checked='<%# Eval("Incluir") %>'
                            CssClass="d-none" />

                        <!-- Cantidad -->
                        <asp:TextBox ID="txtCantidadIng" runat="server"
                            CssClass="form-control text-center"
                            Style="width: 60px;"
                            Text='<%# Eval("Cantidad") %>'
                            TextMode="Number"
                            min="0"
                            max="10"
                            Enabled='<%# Convert.ToBoolean(Eval("EsOpcional")) %>'>
                        </asp:TextBox>

                    </div>
                </ItemTemplate>

            </asp:Repeater>

            <!-- Comentario -->
            <div id="divComentarioEdicion" runat="server" class="mt-3">
                <label class="form-label fw-semibold">Comentario</label>
                <asp:TextBox ID="txtComentarioEdicion" runat="server"
                    CssClass="form-control"
                    TextMode="MultiLine"
                    Rows="2"></asp:TextBox>
            </div>

            <div class="d-flex justify-content-end mt-3">
                <asp:Button ID="btnGuardarEdicion"
                    runat="server"
                    Text="Guardar"
                    CssClass="btn btn-primary"
                    OnClick="btnGuardarEdicion_Click" />

                <button type="button" class="btn btn-outline-secondary ms-2"
                    onclick="ocultarPanelEdicion();">
                    Cerrar
                </button>
            </div>


        </div>

    </div>

    <script>
        function mostrarPanelEdicion() {
            document.getElementById('panelEdicionItem').style.display = 'flex';
        }

        function ocultarPanelEdicion() {
            document.getElementById('panelEdicionItem').style.display = 'none';
        }
    </script>

    <div class="logout-btn">
        <asp:Button ID="btnLogout" runat="server"
            Text="Cerrar sesión"
            CssClass="btn"
            OnClick="btnLogout_Click" />
    </div>


</asp:Content>
