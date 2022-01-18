<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistroIncidencia.aspx.cs" Inherits="ProyectoFinalDAM.RegistroIncidencia" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="./Style/EstiloGeneral.css"/>
</head>
<body>
    <form id="form1" runat="server">
        <div style="height:auto">
            <div>
                <asp:Label ID="lbUsername" runat="server" Text=""></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </div>
            <br />
            <div class="extender" style="border:1px solid;">
                <asp:Panel ID="panelOpciones" runat="server" Height="40px" style="background-color: #c8c8e8" class="extender">
                    <table class="extender">
                        <tr><th></th></tr><tr></tr>
                        <tr>
                            <th>&nbsp;</th>
                            <th><a href="./UsuarioIncidencia">Mis incidencias</a></th>
                            <th>| &nbsp;&nbsp;</th>
                            <th><a href="./RegistroIncidencia">Reportar incidencia</a></th>
                            <th width ="1000"></th>
                            <th><asp:TextBox ID="tbIncidencia" runat="server" placeholder="Buscar..."></asp:TextBox></th>
                            <th><asp:Button ID="btBuscar" runat="server" Text="Ir a" Width="116px" OnClick="BuscarIncidencia"/></th>
                        </tr>
                    </table>
                </asp:Panel>
            </div>
            <br /><br />
            <div class="extender" style="border:1px solid; padding-left:170px; background-color: #c8c8e8;"> <br />
                <div style="display:inline-flex; ">
                   <asp:Label ID="lbCategoria" runat="server" Text="Categoria"></asp:Label> &nbsp;&nbsp;&nbsp;
                        <asp:DropDownList ID="dropListCategoria" runat="server" Rows="5" SelectionMode="Single">
                                <asp:ListItem>Incidencia</asp:ListItem>
                                <asp:ListItem>Petición</asp:ListItem>
                        </asp:DropDownList>&nbsp;&nbsp;&nbsp;
                    <asp:Label ID="lbPrioridad" runat="server" Text="Prioridad"></asp:Label>&nbsp;&nbsp;&nbsp;
                    <asp:DropDownList ID="dropListPrioridad" runat="server" Rows="5" SelectionMode="Single">
                        <asp:ListItem>baja</asp:ListItem>
                        <asp:ListItem>media</asp:ListItem>
                        <asp:ListItem>alta</asp:ListItem>
                        <asp:ListItem>muy alta</asp:ListItem>
                        <asp:ListItem>inmediata</asp:ListItem>
                    </asp:DropDownList>&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btEnviar" runat="server" Text="Enviar reporte" Width="116px" OnClick="RegistrarIncidencia"/>
                </div>
               <br /> <br />
            </div> <br />
            <asp:Panel ID="Panel1" runat="server" style="height:auto" class="extender">
                <table class="extender">
                    <tr>
                        <th><asp:Label ID="lbMotivo" runat="server" Text="Resumen"></asp:Label></th>
                        <td><asp:TextBox ID="tbMotivo" runat="server" Width="851px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <th><asp:Label ID="lbDescripcion" runat="server" Text="Descripción"></asp:Label></th>
                        <td><asp:TextBox ID="tbDescripcion" runat="server" Height="149px" TextMode="MultiLine" Width="848px"></asp:TextBox></td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Label ID="lbError" runat="server" Text="Error" Visible="False" ForeColor="Red"></asp:Label>
        </div>
        <div>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="lbUpload" runat="server" Text="&nbsp;Adjuntar archivo: "></asp:Label>&nbsp;&nbsp;
                <asp:FileUpload ID="fuArchivo" runat="server" />&nbsp;&nbsp;
            <br /><br />
        </div>
    </form>
</body>
</html>
