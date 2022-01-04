<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registro.aspx.cs" Inherits="ProyectoFinalDAM.Registro" %>

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
                        <td>Usuario:&nbsp;&nbsp;&nbsp;</td>
                        <td><asp:TextBox ID="tbUsername" runat="server" placeholder="username"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>Contraseña:&nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <asp:TextBox ID="tbPassword" runat="server" TextMode="Password" placeholder="password"></asp:TextBox>
                            <asp:ImageButton id="btVer" runat="server" ImageUrl="Resources/Images/ojo_cerrado.png" OnClick="CambiarVisibilidad"/>
                        </td>
                    </tr>
                     <tr>
                        <td>Confirmar:&nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <asp:TextBox ID="tbConfirmacion" runat="server" TextMode="Password" placeholder="confirma password"></asp:TextBox>
                            <asp:ImageButton id="btVerConf" runat="server" ImageUrl="Resources/Images/ojo_cerrado.png" OnClick="CambiarVisibilidadConfirmacion"/>
                        </td>
                    </tr>
                     <tr>
                        <td>Rol:&nbsp;&nbsp;&nbsp;</td>
                        <td><asp:DropDownList ID="dropListRol" runat="server" Rows="2" SelectionMode="Single">
                                <asp:ListItem>Administrador</asp:ListItem>
                                <asp:ListItem>Usuario</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;&nbsp;&nbsp;</td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><asp:Button ID="btIngresar" runat="server" Text="Registrar Usuario" OnClick="Registrar" Width="116px"/></td>
                    </tr>
                </table>
                <div style="margin-left:15px; margin-top: 10px"><asp:Label ID="lbError" runat="server" Text="Error al registrar" Visible="False" ForeColor="Red"></asp:Label></div>
            </asp:Panel>
        </div>
    </form>
</body>
</html>
