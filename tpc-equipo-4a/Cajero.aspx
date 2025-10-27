<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Cajero.aspx.cs" Inherits="tpc_equipo_4a.Cajero" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Cajero - Proyecto Equipo 4A
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">    
    <style>
        .pedido-card { border-left: 4px solid var(--bs-primary); }
    </style>
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Soy el panel de Cajero</h2>
    <div class="row">
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h5>Soy un nuevo Pedido</h5>                    
                </div>
            </div>
        </div>
    </div>
</asp:Content>