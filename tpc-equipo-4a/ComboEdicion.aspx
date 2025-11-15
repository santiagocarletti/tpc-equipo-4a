<%@ Page Title="Editar Combo" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ComboEdicion.aspx.cs" Inherits="tpc_equipo_4a.ComboEdicion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
        <div class="card mx-auto" style="max-width: 50rem;">
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
                <%--  --%>

                <table class="table table-hover">
                    <thead>
                        <tr>
                            <%--<th>Checked</th>--%>
                            <th>Nombre</th>
                            <th>Cantidad</th>
                            <th>Sector</th>
                            <th>Minutos prep.</th>
                        </tr>
                    </thead>

                    <tbody>
                        <asp:Repeater ID="repProductosCombo" runat="server">
                            <ItemTemplate>

                                <asp:HiddenField ID="hfIdProducto" runat="server" Value='<%# Eval("Id") %>' />
                                <asp:HiddenField ID="hfIdDetalle" runat="server"
                                    Value='<%# ((List<dominio.ComboDetalle>)Eval("DetallesCombo"))
                        .FirstOrDefault(d => d.IdProducto == (int)Eval("Id"))?.Id ?? 0 %>' />


                                <%-- HiddenField para IdProducto --%>
                                <asp:HiddenField ID="HiddenField1" runat="server"
                                    Value='<%# Eval("Id") %>' />

                                <%-- HiddenField para IdComboDetalle (si existe) --%>
                                <asp:HiddenField ID="hfIdComboDetalle" runat="server"
                                    Value='<%# 
                ((List<dominio.ComboDetalle>)Eval("DetallesCombo"))
                    .FirstOrDefault(d => d.IdProducto == (int)Eval("Id"))?.Id ?? 0 
            %>' />

                                <tr>
<%--                                    <td>
                                        <asp:CheckBox
                                            ID="chkSeleccionado"
                                            runat="server"
                                            Checked='<%# ((List<dominio.ComboDetalle>)Eval("DetallesCombo"))
                                .Any(d => d.IdProducto == (int)Eval("Id")) %>' />
                                    </td>--%>

                                    <td class="fw-medium">
                                        <%# Eval("Nombre") %>
                                    </td>

                                    <td>
                                        <asp:TextBox
                                            ID="txtCantidad"
                                            runat="server"
                                            CssClass="form-control form-control-sm"
                                            TextMode="Number"
                                            Min="0"
                                            Max="99"
                                            Text='<%# (
                                ((List<dominio.ComboDetalle>)Eval("DetallesCombo"))
                                    .FirstOrDefault(d => d.IdProducto == (int)Eval("Id"))
                                ?.Cantidad ?? 0
                            ).ToString() %>'
                                            Width="70" />
                                    </td>

                                    <td>
                                        <%# Eval("Sector.Nombre") %>
                                    </td>

                                    <td>
                                        <%# Eval("MinutosPreparacion") %>
                                    </td>

                                </tr>

                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>


                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-primary" OnClick="btnGuardar_Click" />
                <a href="Combo.aspx" class="btn btn-outline-secondary">Cancelar</a>
            </div>
        </div>
    </div>
</asp:Content>
