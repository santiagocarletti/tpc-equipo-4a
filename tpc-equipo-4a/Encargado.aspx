<%@ Page Title="Encargado - Panel de Gestión" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Encargado.aspx.cs" Inherits="tpc_equipo_4a.Encargado" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Encargado - Panel de Gestión
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>
        .product-card {
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        
        .quantity-control {
            width: 60px;
        }
        
        .order-item {
            background-color: #f8f9fa;
            border-radius: 8px;
        }
        
        .modification-btn {
            font-size: 0.875rem;
        }

        .admin-section {
            background: #17a34a;
            border-radius: 12px;
            padding: 2rem;
            color: white;
            margin-bottom: 2rem;
        }

        .admin-btn:hover {            
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">    
    
    <div class="admin-section">
        <div class="row align-items-center">
            <div class="col-md-4">
                <h2 class="mb-2">Panel de Encargado</h2>
                <p class="mb-0 opacity-75">Gestión y administración del sistema</p>
            </div>
            <div class="col-md-8">
                <div class="row g-3">
                    <div class="col-md-4">
                        <asp:Button ID="btnGestionProductos" runat="server" 
                                    CssClass="btn btn-light w-100 admin-btn"
                                    Text="Gestionar Productos" 
                                    PostBackUrl="~/Producto.aspx" />
                    </div>
                    <div class="col-md-4">
                        <asp:Button ID="btnGestionCombos" runat="server" 
                                    CssClass="btn btn-light w-100 admin-btn"
                                    Text="Gestionar Combo"
                                    PostBackUrl="~/Combo.aspx" />
                    </div>
                    <div class="col-md-4">
                        <asp:Button ID="btnGestionUsuarios" runat="server" 
                                    CssClass="btn btn-light w-100 admin-btn"
                                    Text="Gestionar Usuarios" 
                                    PostBackUrl="~/Usuario.aspx" />
                    </div>
                </div>
            </div>
        </div>
    </div>
       
    <div class="row g-4">        
       
        <div class="col-lg-7">        
        
            <div class="card mb-4">
                <div class="card-body">
                    
                    <div class="input-group mb-3">
                        <span class="input-group-text">
                            <span class="material-symbols-outlined">search</span>
                        </span>
                        <asp:TextBox ID="txtBuscar" runat="server" 
                                     CssClass="form-control" 
                                     placeholder="Buscar productos"></asp:TextBox>
                    </div>
                    
                    
                    <div class="d-flex flex-wrap gap-2">
                        <asp:Button ID="btnCatCombos" runat="server" 
                                    Text="Combos" 
                                    CssClass="btn btn-outline-primary rounded-pill" />
                        <asp:Button ID="btnCatHamburguesas" runat="server" 
                                    Text="Hamburguesas" 
                                    CssClass="btn btn-primary rounded-pill" />
                        <asp:Button ID="btnCatPapas" runat="server" 
                                    Text="Papas" 
                                    CssClass="btn btn-outline-primary rounded-pill" />
                        <asp:Button ID="btnCatBebidas" runat="server" 
                                    Text="Bebidas" 
                                    CssClass="btn btn-outline-primary rounded-pill" />
                    </div>
                </div>
            </div>
            
           
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-xl-4 g-3">
                
                
                <div class="col">
                    <div class="card h-100 product-card">
                        <div class="card-body text-center">
                            <h5 class="card-title mb-3">Classic Burger</h5>
                            
                            <asp:Button ID="btnAgregar1" runat="server" 
                                        Text="Añadir" 
                                        CssClass="btn btn-primary btn-sm w-100" />
                        </div>
                    </div>
                </div>

                
                <div class="col">
                    <div class="card h-100 product-card">
                        <div class="card-body text-center">
                            <h5 class="card-title mb-3">Cheeseburger</h5>
                            
                            <asp:Button ID="btnAgregar2" runat="server" 
                                        Text="Añadir" 
                                        CssClass="btn btn-primary btn-sm w-100" />
                        </div>
                    </div>
                </div>

                
                <div class="col">
                    <div class="card h-100 product-card">
                        <div class="card-body text-center">
                            <h5 class="card-title mb-3">Bacon Burger</h5>
                            
                            <asp:Button ID="btnAgregar3" runat="server" 
                                        Text="Añadir" 
                                        CssClass="btn btn-primary btn-sm w-100" />
                        </div>
                    </div>
                </div>
                 
            </div>
            
        </div>
                
        <div class="col-lg-5">
            <div class="card sticky-top" style="top: 100px;">
                
                
                <div class="card-header bg-white">
                    <h4 class="mb-0">Pedido Actual</h4>
                </div>
                
                
                <div class="card-body" style="max-height: 500px; overflow-y: auto;">
                    
                    <!-- Pedido 1-->
                    <div class="order-item p-3 mb-3">
                        
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <h6 class="mb-0 fw-semibold">Classic Burger</h6>                             
                            <span class="fw-semibold">#A103</span>
                        </div>
                                                
                        
                        <div class="d-flex align-items-center mt-2 gap-2">
                            <div class="btn-group btn-group-sm">
                                <asp:Button ID="btnRestar1" runat="server" 
                                            Text="-" 
                                            CssClass="btn btn-outline-secondary" />
                                <asp:Button ID="btnCantidad1" runat="server" 
                                            Text="2" 
                                            CssClass="btn btn-outline-secondary quantity-control" 
                                            Enabled="false" />
                                <asp:Button ID="btnSumar1" runat="server" 
                                            Text="+" 
                                            CssClass="btn btn-outline-secondary" />
                            </div>
                            <asp:LinkButton ID="btnEliminar1" runat="server" 
                                            CssClass="btn btn-link text-danger p-0 ms-auto">
                                <span class="material-symbols-outlined">delete</span>
                            </asp:LinkButton>
                        </div>
                        
                        
                        <div class="mt-3">
                            <p class="small fw-semibold mb-2">Modificaciones</p>
                            <div class="d-flex flex-wrap gap-2">
                                <button type="button" class="btn btn-sm btn-outline-secondary rounded-pill modification-btn">
                                    Sin cebolla
                                </button>
                                <button type="button" class="btn btn-sm btn-outline-secondary rounded-pill modification-btn">
                                    Sin sal
                                </button> 
                                <button type="button" class="btn btn-sm btn-outline-secondary rounded-pill modification-btn">
                                    Sin aderezos
                                </button> 
                            </div>
                        </div>
                        
                        
                        <div class="mt-3">
                            <p class="small fw-semibold mb-2">Extras</p>
                            <div class="d-flex flex-wrap gap-2">
                                <button type="button" class="btn btn-sm btn-outline-primary rounded-pill modification-btn">
                                    Extra queso
                                </button>
                                <button type="button" class="btn btn-sm btn-outline-primary rounded-pill modification-btn">
                                    Extra carne
                                </button> 
                                <button type="button" class="btn btn-sm btn-outline-primary rounded-pill modification-btn">
                                    Extra Bacon
                                </button>
                            </div>
                        </div>
                        
                        
                        <div class="mt-3">
                            <asp:TextBox ID="txtComentarios1" runat="server" 
                                         TextMode="MultiLine" 
                                         Rows="2" 
                                         CssClass="form-control form-control-sm"
                                         placeholder="Comentarios adicionales"></asp:TextBox>
                        </div>
                    </div>

                    <!-- Pedido 2-->
                    <div class="order-item p-3 mb-3">
                        
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <h6 class="mb-0 fw-semibold">Bacon Burger</h6>
                            <span class="fw-semibold">#A110</span>
                        </div>
                        
                
                        <div class="d-flex align-items-center mt-2 gap-2">
                            <div class="btn-group btn-group-sm">
                                <asp:Button ID="btnRestar2" runat="server" 
                                            Text="-" 
                                            CssClass="btn btn-outline-secondary" />
                                <asp:Button ID="btnCantidad2" runat="server" 
                                            Text="1" 
                                            CssClass="btn btn-outline-secondary quantity-control" 
                                            Enabled="false" />
                                <asp:Button ID="btnSumar2" runat="server" 
                                            Text="+" 
                                            CssClass="btn btn-outline-secondary" />
                            </div>
                            <asp:LinkButton ID="btnEliminar2" runat="server" 
                                            CssClass="btn btn-link text-danger p-0 ms-auto">
                                <span class="material-symbols-outlined">delete</span>
                            </asp:LinkButton>
                        </div>
                        
                
                        <div class="mt-3">
                            <p class="small fw-semibold mb-2">Modificaciones</p>
                            <div class="d-flex flex-wrap gap-2">
                                <button type="button" class="btn btn-sm btn-outline-secondary rounded-pill modification-btn">
                                    Sin cebolla
                                </button>
                                <button type="button" class="btn btn-sm btn-outline-secondary rounded-pill modification-btn">
                                    Sin sal
                                </button>
                                <button type="button" class="btn btn-sm btn-outline-secondary rounded-pill modification-btn">
                                    Sin aderezos
                                </button>  
                            </div>
                        </div>
                       
                
                        <div class="mt-3">
                            <p class="small fw-semibold mb-2">Extras</p>
                            <div class="d-flex flex-wrap gap-2">
                                <button type="button" class="btn btn-sm btn-outline-primary rounded-pill modification-btn">
                                    Extra queso
                                </button>
                                <button type="button" class="btn btn-sm btn-outline-primary rounded-pill modification-btn">
                                    Extra carne
                                </button>  
                                <button type="button" class="btn btn-sm btn-outline-primary rounded-pill modification-btn">
                                    Extra bacon
                                </button>
                            </div>
                        </div>
                                                
                        <div class="mt-3">
                            <asp:TextBox ID="txtComentarios2" runat="server" 
                                         TextMode="MultiLine" 
                                         Rows="2" 
                                         CssClass="form-control form-control-sm"
                                         placeholder="Comentarios adicionales"></asp:TextBox>
                        </div>
                    </div>
                    
                </div>
                                
                <div class="card-footer bg-white">                
                    <div class="d-grid gap-2">
                        <asp:Button ID="btnConfirmarPedido" runat="server" 
                                    Text="Confirmar Pedido" 
                                    CssClass="btn btn-primary btn-lg" />
                        <div class="row g-2">
                            <div class="col">
                                <asp:Button ID="btnCancelar" runat="server" 
                                            Text="Cancelar" 
                                            CssClass="btn btn-outline-danger w-100" />
                            </div>
                            <div class="col">
                                <asp:Button ID="btnLimpiar" runat="server" 
                                            Text="Limpiar" 
                                            CssClass="btn btn-outline-secondary w-100" />
                            </div>
                        </div>
                    </div>
                </div>
                
            </div>
        </div>
        
    </div>
</asp:Content>