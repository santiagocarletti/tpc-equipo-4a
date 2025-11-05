<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="UsuarioEdicion.aspx.cs" Inherits="tpc_equipo_4a.UsuarioEdicion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
        <div class="card mx-auto" style="max-width: 30rem;">
            <div class="card-header">
                <asp:Label ID="lblTitulo" runat="server" Text="Editar Usuario"></asp:Label>
            </div>

            <div class="card-body">
                <div class="mb-3">
                    <label for="txtNombreUsuario" class="form-label">Nombre</label>
                    <asp:TextBox ID="txtNombreUsuario" runat="server" CssClass="form-control" placeholder="Inserte nombre del usuario"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label for="ddlRol" class="form-label">Rol</label>
                    <asp:DropDownList ID="ddlRol" runat="server" CssClass="form-select"></asp:DropDownList>
                </div>

                <div class="mb-3">
                    <label for="txtContraseña" class="form-label">Contraseña</label>
                    <asp:TextBox ID="txtContraseña" runat="server" CssClass="form-control" placeholder="Inserte la nueva contraseña"></asp:TextBox>
                </div>

                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-primary" OnClick="btnGuardar_Click" />
                <a href="Usuario.aspx" class="btn btn-outline-secondary">Cancelar</a>
            </div>
        </div>
    </div>
</asp:Content>
