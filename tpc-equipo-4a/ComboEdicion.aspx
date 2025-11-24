<%@ Page Title="Editar Combo" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ComboEdicion.aspx.cs" Inherits="tpc_equipo_4a.ComboEdicion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />

    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #ECEFF1;
            color: #424242;
        }

        .main-content {
            padding-top: 2rem;
            padding-bottom: 2rem;
        }

        h1.h2 {
            font-weight: 700;
            color: #1565c0;
        }

        .card {
            border: none;
            border-radius: 1rem;
            box-shadow: 0 0.75rem 1.25rem rgba(0, 0, 0, 0.08);
            overflow: hidden;
            background-color: #ffffff;
        }

        .card-header {
            background-color: #ffffff;
            border-bottom: 1px solid #CFD8DC;
            padding: 1.25rem 1.5rem;
        }

        .card-footer {
            background-color: #ffffff;
            border-top: 1px solid #CFD8DC;
        }

        .form-label {
            font-weight: 500;
            color: #37474F;
        }

        .form-control {
            background-color: #ECEFF1;
            border: none;
            color: #424242;
        }

            .form-control::placeholder {
                color: #757575;
            }

            .form-control:focus {
                background-color: #CFD8DC;
                box-shadow: 0 0 0 0.2rem rgba(33, 150, 243, 0.25);
            }

        .table thead th {
            font-weight: 600;
            color: #1976d2;
            background-color: #e3f2fd;
            text-transform: uppercase;
            font-size: 0.8rem;
            letter-spacing: 0.03rem;
        }

        .table-hover tbody tr:hover {
            background-color: #f5f5f5;
        }

        .table td, .table th {
            vertical-align: middle;
        }

        .btn-primary {
            background-color: #2196F3;
            border-color: #2196F3;
            font-weight: 600;
            color: #fff;
            border-radius: 0.6rem;
            box-shadow: 0 4px 10px rgba(33, 150, 243, 0.3);
            transition: all 0.25s ease-in-out;
        }

            .btn-primary:hover {
                background-color: #1976D2;
                border-color: #1976D2;
                transform: translateY(-2px);
                box-shadow: 0 6px 14px rgba(25, 118, 210, 0.35);
            }

        .btn-outline-secondary {
            border-color: #1976D2;
            color: #1976D2;
            border-radius: 0.6rem;
            font-weight: 500;
        }

            .btn-outline-secondary:hover {
                background-color: #E3F2FD;
                color: #0D47A1;
            }

        .fade-in {
            animation: fadeIn 0.4s ease-in-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>

    <main class="main-content container fade-in">
        <div class="row justify-content-center">
            <div class="col-12 col-lg-10 col-xl-8">
                <div class="card">

                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h1 class="h2 fw-bold d-flex align-items-center gap-2 mb-0">
                            <span class="material-symbols-outlined">fastfood</span>
                            <asp:Label ID="lblTitulo" runat="server" Text="Editar Combo"></asp:Label>
                        </h1>
                    </div>

                    <div class="card-body">
                        <div class="row g-3 mb-3">
                            <div class="col-12 col-md-6">
                                <label for="txtNombre" class="form-label">Nombre</label>
                                <asp:TextBox
                                    ID="txtNombre"
                                    runat="server"
                                    CssClass="form-control"
                                    placeholder="Ej: Combo Doble + Papas"></asp:TextBox>
                            </div>

                            <div class="col-12 col-md-6">
                                <label for="txtDescripcion" class="form-label">Descripción</label>
                                <asp:TextBox
                                    ID="txtDescripcion"
                                    runat="server"
                                    CssClass="form-control"
                                    TextMode="MultiLine"
                                    Rows="3"
                                    placeholder="Detalle del combo"></asp:TextBox>
                            </div>
                        </div>

                        <h6 class="fw-bold mb-2">Productos del combo</h6>
                        <p class="text-muted small mb-3">
                            Indicá la cantidad de cada producto que forma parte del combo.
                        </p>

                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead>
                                    <tr>
                                        <th>Nombre</th>
                                        <th style="width: 110px;">Cantidad</th>
                                        <th>Sector</th>
                                        <th>Min. prep.</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="repProductosCombo" runat="server">
                                        <ItemTemplate>

                                            <asp:HiddenField ID="hfIdProducto" runat="server" Value='<%# Eval("Id") %>' />
                                            <asp:HiddenField ID="hfIdDetalle" runat="server"
                                                Value='<%# ((System.Collections.Generic.List<dominio.ComboDetalle>)Eval("DetallesCombo"))
                                                        .FirstOrDefault(d => d.IdProducto == (int)Eval("Id"))?.Id ?? 0 %>' />

                                            <asp:HiddenField ID="HiddenField1" runat="server"
                                                Value='<%# Eval("Id") %>' />
                                            <asp:HiddenField ID="hfIdComboDetalle" runat="server"
                                                Value='<%#
                                                    ((System.Collections.Generic.List<dominio.ComboDetalle>)Eval("DetallesCombo"))
                                                        .FirstOrDefault(d => d.IdProducto == (int)Eval("Id"))?.Id ?? 0
                                                %>' />

                                            <tr>
                                                <td class="fw-medium">
                                                    <%# Eval("Nombre") %>
                                                </td>

                                                <td>
                                                    <asp:TextBox
                                                        ID="txtCantidad"
                                                        runat="server"
                                                        CssClass="form-control form-control-sm text-end"
                                                        TextMode="Number"
                                                        Min="0"
                                                        Max="99"
                                                        Text='<%# (
                                                            ((System.Collections.Generic.List<dominio.ComboDetalle>)Eval("DetallesCombo"))
                                                                .FirstOrDefault(d => d.IdProducto == (int)Eval("Id"))
                                                            ?.Cantidad ?? 0
                                                        ).ToString() %>' />
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
                        </div>
                    </div>

                    <div class="card-footer d-flex justify-content-end gap-2">
                        <a href="Combo.aspx" class="btn btn-outline-secondary d-flex align-items-center gap-1">
                            <span class="material-symbols-outlined">close</span>
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
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
