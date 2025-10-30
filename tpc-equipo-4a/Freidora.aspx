<%@ Page Title="Sector Freidora" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Freidora.aspx.cs" Inherits="tpc_equipo_4a.Freidora" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="d-flex">
        <nav class="p-3 border-end bg-white d-flex flex-column justify-content-between" style="width: 260px; min-height: 100vh;">

            <div>
                <div class="d-flex align-items-center mb-4">
                    <div class="rounded-circle bg-warning d-flex align-items-center justify-content-center me-2" style="width: 40px; height: 40px;">
                        🍟
                    </div>
                    <div>
                        <h6 class="m-0 fw-bold">María López</h6>
                        <small class="text-muted">Sector Freidora</small>
                    </div>
                </div>
            </div>
            <div class="mt-auto">
                <div class="card shadow-sm mb-3">
                    <div class="card-body">
                        <h6 class="fw-bold mb-2">Reportar ingrediente</h6>
                        <div class="input-group mb-2">
                            <input type="text" class="form-control" placeholder="Ingrediente..." />
                        </div>
                        <button class="btn btn-warning w-100">Reportar</button>
                    </div>
                </div>

                <a href="Login.aspx" class="btn btn-outline-danger w-100">Cerrar sesión
                </a>
            </div>
        </nav>
        <div class="container-fluid p-4">
            <h4 class="fw-bold mb-4">Sector Freidora</h4>

            <div class="row row-cols-1 row-cols-md-2 g-4">
                <div class="col">
                    <div class="card shadow-sm rounded-4">
                        <div class="card-header d-flex justify-content-between align-items-center bg-warning-subtle text-warning-emphasis rounded-top-4">
                            <h5 class="mb-0">Pedido #220</h5>
                            <small>Hace 2 min</small>
                        </div>
                        <div class="card-body">
                            <p class="fw-semibold mb-2">Productos:</p>
                            <p class="mb-1">1x Papas Fritas</p>
                            <p class="mb-1">+ Cheddar</p>
                            <p class="fw-semibold mt-3 mb-1 text-warning">Comentarios:</p>
                            <p class="mb-0">Sin sal</p>

                            <div class="mt-3 text-end">
                                <button class="btn btn-warning">Pedido Listo</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card shadow-sm rounded-4">
                        <div class="card-header d-flex justify-content-between align-items-center bg-warning-subtle text-warning-emphasis rounded-top-4">
                            <h5 class="mb-0">Pedido #221</h5>
                            <small>Hace 5 min</small>
                        </div>
                        <div class="card-body">
                            <p class="fw-semibold mb-2">Productos:</p>
                            <p class="mb-1">1x Papas Fritas</p>

                            <p class="fw-semibold mt-3 mb-1 text-warning">Comentarios:</p>
                            <p class="mb-0">Salsa barbacoa aparte</p>

                            <div class="mt-3 text-end">
                                <button class="btn btn-warning">Pedido Listo</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card shadow-sm rounded-4">
                        <div class="card-header d-flex justify-content-between align-items-center bg-warning-subtle text-warning-emphasis rounded-top-4">
                            <h5 class="mb-0">Pedido #222</h5>
                            <small>Hace 7 min</small>
                        </div>
                        <div class="card-body">
                            <p class="fw-semibold mb-2">Productos:</p>
                            <p class="mb-1">1x Nuggets (6u)</p>

                            <p class="fw-semibold mt-3 mb-1 text-warning">Comentarios:</p>
                            <p class="mb-0">Extra ketchup</p>

                            <div class="mt-3 text-end">
                                <button class="btn btn-warning">Pedido Listo</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <a href="Cocina.aspx" class="btn btn-outline-secondary mt-4">Volver a Cocina</a>
        </div>
    </div>
</asp:Content>
