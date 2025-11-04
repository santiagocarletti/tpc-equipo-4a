<%@ Page Title="Gestionar Combos" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Combo.aspx.cs" Inherits="tpc_equipo_4a.Combo" %>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
        <h2 class="mb-3">Gestionar Combos</h2>

        <div class="d-flex gap-2 mb-3">
            <button class="btn btn-primary btn-sm">+ Nuevo combo</button>
            <button class="btn btn-outline-secondary btn-sm">Duplicar</button>
        </div>

        <div class="row g-4">
            <asp:Repeater ID="repCombos" runat="server">
                <ItemTemplate>
                    <div class="col-12 col-md-6 col-lg-4">
                        <div class="card h-100">
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title"><%# Eval("Nombre") %></h5>
                                <p class="text-secondary mb-2"><%# Eval("Descripcion") %></p>
                                <ul class="small mb-4">
                                    <li>Estado:
                                        <span class='badge <%# (bool)Eval("Activo") ? "text-bg-success" : "text-bg-secondary" %>'>
                                            <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
                                        </span>
                                    </li>
                                </ul>
                                <div class="mt-auto d-flex gap-2">
                                    <asp:Button
                                        ID="btnEditar"
                                        runat="server"
                                        CssClass="btn btn-outline-secondary btn-sm"
                                        Text="Editar"
                                        CommandArgument='<%# Eval("Id") %>'
                                        OnClick="btnEditar_Click" />
                                    <asp:Button
                                        ID="btnCambiarEstadoCombo"
                                        runat="server"
                                        CssClass='<%# "btn btn-outline-" + ((bool)Eval("Activo") ? "danger" : "success") + " btn-sm" %>'
                                        Text='<%# (bool)Eval("Activo") ? "Desactivar" : "Activar" %>'
                                        CommandArgument='<%# Eval("Id") %>'
                                        OnClick="btnCambiarEstadoCombo_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <div class="mt-3">
            <a href="Encargado.aspx" class="btn btn-outline-secondary">Volver</a>
        </div>
    </div>
</asp:Content>

<%--         <div class="row g-4">
            <div class="col-12 col-md-6 col-lg-4">
                <div class="card h-100">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">Combo Clasico</h5>
                        <p class="text-secondary mb-2">Hamburguesa simple + Papas + Gaseosa</p>
                        <ul class="small mb-4">
                            <li>Precio: $</li>
                            <li>Estado: <span class="badge text-bg-success">Activo</span></li>
                        </ul>
                        <div class="mt-auto d-flex gap-2">
                            <button class="btn btn-outline-secondary btn-sm">Editar</button>
                            <button class="btn btn-outline-danger btn-sm">Desactivar</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-6 col-lg-4">
                <div class="card h-100">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">Combo Doble</h5>
                        <p class="text-secondary mb-2">Doble Bacon + Papas + Gaseosa</p>
                        <ul class="small mb-4">
                            <li>Precio: $</li>
                            <li>Estado: <span class="badge text-bg-success">Activo</span></li>
                        </ul>
                        <div class="mt-auto d-flex gap-2">
                            <button class="btn btn-outline-secondary btn-sm">Editar</button>
                            <button class="btn btn-outline-danger btn-sm">Desactivar</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-6 col-lg-4">
                <div class="card h-100">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">Combo Clasico</h5>
                        <p class="text-secondary mb-2">Hamburguesa simple + Papas + Gaseosa</p>
                        <ul class="small mb-4">
                            <li>Precio: $</li>
                            <li>Estado: <span class="badge text-bg-secondary">Inactivo</span></li>
                        </ul>
                        <div class="mt-auto d-flex gap-2">
                            <button class="btn btn-outline-secondary btn-sm">Editar</button>
                            <button class="btn btn-outline-success btn-sm">Activar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>--%>
