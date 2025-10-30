<%@ Page Title="Gestionar Productos" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Producto.aspx.cs" Inherits="tpc_equipo_4a.Producto" %>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
        <h2 class="mb-3">Gestionar Productos</h2>
        <div class="row g-3 align-items-center mb-3">
            <div class="col-12 col-md-5">
                <div class="input-group">
                    <span class="input-group-text">🔎</span>
                    <input type="text" class="form-control" placeholder="Buscar productos..." />
                </div>
            </div>
            <div class="col-12 col-md-7 d-flex flex-wrap gap-2">
                <button class="btn btn-outline-secondary btn-sm">Todos</button>
                <button class="btn btn-outline-secondary btn-sm">Hamburguesas</button>
                <button class="btn btn-outline-secondary btn-sm">Papas</button>
                <button class="btn btn-outline-secondary btn-sm">Bebidas</button>
                <button class="btn btn-primary btn-sm ms-auto">+ Nuevo producto</button>
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
                    <%--  --%>
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
                                    <button class="btn btn-outline-secondary btn-sm">Editar</button>
                                    <button class='btn btn-outline-<%# (bool)Eval("Activo") ? "danger" : "success" %> btn-sm'>
                                        <%# (bool)Eval("Activo") ? "Desactivar" : "Activar" %>
                                    </button>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                    <%--                    <tr>
                        <td>Hamburguesa clasica</td>
                        <td>Plancha</td>
                        <td>8</td>
                        <td><span class="badge text-bg-success">Activo</span></td>
                        <td class="text-end">
                            <button class="btn btn-outline-secondary btn-sm">Editar</button>
                            <button class="btn btn-outline-danger btn-sm">Desactivar</button>
                        </td>
                    </tr>
                    <tr>
                        <td>Papas Fritas</td>
                        <td>Freidora</td>
                        <td>5</td>
                        <td><span class="badge text-bg-success">Activo</span></td>
                        <td class="text-end">
                            <button class="btn btn-outline-secondary btn-sm">Editar</button>
                            <button class="btn btn-outline-danger btn-sm">Desactivar</button>
                        </td>
                    </tr>
                    <tr>
                        <td>Gaseosa</td>
                        <td>Despacho</td>
                        <td>0</td>
                        <td><span class="badge text-bg-secondary">Inactivo</span></td>
                        <td class="text-end">
                            <button class="btn btn-outline-secondary btn-sm">Editar</button>
                            <button class="btn btn-outline-success btn-sm">Activar</button>
                        </td>
                    </tr>--%>
                </tbody>
            </table>
        </div>
        <div class="mt-3">
            <a href="Encargado.aspx" class="btn btn-outline-secondary">Volver</a>
        </div>
    </div>
</asp:Content>
