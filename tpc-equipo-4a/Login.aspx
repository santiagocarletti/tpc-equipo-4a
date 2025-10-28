<%@ Page Title="Login" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="tpc_equipo_4a.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .login-card {
            max-width: 400px;
            margin: 0 auto;
            border: none;
            border-radius: 1rem;
            box-shadow: 0 0.5rem 1rem rgba(0,0,0,.1);
            background-color: #fff;
        }

        .login-card .card-body {
            padding: 2rem;
        }

        .login-icon {
            font-size: 3rem;
            color: var(--bs-primary);
        }

        .btn-primary {
            width: 100%;
        }

        .form-control {
            border-radius: 0.5rem;
        }

        .form-label {
            font-weight: 500;
        }
        
    </style>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="d-flex justify-content-center align-items-center" style="min-height: 70vh;">
        <div class="card login-card">
            <div class="card-body text-center">
                <div class="mb-4">
                    <span class="material-symbols-outlined login-icon">account_circle</span>
                    <h2 class="fw-bold mt-2">Iniciar Sesión</h2>
                    <p class="text-muted mb-4">Accedé al sistema de gestión del grupo 4A</p>
                </div>

                <div class="text-start">
                    <div class="mb-3">
                        <label for="txtUsuario" class="form-label">Usuario</label>
                        <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control" placeholder="Ingrese su usuario"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="txtPassword" class="form-label">Contraseña</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Ingrese su contraseña"></asp:TextBox>
                    </div>

                    <div class="d-grid mt-4">
                        <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-primary fw-semibold" Text="Ingresar" />
                    </div>

                    <asp:Label ID="lblError" runat="server" CssClass="error-message d-block mt-3 text-center" Visible="false"></asp:Label>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
