<%@ Page Title="Editar Combo" Language="C#" MasterPageFile="~/MasterPage.Master"
    AutoEventWireup="true" CodeBehind="ComboEdicion.aspx.cs" Inherits="tpc_equipo_4a.ComboEdicion" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Edición de Combo - Equipo 4A
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />

    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #ECEFF1;
        }

        .fade-in {
            animation: fadeIn 0.5s ease-out forwards;
        }

        @keyframes fadeIn {
            0% { opacity: 0; transform: translateY(10px); }
            100% { opacity: 1; transform: translateY(0); }
        }

        .card {
            background-color: #ffffff;
            border: none;
            border-radius: 1rem;
            box-shadow: 0 1rem 2rem rgba(0, 0, 0, 0.1);
            max-width: 900px;
        }

        .card-header {
            background-color: transparent;
            border-bottom: none;
            text-align: center;
            padding-top: 2rem;
        }

        .card-header h5 {
            font-size: 1.8rem;
            font-weight: 700;
            color: #424242;
        }

        .form-control {
            border-radius: 0.75rem;
            border: 1px solid #cfd8dc;
            padding: 0.7rem 1rem;
            background-color: #f8f9fa;
            color: #424242;
        }

        .form-control:focus {
            border-color: #2196F3;
            box-shadow: 0 0 0 0.25rem rgba(33, 150, 243, 0.25);
        }

        .btn-primary {
            background-color: #2196F3;
            border-color: #2196F3;
            border-radius: 0.75rem;
            padding: 0.6rem 1.5rem;
            font-weight: 600;
        }

        .btn-primary:hover {
            background-color: #1976D2;
            border-color: #1976D2;
            transform: translateY(-1px);
        }

        .btn-outline-secondary {
            border-radius: 0.75rem;
            border-color: #1976D2;
            color: #1976D2;
            font-weight: 600;
            padding: 0.6rem 1.2rem;
        }

        .btn-outline-secondary:hover {
            background-color: #E3F2FD;
            color: #0D47A1;
        }

        table > thead > tr > th {
            font-size: 0.9rem;
            color: #424242;
            font-weight: 600;
        }

        .alert {
            border-radius: 0;
        }
    </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container py-5 fade-in d-flex justify-content-center align-items-center" style="min-height: 80vh;">

        <div class="card w-100">

           
            <div class="alert alert-danger d-flex align-items-center mb-0"
                 id="errorMsg" runat="server" visible="false" role="alert">
                <span class="material-symbols-outlined me-2">error</span>
                <span id="errorText" runat="server"></span>
            </div>

            <div class="card-header">
                <h5>
                    <asp:Label ID="lblTitulo" runat="server" Text="Editar Combo"></asp:Label>
                </h5>
            </div>

            <div class="card-body px-5 py-4">

                <div class="mb-3">
                    <label class="form-label">Nombre</label>
                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"
                        placeholder="Ej: Combo Doble + Papas"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label class="form-label">Descripción</label>
                    <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control"
                        TextMode="MultiLine" Rows="3" placeholder="Detalle del combo"></asp:TextBox>
                </div>

                <h6 class="mt-4 mb-2 fw-bold">Productos del Combo</h6>
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Producto</th>
                            <th>Cantidad</th>
                            <th>Sector</th>
                            <th>Grupo</th>
                            <th>Min. Prep</th>
                        </tr>
                    </thead>
                    <tbody>

                        <asp:Repeater ID="repProductosCombo" runat="server">
                            <ItemTemplate>

                                <asp:HiddenField ID="hfIdProducto" runat="server" Value='<%# Eval("Id") %>' />
                                <asp:HiddenField ID="hfIdDetalle" runat="server"
                                    Value='<%# 
                                        ((List<dominio.ComboDetalle>)Eval("DetallesCombo"))
                                            .FirstOrDefault(d => d.IdProducto == (int)Eval("Id"))?.Id ?? 0 
                                    %>' />

                                <tr>
                                    <td class="fw-medium"><%# Eval("Nombre") %></td>

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
                                            ) %>'
                                            Width="70" />
                                    </td>

                                    <td><%# Eval("Sector.Nombre") %></td>
                                    <td><%# Eval("Grupo.Nombre") %></td>
                                    <td><%# Eval("MinutosPreparacion") %></td>
                                </tr>

                            </ItemTemplate>
                        </asp:Repeater>

                    </tbody>
                </table>
            </div>

            <div class="card-footer d-flex justify-content-between align-items-center">
                <a href="Combo.aspx" class="btn btn-outline-secondary">
                    <span class="material-symbols-outlined me-1">arrow_back</span>
                    Cancelar
                </a>

                <asp:Button
                    ID="btnGuardar"
                    runat="server"
                    Text="Guardar"
                    CssClass="btn btn-primary"
                    OnClick="btnGuardar_Click" />
            </div>

        </div>
    </div>

</asp:Content>
