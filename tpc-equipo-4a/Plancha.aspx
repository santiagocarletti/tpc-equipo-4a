<%@ Page Title="Sector Plancha" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Plancha.aspx.cs" Inherits="tpc_equipo_4a.Plancha" %>

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

        
        .pedido-card {
            border: 1px solid #dee2e6;
            border-radius: 0.75rem;
            transition: all 0.2s ease-in-out;
        }

        .pedido-card:hover {
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        }

        .pedido-header {
            background-color: #f8d7da;
            color: #dc3545;
            border-bottom: 1px solid #dee2e6;
            border-radius: 0.75rem 0.75rem 0 0;
        }

        .pedido-header h5 {
            margin: 0;
        }

        .pedido-body p {
            margin-bottom: 0.25rem;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="d-flex">
        
        <nav class="sidebar p-3">
            <div>
                
                <div class="d-flex align-items-center mb-4">
                    <div class="rounded-circle bg-danger text-white d-flex align-items-center justify-content-center me-2" style="width:40px; height:40px;">
                        <span class="material-symbols-outlined">outdoor_grill</span>
                    </div>
                    <div>
                        <h6 class="m-0 fw-bold">Juan Pérez</h6>
                        <small class="text-muted">Sector Plancha</small>
                    </div>
                </div>
            </div>

            
            <div class="sidebar-footer">
                <div class="card p-3 shadow-sm">
                    <h6 class="fw-bold mb-2">Reportar ingrediente</h6>
                    <div class="input-group mb-2">
                        <input type="text" class="form-control" placeholder="Ingrediente..." />
                    </div>                    
                    <button class="btn btn-danger w-100">Reportar</button>
                </div>

                <a href="Login.aspx" class="btn btn-outline-danger w-100 mt-3">
                    <i class="bi bi-box-arrow-right me-1"></i> Cerrar sesión
                </a>
            </div>
        </nav>

        
        <div class="container-fluid p-4">
            <h4 class="fw-bold mb-4">Sector Plancha</h4>

            <div class="row row-cols-1 row-cols-md-2 g-4">
                
                <div class="col">
                    <div class="pedido-card shadow-sm">
                        <div class="pedido-header p-3 d-flex justify-content-between align-items-center">
                            <h5 class="fw-bold">Pedido #132</h5>
                            <small>Hace 3 min</small>
                        </div>
                        <div class="pedido-body p-3">
                            <p class="fw-bold mb-2">Productos:</p>
                            <p>1x Hamburguesa Clásica con Queso</p>
                            <p>1x Hamburguesa Doble</p>
                            <p>1x Sin cebolla</p>
                            <p class="fw-bold mt-3 mb-1 text-danger">Comentarios:</p>
                            <p>Cocción a punto medio</p>

                            <div class="mt-3 text-end">
                                <button class="btn btn-danger">Pedido Listo</button>
                            </div>
                        </div>
                    </div>
                </div>

                
                <div class="col">
                    <div class="pedido-card shadow-sm">
                        <div class="pedido-header p-3 d-flex justify-content-between align-items-center">
                            <h5 class="fw-bold">Pedido #131</h5>
                            <small>Hace 6 min</small>
                        </div>
                        <div class="pedido-body p-3">
                            <p class="fw-bold mb-2">Productos:</p>
                            <p>2x Hamburguesa Bacon Deluxe</p>
                            <p>1x Extra queso</p>

                            <p class="fw-bold mt-3 mb-1 text-danger">Comentarios:</p>
                            <p>Carne jugosa</p>

                            <div class="mt-3 text-end">
                                <button class="btn btn-danger">Pedido Listo</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

