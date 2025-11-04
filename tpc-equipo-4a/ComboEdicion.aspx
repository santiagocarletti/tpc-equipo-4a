<%@ Page Title="Editar Combo" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ComboEdicion.aspx.cs" Inherits="tpc_equipo_4a.ComboEdicion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="container py-4">
        <div class="card mx-auto" style="max-width: 30rem;">
            <div class="card-header">
                <asp:Label ID="lblTitulo" runat="server" Text="Editar Combo"></asp:Label>
            </div>

            <div class="card-body">
                <div class="mb-3">
                    <label for="txtNombre" class="form-label">Nombre</label>
                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Ej: Combo Doble + Papas"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label for="txtDescripcion" class="form-label">Descripción</label>
                    <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Detalle del combo"></asp:TextBox>
                </div>

                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-primary" OnClick="btnGuardar_Click" />
                <a href="Combo.aspx" class="btn btn-outline-secondary">Cancelar</a>
            </div>
        </div>
    </div>
</asp:Content>
