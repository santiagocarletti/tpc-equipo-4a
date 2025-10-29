<%@ Page Title="Cocina" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Cocina.aspx.cs" Inherits="tpc_equipo_4a.Cocina" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Soy el panel de Cocina</h2>
    <div class="container text-center py-5">
        <p class="text-secondary mb-4">Selecciona el sector a visualizar.</p>
        <div class="d-grid gap-3 col-12 col-md-4 mx-auto">
            <a href="Plancha.aspx" class="btn btn-outline-primary">Plancha</a>
            <a href="Freidora.aspx" class="btn btn-outline-primary">Freidora</a>
            <a href="Armado.aspx" class="btn btn-outline-primary">Armado</a>
        </div>
    </div>
</asp:Content>
