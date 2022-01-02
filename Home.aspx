<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="ProyectoFinalDAM.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="/Style/EstiloGeneral.css"/>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="lbUsername" runat="server" Text=""></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btLogout" runat="server" Text="SALIR" OnClick="btLogout_Click" />
        </div>
        <br />
        <div class="extender">
            <asp:Panel ID="Panel1" runat="server" Height="40px" style="border: thin double #808080; background-color: #c8c8e8" class="extender">
                <table class="extender">
                    <tr>
                        <th>&nbsp;</th>
                        <th><a href="/Personal">Mi vista</a></th>
                        <th>| &nbsp;&nbsp;</th>
                        <th><a href="/Home">Ver incidencias</a></th>
                        <th>| &nbsp;&nbsp;&nbsp;</th>
                        <th><a href="/RegistroIncidencia">Reportar incidencia</a></th>
                        <th width ="1000"></th>
                        <th><asp:TextBox ID="tbIncidencia" runat="server" placeholder="Buscar..."></asp:TextBox></th>
                        <th><asp:Button ID="btBuscar" runat="server" Text="BUSCAR" Width="116px" OnClick="btBuscar_Click"/></th>
                    </tr>
                </table>
            </asp:Panel>
        </div>
        <br />
        <br />

        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

        <div class="extender">


        </div>

        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

        <div class="extender">
            <asp:ListView ID="ListView1" runat="server" GroupPlaceholderID="groupHolder" ItemPlaceholderID="itemHolder">
                <LayoutTemplate>
                    <table class="extender">
                        <tr style="background-color: lightsteelblue; margin-right:auto; width: fit-content;">
                            <th>ID</th>
                            <th>Categoría</th>
                            <th>Prioridad</th>
                            <th>Estado</th>
                            <th>Actualizada</th>
                            <th>&nbsp;Resumen</th>
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
                        <td class="<%# Eval("ESTADO")%>" style="text-align:center"><a href="/DetalleIncidencia.aspx?id=<%# Eval("ID_INCIDENCIA")%>"><%# Eval("ID_INCIDENCIA")%></a></td>
                        <td class="<%# Eval("ESTADO")%>" style="text-align:center"><%# Eval("CATEGORIA")%></td>
                        <td class="<%# Eval("ESTADO")%>" style="text-align:center"><%# Eval("PRIORIDAD")%></td>
                        <td class="<%# Eval("ESTADO")%>" style="text-align:center"><%# Eval("ESTADO")%> &nbsp; <small>(<%# Eval("RESPONSABLE")%>)</small></td>
                        <td class="<%# Eval("ESTADO")%>" style="text-align:center"><%# Eval("FCH_ACTUALIZACION")%></td>
                        <td class="<%# Eval("ESTADO")%>">&nbsp;<%# Eval("MOTIVO")%></td>
                </ItemTemplate>
            </asp:ListView>
        </div>
    </form>
</body>
</html>
