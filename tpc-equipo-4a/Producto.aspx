<%@ Page Title="Gestionar Productos" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Producto.aspx.cs" Inherits="tpc_equipo_4a.Producto" %>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
        <h2 class="mb-3">Gestionar Productos</h2>
        <div class="row g-3 align-items-center mb-3">
            <div class="col-12 col-md-5">
                <div class="input-group">
                    <span class="input-group-text">🔎</span>
                    <asp:TextBox
                        ID="txtBuscar"
                        runat="server"
                        CssClass="form-control border-start-0"
                        Placeholder="Buscar producto"
                        AutoPostBack="true"
                        OnTextChanged="txtBuscar_TextChanged" />
                </div>
            </div>
            <div class="col-12 col-md-7 d-flex flex-wrap gap-2">

                <asp:Repeater ID="repSectores" runat="server">
                    <ItemTemplate>
                        <asp:Button ID="btnFiltrarSector" runat="server"
                            Text='<%# ((int)Eval("Id") == -1 ? Eval("Nombre") : "Sector " + Eval("Nombre")) %>'
                            CssClass="btn btn-outline-secondary btn-sm"
                            CommandArgument='<%# Eval("Id") %>'
                            OnClick="btnFiltrarSector_Click" />
                    </ItemTemplate>
                </asp:Repeater>

                <%--                <asp:Button
                    ID="btnListarTodos"
                    runat="server"
                    CssClass="btn btn-outline-secondary btn-sm"
                    Text="Todos"
                    CommandArgument='<%# Eval("Id") %>'
                    OnClick="btnListarTodos_Click" />--%>

                <asp:Button
                    ID="btnNuevoProducto"
                    runat="server"
                    CssClass="btn btn-primary btn-sm ms-auto"
                    Text="+ Nuevo producto"
                    OnClick="btnNuevoProducto_Click" />

            </div>
        </div>
        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead class="table-light">
                    <tr>
                        <th>Nombre</th>
                        <th>Sector</th>
                        <th>Minutos Prep.</th>
                        <th>Estado</th>
                        <th class="text-end">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    
                    <asp:Repeater ID="repProductos" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("Nombre") %></td>
                                <td><%# Eval("Sector.Nombre") %></td>
                                <td><%# Eval("MinutosPreparacion") %></td>
                                <td>
                                    <span class='badge <%# (bool)Eval("Activo") ? "text-bg-success" : "text-bg-secondary" %>'>
                                        <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
                                    </span>
                                </td>
                                <td class="text-end">

                                    <asp:Button
                                        ID="btnEditar"
                                        runat="server"
                                        CssClass="btn btn-outline-secondary btn-sm"
                                        Text="Editar"
                                        CommandArgument='<%# Eval("Id") %>'
                                        OnClick="btnEditar_Click" />

                                    <asp:Button
                                        ID="btnCambiarEstadoProducto"
                                        runat="server"
                                        CssClass='<%# "btn btn-outline-" + ((bool)Eval("Activo") ? "danger" : "success") + " btn-sm" %>'
                                        Text='<%# (bool)Eval("Activo") ? "Desactivar" : "Activar" %>'
                                        CommandArgument='<%# Eval("Id") %>'
                                        OnClick="btnCambiarEstadoProducto_Click" />

                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>

                </tbody>
            </table>
        </div>
        <div class="mt-3">
            <a href="Encargado.aspx" class="btn btn-outline-secondary">Volver</a>
        </div>
    </div>
</asp:Content>


