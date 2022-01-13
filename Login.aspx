<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ProyectoFinalDAM.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Panel ID="Panel1" runat="server" Height="270px" style="margin-left: auto; margin-right:auto;
                    background-color: #FFFFCC; border: thin double #808080" Width="450px" >
                <br />
                <div style="width:fit-content">
                    &nbsp;<img src="Resources/Images/SplashBT_Logo.png" alt="Splash Logo" style="margin-left:100px;"/></div>
                <table style="position: relative; margin-left: auto; margin-right:auto;">
                    <tr>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>Usuario:&nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <asp:TextBox ID="tbUsername" runat="server" placeholder="username"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>Contraseña:&nbsp;&nbsp;&nbsp;</td>
                        <td><asp:TextBox ID="tbPassword" runat="server" TextMode="Password" placeholder="password"></asp:TextBox></td>
                        <td><asp:ImageButton id="btVer" runat="server" ImageUrl="Resources/Images/ojo_cerrado.png" OnClick="CambiarVisibilidad"/></td>
                    </tr>
                    <tr>
                        <td>&nbsp;&nbsp;&nbsp;</td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><asp:Button ID="btIngresar" runat="server" Text="INGRESAR" OnClick="Entrar" Width="116px"/></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbError" runat="server" Text="Error al ingresar" Visible="False" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </div>
    </form>
</body>
</html>
