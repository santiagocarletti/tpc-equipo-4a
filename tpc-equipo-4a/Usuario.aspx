<%@ Page Title="Gestionar Usuarios" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Usuario.aspx.cs" Inherits="tpc_equipo_4a.Usuario" %>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
        <h2 class="mb-3">Gestionar Usuarios</h2>

        <div class="d-flex gap-2 mb-3">
            <asp:Button
                ID="NuevoUsuario"
                runat="server"
                CssClass="btn btn-primary btn-sm ms-auto"
                Text="+ Nuevo Usuario"
                OnClick="btnNuevoUsuario_Click" />

            <button class="btn btn-outline-secondary btn-sm">Roles</button>
        </div>

        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead class="table-light">
                    <tr>
                        <th>Usuario</th>
                        <th>Rol</th>
                        <th>Estado</th>
                        <th class="text-end">Acciones</th>
                    </tr>
                </thead>

                <tbody>
                    <asp:Repeater ID="repUsuarios" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("NombreUsuario") %></td>
                                <td><%# Eval("Rol") %></td>
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
                                        ID="btnCambiarEstadoUsuario"
                                        runat="server"
                                        CssClass='<%# "btn btn-outline-" + ((bool)Eval("Activo") ? "danger" : "success") + " btn-sm" %>'
                                        Text='<%# (bool)Eval("Activo") ? "Desactivar" : "Activar" %>'
                                        CommandArgument='<%# Eval("Id") %>'
                                        OnClick="btnCambiarEstadoUsuario_Click" />
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
