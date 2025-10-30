<%@ Page Title="Historial Despacho" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="DespachoHistorial.aspx.cs" Inherits="tpc_equipo_4a.DespachoHistorial" %>

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

        .card {
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

            .card:hover {
                transform: translateY(-4px);
                box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
            }

        .badge-success {
            background-color: #28a745;
        }

        .badge-danger {
            background-color: #dc3545;
        }

        .badge-warning {
            background-color: #ffc107;
        }

        .status {
            font-weight: 600;
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
                    <li><a href="Despacho.aspx" class="nav-link"><i class="bi bi-truck me-2"></i>Despacho y Bebidas</a></li>
                    <li><a href="DespachoHistorial.aspx" class="nav-link active"><i class="bi bi-clock-history me-2"></i>Historial</a></li>
                </ul>
            </div>


            <div class="sidebar-footer">
                <div class="card p-3 mb-3 shadow-sm">
                    <h6 class="fw-bold mb-2">Filtro rapido</h6>
                    <div class="input-group mb-2">
                        <input type="text" class="form-control" placeholder="Nro. Pedido:" />
                    </div>
                    <button class="btn btn-danger w-100">Filtrar</button>
                </div>
                <a href="Login.aspx" class="btn btn-outline-danger w-100">
                    <i class="bi bi-box-arrow-right me-1"></i>Cerrar sesión
                </a>
            </div>
        </nav>


        <div class="container-fluid p-4">
            <h4 class="fw-bold mb-4">Historial de Pedidos Despachados</h4>

            <div class="row row-cols-1 row-cols-md-2 g-4">

                <div class="col">
                    <div class="card shadow-sm border-success">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <h5 class="fw-bold mb-0">Pedido #118</h5>
                                <span class="badge badge-success text-white">Despachado</span>
                            </div>
                            <small class="text-muted">Hace 45 minutos</small>

                            <hr class="my-2" />
                            <p class="mb-1">1x Doble Queso <span class="text-success">(Cocina OK)</span></p>
                            <p class="mb-1">1x Papas Fritas <span class="text-success">(Frituras OK)</span></p>
                            <p class="fw-bold mt-2 mb-0">Bebidas:</p>
                            <p class="mb-0">1x Sprite</p>

                            <p class="mt-2 text-muted">Cliente: <strong>Juan García</strong></p>
                            <p class="text-muted mb-0"><i class="bi bi-clock me-1"></i>Despachado a las 13:45</p>
                        </div>
                    </div>
                </div>


                <div class="col">
                    <div class="card shadow-sm border-success">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <h5 class="fw-bold mb-0">Pedido #117</h5>
                                <span class="badge badge-success text-white">Despachado</span>
                            </div>
                            <small class="text-muted">Hace 1 hora</small>

                            <hr class="my-2" />
                            <p class="mb-1">2x Burger Clásica <span class="text-success">(Cocina OK)</span></p>
                            <p class="fw-bold mt-2 mb-0">Bebidas:</p>
                            <p class="mb-0">
                                1x Coca-Cola Zero<br />
                                1x Agua sin Gas
                            </p>

                            <p class="mt-2 text-muted">Cliente: <strong>Lucía Torres</strong></p>
                            <p class="text-muted mb-0"><i class="bi bi-clock me-1"></i>Despachado a las 13:15</p>
                        </div>
                    </div>
                </div>


                <div class="col">
                    <div class="card shadow-sm border-success">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <h5 class="fw-bold mb-0">Pedido #116</h5>
                                <span class="badge badge-success text-white">Despachado</span>
                            </div>
                            <small class="text-muted">Hace 2 horas</small>

                            <hr class="my-2" />
                            <p class="mb-1">1x Combo Familiar (4x Hamburguesas + 2x Papas + 4x Bebidas)</p>
                            <p class="fw-bold mt-2 mb-0">Bebidas:</p>
                            <p class="mb-0">2x Coca-Cola, 2x Sprite</p>

                            <p class="mt-2 text-muted">Cliente: <strong>Carlos Díaz</strong></p>
                            <p class="text-muted mb-0"><i class="bi bi-clock me-1"></i>Despachado a las 12:10</p>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

</asp:Content>
