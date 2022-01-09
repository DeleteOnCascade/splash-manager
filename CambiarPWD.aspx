<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CambiarPWD.aspx.cs" Inherits="ProyectoFinalDAM.CambiarPWD" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Panel ID="Panel1" runat="server" Height="320px" style="margin-left: auto; margin-right:auto; background-color: #FFFFCC; border: thin double #808080" Width="450px" >
                <br />
                <div style="width:fit-content">
                    &nbsp;<img src="Resources/Images/SplashBT_Logo.png" alt="Splash Logo" style="margin-left:100px;"/></div>
                <table style="position: relative; margin-left: auto; margin-right:auto;">
                    <tr>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>Contraseña antigua:&nbsp;&nbsp;&nbsp;</td>
                        <td><asp:TextBox ID="tbAntigua" runat="server" TextMode="Password" placeholder="password antigua"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>Nueva contraseña:&nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <asp:TextBox ID="tbPassword" runat="server" TextMode="Password" placeholder="nueva password"></asp:TextBox>
                            
                        </td>
                    </tr>
                     <tr>
                        <td>Confirmar contraseña:&nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <asp:TextBox ID="tbConfirmacion" runat="server" TextMode="Password" placeholder="confirma password"></asp:TextBox>
                            
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;&nbsp;&nbsp;</td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><asp:Button ID="btCambiar" runat="server" Text="Cambiar contraseña" OnClick="CambiarPassword" Width="140px"/></td>
                        <td><asp:Button ID="btVolver" runat="server" Text="Volver" OnClick="Volver" Width="100px"/></td>
                    </tr>
                </table>
                <div style="margin-left:15px; margin-top: 10px"><asp:Label ID="lbError" runat="server" Text="Error al actualizar" Visible="False" ForeColor="Red"></asp:Label></div>
            </asp:Panel>
        </div>
    </form>
</body>
</html>
