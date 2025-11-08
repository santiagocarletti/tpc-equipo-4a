<%@ Page Title="Gestionar Combos" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Combo.aspx.cs" Inherits="tpc_equipo_4a.Combo" %>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
        <h2 class="mb-3">Gestionar Combos</h2>

        <div class="row g-3 align-items-center mb-3">
            <div class="col-12 col-md-5">
                <div class="input-group">
                    <span class="input-group-text">🔎</span>
                    <asp:TextBox ID="txtBuscar" runat="server"
                        CssClass="form-control border-start-0"
                        Placeholder="Buscar combo"
                        AutoPostBack="true"
                        OnTextChanged="txtBuscar_TextChanged" />
                </div>
            </div>
            <div class="col-12 col-md-7 d-flex flex-wrap gap-2">
                <asp:Button
                    ID="Button1"
                    runat="server"
                    CssClass="btn btn-primary btn-sm"
                    Text="+ Nuevo combo"
                    OnClick="btnNuevoCombo_Click" />
            </div>
        </div>

        <div class="row g-4">
            <asp:Repeater ID="repCombos" runat="server">
                <ItemTemplate>
                    <div class="col-12 col-md-6 col-lg-4">
                        <div class="card h-100">
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title"><%# Eval("Nombre") %></h5>
                                <p class="text-secondary mb-2"><%# Eval("Descripcion") %></p>
                                <%-- DETALLES POR COMBO --%>
                                <%--                                <ul class="small mb-3">
                                    <%# string.Join("", ((List<dominio.ComboDetalle>)Eval("Detalles")).Select(d => 
                                    $"<li>{(d.Producto != null ? d.Producto.Nombre : d.IdProducto.ToString())} x {d.Cantidad}</li>")) %>
                                </ul>--%>
                                <table class="table table-sm mb-3">
                                    <thead>
                                        <tr>
                                            <th>Producto</th>
                                            <th>Cantidad</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%# string.Join("", ((List<dominio.ComboDetalle>)Eval("Detalles"))
                                                .Select(d => 
                                                    $"<tr>" +
                                                        $"<td>{(d.Producto != null ? d.Producto.Nombre : d.IdProducto.ToString())}</td>" +
                                                        $"<td>{d.Cantidad}</td>" +
                                                    $"</tr>"
                                                )
                                        ) %>
                                    </tbody>
                                </table>
                                <%--  --%>

                                <div class="mb-3">
                                    Estado:
                                        <span class='badge <%# (bool)Eval("Activo") ? "text-bg-success" : "text-bg-secondary" %>'>
                                            <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
                                        </span>
                                </div>

                                <div class="mt-auto d-flex gap-2">
                                    <asp:Button
                                        ID="btnEditar"
                                        runat="server"
                                        CssClass="btn btn-outline-secondary btn-sm"
                                        Text="Editar"
                                        CommandArgument='<%# Eval("Id") %>'
                                        OnClick="btnEditar_Click" />
                                    <asp:Button ID="btnDuplicar" runat="server"
                                        CssClass="btn btn-outline-primary btn-sm"
                                        Text="Duplicar"
                                        CommandArgument='<%# Eval("Id") %>'
                                        OnClick="btnDuplicar_Click" />
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
