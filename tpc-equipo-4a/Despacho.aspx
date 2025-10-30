<%@ Page Title="Despacho" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Despacho.aspx.cs" Inherits="tpc_equipo_4a.Despacho" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .sidebar {
            width: 250px;
            min-height: 100vh;
            background-color: #fff;
            border-right: 1px solid #dee2e6;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

            .sidebar .nav-link {
                border-radius: 0.375rem;
                color: #333;
                font-weight: 500;
                transition: all 0.2s ease-in-out;
            }

                .sidebar .nav-link:hover {
                    background-color: #f8d7da;
                    color: #dc3545;
                }

                .sidebar .nav-link.active {
                    background-color: #dc3545;
                    color: #fff !important;
                    font-weight: 600;
                }

            .sidebar i {
                font-size: 1.2rem;
            }

        .sidebar-footer {
            margin-top: auto;
            border-top: 1px solid #eee;
            padding-top: 1rem;
        }


        .btn-danger {
            background-color: #dc3545 !important;
            border-color: #dc3545 !important;
        }

        .btn-outline-danger:hover {
            background-color: #dc3545 !important;
            color: #fff !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="d-flex">

        <nav class="sidebar p-3">
            <div>

                <div class="d-flex align-items-center mb-4">
                    <div class="rounded-circle bg-danger text-white d-flex align-items-center justify-content-center me-2" style="width: 40px; height: 40px;">
                        <span class="material-symbols-outlined">outdoor_grill</span>
                    </div>
                    <div>
                        <h6 class="m-0 fw-bold">Ana Lopez</h6>
                        <small class="text-muted">Despacho</small>
                    </div>
                </div>


                <ul class="nav flex-column gap-2">
                    <li><a href="Despacho.aspx" class="nav-link active"><i class="bi bi-truck me-2"></i>Despacho y Bebidas</a></li>
                    <li><a href="DespachoHistorial.aspx" class="nav-link"><i class="bi bi-clock-history me-2"></i>Historial</a></li>
                </ul>
            </div>

            <div class="sidebar-footer">
                <div class="card p-3 mb-3 shadow-sm">
                    <h6 class="fw-bold mb-2">Reportar ingrediente</h6>
                    <div class="input-group mb-2">
                        <input type="text" class="form-control" placeholder="Ingrediente:" />
                    </div>
                    <button class="btn btn-danger w-100">Reportar</button>
                </div>

                <a href="Login.aspx" class="btn btn-outline-danger w-100">
                    <i class="bi bi-box-arrow-right me-1"></i>Cerrar sesión
                </a>
            </div>
        </nav>


        <div class="container-fluid p-4">
            <h4 class="fw-bold mb-4">Despacho y Bebidas</h4>

            <div class="row row-cols-1 row-cols-md-2 g-4">

                <div class="col">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <h5 class="fw-bold">Pedido #125</h5>
                                <small class="text-muted">Listo hace 5 min</small>
                            </div>
                            <p class="mb-1">1x Burger Clásica <span class="text-success">(Cocina: OK)</span></p>
                            <p class="mb-1">1x Papas Fritas <span class="text-success">(Frituras: OK)</span></p>
                            <p class="fw-bold mt-2 mb-0">Bebidas:</p>
                            <p class="mb-0">
                                1x Coca-Cola<br />
                                1x Agua sin Gas
                            </p>
                            <p class="mt-2 text-muted">Cliente: Ana Pérez</p>

                            <div class="d-flex gap-2 mt-3">
                                <button class="btn btn-danger flex-fill">Llamar cliente</button>
                                <button class="btn btn-outline-danger flex-fill">Despachado</button>
                            </div>
                            <p class="text-center mt-2 text-decoration-underline text-secondary" style="cursor: pointer;">Cancelar Pedido</p>
                        </div>
                    </div>
                </div>


                <div class="col">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <h5 class="fw-bold">Pedido #124</h5>
                                <small class="text-muted">Listo hace 8 min</small>
                            </div>
                            <p class="mb-1">2x Doble Queso <span class="text-success">(Cocina: OK)</span></p>
                            <p class="mb-1">1x Aros de Cebolla <span class="text-success">(Frituras: OK)</span></p>
                            <p class="fw-bold mt-2 mb-0">Bebidas:</p>
                            <p class="mb-0">1x Coca-Cola</p>
                            <p class="mt-2 text-muted">Cliente: Marcos López</p>

                            <div class="d-flex gap-2 mt-3">
                                <button class="btn btn-danger flex-fill">Llamar cliente</button>
                                <button class="btn btn-outline-danger flex-fill">Despachado</button>
                            </div>
                            <p class="text-center mt-2 text-decoration-underline text-secondary" style="cursor: pointer;">Cancelar Pedido</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>


