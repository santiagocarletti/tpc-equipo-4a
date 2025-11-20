<%@ Page Title="Encargado - Panel de Gestión" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Encargado.aspx.cs" Inherits="tpc_equipo_4a.Encargado" %>

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
                box-shadow: 0 0.5rem 1rem rgba(0,0,0,.15) !important;
            }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="text-center mb-5">
        <h1 class="display-4 fw-bold">Bienvenido, Encargado</h1>
        <p class="col-lg-8 mx-auto fs-5 text-muted">
            Aqui puedes gestionar los productos, combos y usuarios del local.
        </p>
    </div>

    <div class="row g-4 justify-content-center">


        <div class="col-md-6 col-lg-4">
            <a class="text-decoration-none" href="~/Producto.aspx" runat="server">
                <div class="card sector-card h-100 shadow-sm border-0">
                    <div class="card-body text-center p-5 d-flex flex-column justify-content-center align-items-center">
                        <div class="mb-3 text-primary">
                            <span class="material-symbols-outlined">lunch_dining</span>

                        </div>
                        <h2 class="card-title h3 fw-bold">Gestionar Productos</h2>
                        <p class="card-text text-muted">Añade, edita o elimina hamburguesas, bebidas y otros items del menu.</p>
                    </div>
                </div>
            </a>
        </div>


        <div class="col-md-6 col-lg-4">
            <a class="text-decoration-none" href="~/Combo.aspx" runat="server">
                <div class="card sector-card h-100 shadow-sm border-0">
                    <div class="card-body text-center p-5 d-flex flex-column justify-content-center align-items-center">
                        <div class="mb-3 text-primary">
                            <span class="material-symbols-outlined">fastfood</span>
                        </div>
                        <h2 class="card-title h3 fw-bold">Gestionar Combos</h2>
                        <p class="card-text text-muted">Crea y gestiona las ofertas especiales</p>
                    </div>
                </div>
            </a>
        </div>


        <div class="col-md-6 col-lg-4">
            <a class="text-decoration-none" href="~/Usuario.aspx" runat="server">
                <div class="card sector-card h-100 shadow-sm border-0">
                    <div class="card-body text-center p-5 d-flex flex-column justify-content-center align-items-center">
                        <div class="mb-3 text-primary">
                            <span class="material-symbols-outlined">contacts_product</span>
                        </div>
                        <h2 class="card-title h3 fw-bold">Gestion de Usuarios</h2>
                        <p class="card-text text-muted">Administra los perfiles y permisos de los empleados.</p>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-md-6 col-lg-4">
            <a class="text-decoration-none" href="~/Ingrediente.aspx" runat="server">
                <div class="card sector-card h-100 shadow-sm border-0">
                    <div class="card-body text-center p-5 d-flex flex-column justify-content-center align-items-center">
                        <div class="mb-3 text-primary">
                            <span class="material-symbols-outlined">Chef_Hat</span>
                        </div>
                        <h2 class="card-title h3 fw-bold">Gestion de Ingredientes</h2>
                        <p class="card-text text-muted">Administra los ingredientes para cada producto.</p>
                    </div>
                </div>
            </a>
        </div>

    </div>

</asp:Content>
