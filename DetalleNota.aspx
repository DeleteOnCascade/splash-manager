<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleNota.aspx.cs" Inherits="ProyectoFinalDAM.DetalleNota" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="lbUsername" runat="server" Text=""></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btLogout" runat="server" Text="SALIR" OnClick="SalirLogout" />
        </div>
        <div>
            <asp:Label runat="server" text="" id="lbIdNota"></asp:Label>
        </div>
        <br />

        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

        <div class="extender">
            <table class="extender">
                <tr>
                    <th><asp:Label ID="lb_id_nota" runat="server" Text=""></asp:Label></th>
                    <th><asp:TextBox ID="tbDescripcion" runat="server" Text="" TextMode="MultiLine"></asp:TextBox></th>
                    <th><asp:Label ID="lb_fchCreacion" runat="server" Text=""></asp:Label></th>
                    <th><asp:Label ID="lbUsuario" runat="server" Text=""></asp:Label></th>
                    <th><asp:Label ID="lb_id_incidencia" runat="server" Text=""></asp:Label></th>
                </tr>
                <tr>
                    <asp:Button ID="btEditarNota" runat="server" Text="Editar" OnClick="EditarNota"/>
                    <asp:Button ID="btEliminarNota" runat="server" Text="Eliminar" OnClick="EliminarNota"/>
                </tr>
            </table>
        </div>

        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    </form>
</body>
</html>
