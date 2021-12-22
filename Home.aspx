<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="ProyectoFinalDAM.Home" %>

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
            <asp:Button ID="btLogout" runat="server" Text="SALIR" OnClick="btLogout_Click" />
        </div>
        <br />
        <div>
            <asp:Panel ID="Panel1" runat="server" Height="40px" style="margin-left: auto; margin-right:auto; background-color: lightblue; border: thin double #808080; width: fit-content">
                <table style="position: relative; margin-left: auto; margin-right:auto;">
                    <tr>
                        <th><a href="/Personal">Mi vista</a></th>
                        <th><a href="/Home">Ver incidencias</a></th>
                        <th><a href="/RegistroIncidencia">Reportar incidencia</a></th>
                        <th width ="1000"></th>
                        <th><asp:TextBox ID="tbIncidencia" runat="server" placeholder="id_incidencia"></asp:TextBox></th>
                        <th><asp:Button ID="btBuscar" runat="server" Text="BUSCAR" Width="116px" OnClick="btBuscar_Click"/></th>
                    </tr>
                </table>
            </asp:Panel>
        </div>
        <br />
        <br />
        <div>
            <asp:ListView ID="ListView1" runat="server" GroupPlaceholderID="groupHolder" ItemPlaceholderID="itemHolder">
                <LayoutTemplate>
                    <table border ="1"  class="sortable" style="background-color: lightgray">
                        <tr style="background-color: lightsteelblue; margin-right:auto; width: fit-content">
                            <th sortable="true">ID</th>
                            <th>Categoría</th>
                            <th>Prioridad</th>
                            <th>Estado</th>
                            <th>Actualizada</th>
                            <th>Resumen</th>
                        </tr>
                        <tr id="groupHolder" runat="server"></tr>
                    </table>
                </LayoutTemplate>
                <GroupTemplate>
                    <tr>
                        <tr id="itemHolder" runat="server"></tr>
                    </tr>
                </GroupTemplate>
                <ItemTemplate>
                        <td><a href="/DetalleIncidencia.aspx?id=<%# Eval("ID_INCIDENCIA")%>"><%# Eval("ID_INCIDENCIA")%></a></td>
                        <td><%# Eval("CATEGORIA")%></td>
                        <td><%# Eval("PRIORIDAD")%></td>
                        <td><%# Eval("ESTADO")%></td>
                        <td><%# Eval("FCH_ACTUALIZACION")%></td>
                        <td><%# Eval("MOTIVO")%></td>
                </ItemTemplate>
            </asp:ListView>
        </div>
    </form>
</body>
</html>
