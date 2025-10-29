<%@ Page Title="Gestionar Usuarios" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Usuario.aspx.cs" Inherits="tpc_equipo_4a.Usuario" %>
<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
        <h2 class="mb-3">Gestionar Usuarios</h2>
        <div class="d-flex gap-2 mb-3">
            <button class="btn btn-primary btn-sm">+ Nuevo usuario</button>
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
                    <tr>
                        <td>encargado</td>
                        <td>Encargado</td>
                        <td><span class="badge text-bg-success">Activo</span></td>
                        <td class="text-end">
                            <button class="btn btn-outline-secondary btn-sm">Editar</button>
                            <button class="btn btn-outline-danger btn-sm">Desactivar</button>
                        </td>
                    </tr>
                    <tr>
                        <td>cajero1</td>
                        <td>Cajero</td>
                        <td><span class="badge text-bg-success">Activo</span></td>
                        <td class="text-end">
                            <button class="btn btn-outline-secondary btn-sm">Editar</button>
                            <button class="btn btn-outline-danger btn-sm">Desactivar</button>
                        </td>
                    </tr>
                    <tr>
                        <td>plancha2</td>
                        <td>Cocina (Plancha)</td>
                        <td><span class="badge text-bg-secondary">Inactivo</span></td>
                        <td class="text-end">
                            <button class="btn btn-outline-secondary btn-sm">Editar</button>
                            <button class="btn btn-outline-success btn-sm">Activar</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="mt-3">
            <a href="Encargado.aspx" class="btn btn-outline-secondary">Volver</a>
        </div>
    </div>
</asp:Content>
