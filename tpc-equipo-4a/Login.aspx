<%@ Page Title="Login" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="tpc_equipo_4a.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300..700&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
    <style>
        body {
            font-family: 'Space Grotesk', sans-serif;
        }

        .login-container {
            min-height: 70vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-card {
            max-width: 450px;
            width: 100%;
            border: none;
            border-radius: 0.5rem;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            background-color: #fff;
        }              

        .login-logo {
            width: 250px;
            height: 250px;
            object-fit: cover;
            margin-bottom: 0.5rem;
        }

        .login-title {
            font-weight: 700;
            color: #212529;
            margin-bottom: 0.5rem;
        }

        .login-subtitle {
            color: #6c757d;
            margin-bottom: 2rem;
        }

        .input-group-text {
            background-color: #e9ecef;
            border-right: 0;
            color: #6c757d;
        }

        .input-group .form-control {
            border-left: 0;
        }

        .form-control:focus {
            box-shadow: 0 0 0 0.25rem rgba(242, 127, 13, 0.25);
            border-color: #f27f0d;
        }

        .input-group:focus-within .input-group-text {
            border-color: #f27f0d;
        }

        .btn-primary {
            background-color: #f27f0d;
            border-color: #f27f0d;
            font-weight: 600;
            padding: 0.625rem;
        }

            .btn-primary:hover,
            .btn-primary:focus {
                background-color: #d9700b;
                border-color: #d9700b;
            }

        .btn-toggle-password {
            border-left: 0;
            border-color: #ced4da;
            background-color: transparent;
        }

            .btn-toggle-password:hover {
                background-color: #e9ecef;
            }

        .forgot-password {
            color: #f27f0d;
            text-decoration: none;
            font-size: 0.9rem;
        }

            .forgot-password:hover {
                color: #d9700b;
                text-decoration: underline;
            }

        .error-message {
            color: #dc3545;
            font-size: 0.9rem;
            margin-top: 1rem;
        }

        .footer-text {
            color: #6c757d;
            font-size: 0.8rem;
            margin-top: 2rem;
            margin-bottom: 0;
        }

        .material-icons {
            font-size: 20px;
            vertical-align: middle;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="login-container">
        <div class="login-card card">
            <div class="card-body">

                <div class="text-center mb-4">
                    <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuAm0zAeVp81AvXkJ3yISDanc9DlBHF46toimPfkZq2xJh1lwDxkVd_iOSqdIH9Es-w1X4kaw_1JW4rpdV6eFR6PATQleq22HStxpGmpvpk8uAKDawzjtudL1qUDFoFlRoJvJIonW_TB07YVdriGHIlU5uHM8L4obj5lEQ7RB1uVCtgTkiEyQeiS9BKA8Ej-sUd0wqvSGYqMuOwN1v-oqLRqm6d3VZGb4UlP5BK-ZuqG0FJfd69JaTqSnc_SaM9MFJdacXkDfFG_9jU"
                        alt="Logo"
                        class="login-logo" />
                </div>

                <div class="text-center">
                    <h1 class="h3 login-title">Sistema de Gestión de Comandas</h1>
                    <p class="login-subtitle">Inicio de Sesión</p>
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
                        <button class="btn btn-outline-secondary btn-toggle-password"
                            type="button"
                            id="togglePassword">
                            <i class="material-icons">visibility</i>
                        </button>
                    </div>
                </div>


                <div class="d-grid mt-4">
                    <asp:Button ID="btnLogin" runat="server"
                        CssClass="btn btn-primary"
                        Text="Ingresar" />
                </div>

                <div class="text-center mt-3">
                    <a href="#" class="forgot-password">¿Olvidaste tu contraseña?</a>
                </div>


                <p class="text-center footer-text">
                    © 2025 Equipo 4A - Todos los derechos reservados.
                </p>
            </div>
        </div>
    </div>

    <!-- Script contraseña -->
    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function () {
            const togglePassword = document.querySelector('#togglePassword');
            const password = document.querySelector('#<%= txtPassword.ClientID %>');
            const toggleIcon = togglePassword.querySelector('i');

            if (togglePassword && password) {
                togglePassword.addEventListener('click', function (e) {
                    e.preventDefault();
                    const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
                    password.setAttribute('type', type);
                    toggleIcon.textContent = type === 'password' ? 'visibility' : 'visibility_off';
                });
            }
        });
    </script>
</asp:Content>
