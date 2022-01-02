<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistroIncidencia.aspx.cs" Inherits="ProyectoFinalDAM.RegistroIncidencia" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="/Style/EstiloGeneral.css"/>
</head>
<body>
    <form id="form1" runat="server">
        <div style="height:auto">
            <div>
                <asp:Label ID="lbUsername" runat="server" Text=""></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </div>
                
            <asp:Panel ID="Panel1" runat="server" style="height:auto" class="extender">
                <table class="extender">
                    <tr><th></th> </tr>
                    <tr>
                        <th><asp:Label ID="lbCategoria" runat="server" Text="Categoria"></asp:Label></th>
                        <th><asp:DropDownList ID="dropListCategoria" runat="server" Rows="5" SelectionMode="Single">
                                <asp:ListItem>Incidencia</asp:ListItem>
                                <asp:ListItem>Petición</asp:ListItem>
                            </asp:DropDownList></th>
                    </tr>
                    <tr><th></th> </tr>
                    <tr>
                        <th><asp:Label ID="lbPrioridad" runat="server" Text="Prioridad"></asp:Label></th>
                        <th> 
                            <asp:DropDownList ID="dropListPrioridad" runat="server" Rows="5" SelectionMode="Single">
                                <asp:ListItem>Baja</asp:ListItem>
                                <asp:ListItem>Media</asp:ListItem>
                                <asp:ListItem>Alta</asp:ListItem>
                                <asp:ListItem>Muy Alta</asp:ListItem>
                                <asp:ListItem>Inmediata</asp:ListItem>
                            </asp:DropDownList>
                        </th>
                    </tr>
                    <tr><th></th> </tr>
                    <tr>
                        <th><asp:Label ID="lbMotivo" runat="server" Text="Resumen"></asp:Label></th>
                        <th><asp:TextBox ID="tbMotivo" runat="server" Width="851px"></asp:TextBox></th>
                    </tr>
                    <tr><th></th> </tr>
                    <tr>
                        <th><asp:Label ID="lbDescripcion" runat="server" Text="Descripción"></asp:Label></th>
                        <th><asp:TextBox ID="tbDescripcion" runat="server" Height="149px" TextMode="MultiLine" Width="848px"></asp:TextBox></th>
                    </tr>
                    <tr>
                        <th></th>
                        <th><asp:Button ID="btEnviar" runat="server" Text="Enviar reporte" Width="116px" OnClick="btEnviar_Click"/></th>
                    </tr>
                    <tr><th></th> </tr>
                    <tr><th></th> </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbError" runat="server" Text="Error" Visible="False" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            
        </div>
    </form>
</body>
</html>
