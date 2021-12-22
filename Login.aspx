<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ProyectoFinalDAM.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            height: 26px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <asp:Panel ID="Panel1" runat="server" Height="171px" style="margin-left: auto; margin-right:auto; background-color: #FFFFCC; border: thin double #808080" Width="543px" >
                <br />
                <br />
                <table style="position: relative; margin-left: auto; margin-right:auto;">
                    <tr>
                        <th>Usuario</th>
                        <th width ="100"></th>
                        <th>Contraseña</th>
                    </tr>
                    <tr>
                        <td class="auto-style1"><asp:TextBox ID="tbUsername" runat="server" placeholder="username"></asp:TextBox></td>
                        <td class="auto-style1"></td>
                        <td class="auto-style1"><asp:TextBox ID="tbPassword" runat="server" TextMode="Password" placeholder="password"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>&nbsp;&nbsp; &nbsp;</td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><asp:Button ID="btIngresar" runat="server" Text="INGRESAR" OnClick="btIngresar_Click" Width="116px"/></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbError" runat="server" Text="Error al ingresar" Visible="False" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                </table>
                <br />
                <br />
            </asp:Panel>

        </div>
    </form>
</body>
</html>
