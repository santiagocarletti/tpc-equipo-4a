<%@ Page Title="Login" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="tpc_equipo_4a.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300..700&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />

    <style>
        body {
            font-family: 'Space Grotesk', sans-serif;
            background-color: #f8f6f6;
        }

        .login-wrapper {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-card {
            max-width: 950px;
            width: 100%;
            border: none;
            border-radius: 1rem;
            overflow: hidden;
            box-shadow: 0 0.75rem 2rem rgba(0, 0, 0, 0.15);
            background-color: #fff;
        }

        .login-left {
            padding: 3rem;
        }

        .login-title {
            font-weight: 900;
            font-size: 2rem;
            color: #1b0e0e;
        }

        .login-subtitle {
            color: rgba(234, 42, 51, 0.8);
            font-size: 1rem;
            margin-bottom: 2rem;
        }

        .form-label {
            font-weight: 500;
            color: #1b0e0e;
        }

        .form-control {
            height: 3.25rem;
            border-radius: 0.5rem;
            padding-left: 2.5rem;
        }

        .form-control:focus {
            border-color: #ea2a33;
            box-shadow: 0 0 0 0.25rem rgba(234, 42, 51, 0.25);
        }

        .btn-primary {
            background-color: #ea2a33;
            border-color: #ea2a33;
            font-weight: 600;
        }

        .btn-primary:hover {
            background-color: #c9232b;
            border-color: #c9232b;
        }

        .error-message {
            color: #dc3545;
            font-size: 0.9rem;
            margin-top: 1rem;
        }

        .login-right {
            background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuBfTTqpbfiKHuxxHeIyCcL9A4HXut_rRD4QolocOejLbbgryJpzWMR9rgAKfZ1RO2YnKTlZlo0zL4SP5eKVMJwXxStdA6Op24-7VIxp28oth-uXAC-SH8SLzZStP67Zq2S-UI3wB3BwkDpF_HmCaAqB_QiVXnXpmVcLZ48DxI7pYY_FD4gWE85ve6-QERY3duV2K0KlAYz891MAvtx8YggsYvP1oqtz4GPQthOAlPEPvFczHeENi7wCTplC02E2gGG7v9Jhczz0oCM');
            background-size: cover;
            background-position: center;
            display: none;
        }

        @media (min-width: 768px) {
            .login-right {
                display: block;
            }
        }

        .brand-icon {
            font-size: 3.5rem;
            color: #ea2a33;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="login-wrapper">
        <div class="login-card row g-0">

            
            <div class="col-md-6 login-left d-flex flex-column justify-content-center">
                <div class="text-center mb-4">
                    <span class="material-icons brand-icon">fastfood</span>
                    <h2 class="mt-2 fw-bold">Equipo 4A</h2>
                </div>

                <div class="mb-4 text-center">
                    <h3 class="login-title">Acceso Interno</h3>
                    <p class="login-subtitle">Bienvenido de vuelta</p>
                </div>

                <div class="mb-3">
                    <label for="txtUsuario" class="form-label">Usuario</label>
                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="material-icons">person</i>
                        </span>
                        <asp:TextBox ID="txtUsuario" runat="server"
                            CssClass="form-control"
                            placeholder="Ingresa tu usuario">
                        </asp:TextBox>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="txtPassword" class="form-label">Contraseña</label>
                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="material-icons">lock</i>
                        </span>
                        <asp:TextBox ID="txtPassword" runat="server"
                            CssClass="form-control"
                            TextMode="Password"
                            placeholder="Ingresa tu contraseña">
                        </asp:TextBox>
                    </div>
                </div>

                <div class="d-grid mt-4">
                    <asp:Button ID="btnLogin" runat="server" 
                        CssClass="btn btn-primary btn-lg" 
                        Text="Ingresar" 
                        OnClick="btnLogin_Click" />
                </div>

                <asp:Label ID="lblError" runat="server" CssClass="error-message d-block text-center" Visible="false"></asp:Label>

                <p class="text-center mt-5 mb-0 text-muted small">
                    © 2025 Equipo 4A sistema de gestión.
                </p>
            </div>
            
            <div class="col-md-6 login-right"></div>
        </div>
    </div>
</asp:Content>
