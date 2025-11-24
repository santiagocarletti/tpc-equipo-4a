<%@ Page Title="Inicio" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="tpc_equipo_4a.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Inicio - Proyecto Equipo 4A
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>
        .module-card {
            text-decoration: none;
            color: inherit;
            display: block;
            height: 100%;
        }

        .card {
            transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
            border: 1px solid #dee2e6;
            height: 100%;
        }

            .card:hover {
                transform: translateY(-8px);
                box-shadow: 0 0.75rem 1.5rem rgba(0, 0, 0, 0.15);
            }

        .card-icon {
            font-size: 4rem;
            color: var(--bs-primary);
            transition: transform 0.2s ease-in-out;
        }

        .card:hover .card-icon {
            transform: scale(1.1);
        }

        .module-card:hover {
            text-decoration: none;
        }
    </style>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="text-center mb-5">
        <h1 class="display-4 fw-bold">Bienvenido al Sistema de Gestión</h1>
        <p class="col-lg-8 mx-auto fs-5 text-muted">
            Selecciona un módulo para comenzar
        </p>
    </div>


    <div class="row g-4 row-cols-1 row-cols-sm-2 row-cols-lg-3 justify-content-center">


        <div class="col">
            <a href="Cajero.aspx" class="module-card" runat="server">
                <div class="card text-center p-4">
                    <div class="card-body d-flex flex-column align-items-center justify-content-center">
                        <span class="material-symbols-outlined card-icon mb-3">point_of_sale</span>
                        <h5 class="card-title fw-bold mb-3">Cajero</h5>
                        <p class="card-text text-muted">Crea nuevos pedidos y procesa pagos de clientes</p>
                    </div>
                </div>
            </a>
        </div>


        <div class="col">
            <a href="Encargado.aspx" class="module-card" runat="server">
                <div class="card text-center p-4">
                    <div class="card-body d-flex flex-column align-items-center justify-content-center">
                        <span class="material-symbols-outlined card-icon mb-3">supervisor_account</span>
                        <h5 class="card-title fw-bold mb-3">Encargado</h5>
                        <p class="card-text text-muted">Administra productos, pedidos y personal</p>
                    </div>
                </div>
            </a>
        </div>


        <div class="col">
            <a href="Cocina.aspx" class="module-card" runat="server">
                <div class="card text-center p-4">
                    <div class="card-body d-flex flex-column align-items-center justify-content-center">
                        <span class="material-symbols-outlined card-icon mb-3">soup_kitchen</span>
                        <h5 class="card-title fw-bold mb-3">Cocina</h5>
                        <p class="card-text text-muted">Visualiza pedidos entrantes de cocina</p>
                    </div>
                </div>
            </a>
        </div>


        <div class="col">
            <a href="Despacho.aspx" class="module-card" runat="server">
                <div class="card text-center p-4">
                    <div class="card-body d-flex flex-column align-items-center justify-content-center">
                        <span class="material-symbols-outlined card-icon mb-3">takeout_dining</span>
                        <h5 class="card-title fw-bold mb-3">Despacho</h5>
                        <p class="card-text text-muted">Visualiza y gestiona pedidos listos para entregar al cliente</p>
                    </div>
                </div>
            </a>
        </div>


        <div class="col">
            <a href="Orden.aspx" class="module-card" runat="server">
                <div class="card text-center p-4">
                    <div class="card-body d-flex flex-column align-items-center justify-content-center">
                        <span class="material-symbols-outlined card-icon mb-3">receipt_long</span>
                        <h5 class="card-title fw-bold mb-3">Orden</h5>
                        <p class="card-text text-muted">Visualiza el estado de la orden en pantalla</p>
                    </div>
                </div>
            </a>
        </div>

    </div>

    <div class="row mt-5">
        <div class="col-12">
            <div class="card bg-light border-0">
                <div class="card-body text-center py-4">
                    <span class="material-symbols-outlined text-primary" style="font-size: 3rem;">info</span>
                    <h5 class="card-title mt-3 mb-2">¿Necesitas ayuda?</h5>
                    <p class="card-text text-muted mb-0">
                        Cada módulo está diseñado para un rol específico en el sistema de gestión de pedidos.
                        Selecciona el módulo correspondiente a tu función para acceder a sus herramientas.
                    </p>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
