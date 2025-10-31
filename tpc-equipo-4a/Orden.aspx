<%@ Page Title="Estado de la Orden" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Orden.aspx.cs" Inherits="tpc_equipo_4a.Orden" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Estado de la Orden - Proyecto Equipo 4A
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;700;900&display=swap" rel="stylesheet"/>
    
    <style>
        
        :root {
            --order-primary: #f27f0d;
            --order-bg: #f8f7f5;
            --order-text: #1c140d;
            --order-brown: #9c7349;
        }
                
        .display-order {
            font-family: 'Space Grotesk', sans-serif;
            font-weight: 900;
            letter-spacing: -0.05em;
        }        
       
        .card-preparacion {
            background-color: #f2eadd;
            border: none;
            transition: transform 0.2s ease;
        }
        
        .card-preparacion:hover {
            transform: translateY(-5px);
        }
                
        .card-lista {
            background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
            border: none;
            transition: transform 0.2s ease;
        }
        
        .card-lista:hover {
            transform: translateY(-5px);
        }
                
        .badge-preparacion {
            background-color: rgba(255, 255, 255, 0.5);
            color: var(--order-primary);
            text-transform: uppercase;
            letter-spacing: 0.1em;
            font-weight: 700;
        }
        
        .badge-lista {
            background-color: rgba(255, 255, 255, 0.7);
            color: #198754;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            font-weight: 700;
        }
                
        .section-title {
            letter-spacing: 0.2em;
            color: var(--order-brown);
            text-transform: uppercase;
        }        
        
        .order-number {
            font-size: 4.5rem;
            font-weight: 900;
            line-height: 1;
        }
                
        .order-status {
            font-size: 1.25rem;
            font-weight: 700;
            margin: 0;
        }
              
        
        @keyframes pulse {
            0%, 100% {
                box-shadow: 0 0 0 0 rgba(25, 135, 84, 0.4);
            }
            50% {
                box-shadow: 0 0 0 10px rgba(25, 135, 84, 0);
            }
        }
        
        .card-lista {
            animation: pulse 2s infinite;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="text-center mb-5">
        <h2 class="h3 fw-bold section-title">Estado de las Órdenes</h2>
    </div>
    
    
    <div class="row g-4">
        
        <!-- Orden #123 - En Preparación -->
        <div class="col-sm-6 col-lg-4 col-xl-3">
            <div class="card card-preparacion text-center shadow-sm">
                <div class="card-body p-4">
                    <p class="order-number display-order mb-3">#123</p>
                    <div class="badge-preparacion rounded-3 p-3">
                        <p class="order-status mb-0">En preparación</p>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Orden #124 - Listo para Retirar -->
        <div class="col-sm-6 col-lg-4 col-xl-3">
            <div class="card card-lista text-center shadow-sm">
                <div class="card-body p-4">
                    <p class="order-number display-order text-success mb-3">#124</p>
                    <div class="badge-lista rounded-3 p-3">
                        <p class="order-status mb-0">Listo para retirar</p>
                    </div>
                </div>
            </div>
        </div>
                  
                
    </div>
    
    
    <div class="text-center mt-5 pt-4">
        <p class="text-muted">Gracias por elegirnos.</p>
    </div>
</asp:Content>
