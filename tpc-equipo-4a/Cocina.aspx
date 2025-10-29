<%@ Page Title="Cocina" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="Cocina.aspx.cs" Inherits="tpc_equipo_4a.Cocina" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .sector-card .material-symbols-outlined {
            font-size: 3rem;
            line-height: 1;
        }
        .sector-card {
            transition: all 0.2s ease-in-out;
        }
        .sector-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0.5rem 1rem rgba(0,0,0,.15)!important;
        }
    </style>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="text-center mb-5">
        <h1 class="display-4 fw-bold">Gestión de Cocina</h1>
        <p class="col-lg-8 mx-auto fs-5 text-muted">
            Selecciona el sector de la cocina que deseas gestionar para ver los pedidos pendientes.
        </p>
    </div>

    <div class="row g-4 justify-content-center">

        
        <div class="col-md-6 col-lg-4">
            <a class="text-decoration-none" href="~/Plancha.aspx" runat="server">
                <div class="card sector-card h-100 shadow-sm border-0">
                    <div class="card-body text-center p-5 d-flex flex-column justify-content-center align-items-center">
                        <div class="mb-3 text-primary">
                            <span class="material-symbols-outlined">outdoor_grill</span>
                        </div>
                        <h2 class="card-title h3 fw-bold">Plancha</h2>
                        <p class="card-text text-muted">Pedidos de burgers y combos a la parrilla.</p>
                    </div>
                </div>
            </a>
        </div>

        
        <div class="col-md-6 col-lg-4">
            <a class="text-decoration-none" href="~/Freidora.aspx" runat="server">
                <div class="card sector-card h-100 shadow-sm border-0">
                    <div class="card-body text-center p-5 d-flex flex-column justify-content-center align-items-center">
                        <div class="mb-3 text-primary">
                            <span class="material-symbols-outlined">oven</span>
                        </div>
                        <h2 class="card-title h3 fw-bold">Freidora</h2>
                        <p class="card-text text-muted">Pedidos de papas fritas y otros.</p>
                    </div>
                </div>
            </a>
        </div>

        
        <div class="col-md-6 col-lg-4">
            <a class="text-decoration-none" href="~/Armado.aspx" runat="server">
                <div class="card sector-card h-100 shadow-sm border-0">
                    <div class="card-body text-center p-5 d-flex flex-column justify-content-center align-items-center">
                        <div class="mb-3 text-primary">
                            <span class="material-symbols-outlined">timer</span>
                        </div>
                        <h2 class="card-title h3 fw-bold">Armado</h2>
                        <p class="card-text text-muted">Armado final de combos y pedidos.</p>
                    </div>
                </div>
            </a>
        </div>

    </div>

</asp:Content>
