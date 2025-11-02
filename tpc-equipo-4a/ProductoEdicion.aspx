<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ProductoEdicion.aspx.cs" Inherits="tpc_equipo_4a.ProductoEdicion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <div class="container py-4">
            <div class="card mx-auto" style="max-width: 30rem;">
                <div class="card-header">
                    <asp:Label ID="lblTitulo" runat="server" Text="Editar Producto"></asp:Label>
                </div>

                <div class="card-body">
                    <div class="mb-3">
                        <label for="txtNombre" class="form-label">Nombre</label>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Ej: Hamburguesa Doble"></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <label for="ddlSector" class="form-label">Sector</label>
                        <asp:DropDownList ID="ddlSector" runat="server" CssClass="form-select"></asp:DropDownList>
                    </div>

                    <div class="mb-3">
                        <label for="txtMinutos" class="form-label">Minutos de preparación</label>
                        <asp:TextBox ID="txtMinutos" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                    </div>

                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-primary" OnClick= "btnGuardar_Click" />
                    <a href="Producto.aspx" class="btn btn-outline-secondary">Cancelar</a>
                </div>
            </div>
        </div>

</asp:Content>
