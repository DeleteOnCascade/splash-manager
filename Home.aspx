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
            <asp:Button ID="btLogout" runat="server" Text="SALIR" OnClick="Salir" />
        </div>
        <br />
        <div class="extender" style="border:1px solid;">
            <asp:Panel ID="panelOpciones" runat="server" Height="40px" style="background-color: #c8c8e8" class="extender">
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
                        <th><asp:Button ID="btBuscar" runat="server" Text="Ir a" Width="116px" OnClick="BuscarIncidencia"/></th>
                    </tr>
                </table>
            </asp:Panel>
        </div>
        <br /><br />

        <div class="extender" style="border:1px solid; padding-left:10px;  background-color: #c8c8e8;">
                <h4>Filtrar: </h4>
                <div style="display:inline-flex;">
                    <asp:Panel ID="panelFiltros" runat="server" style="height: fit-content; width: fit-content;" class="extender">
                        <asp:Label runat="server">Estado: &nbsp;</asp:Label>
                            <asp:DropDownList ID="dropListEstado" runat="server" Rows="7" SelectionMode="Single">
                                <asp:ListItem>cualquiera</asp:ListItem>
                                <asp:ListItem>nueva</asp:ListItem>
                                <asp:ListItem>asignada</asp:ListItem>
                                <asp:ListItem>aceptada</asp:ListItem>
                                <asp:ListItem>feedback</asp:ListItem>
                                <asp:ListItem>resuelta</asp:ListItem>
                                <asp:ListItem>cerrada</asp:ListItem>
                            </asp:DropDownList>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Label runat="server">Asignada a: &nbsp;</asp:Label>
                            <asp:DropDownList ID="dropListAsignar" runat="server" SelectionMode="Single"/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Label runat="server">Prioridad: &nbsp;</asp:Label>
                            <asp:DropDownList ID="dropListPrioridad" runat="server" Rows="6" SelectionMode="Single">
                                <asp:ListItem>cualquiera</asp:ListItem>
                                <asp:ListItem>baja</asp:ListItem>
                                <asp:ListItem>media</asp:ListItem>
                                <asp:ListItem>alta</asp:ListItem>
                                <asp:ListItem>muy alta</asp:ListItem>
                                <asp:ListItem>inmediata</asp:ListItem>
                            </asp:DropDownList>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Label runat="server">Categoría: &nbsp;</asp:Label>
                            <asp:DropDownList ID="dropListCategoria" runat="server" Rows="3" SelectionMode="Single">
                                <asp:ListItem>cualquiera</asp:ListItem>
                                <asp:ListItem>Incidencia</asp:ListItem>
                                <asp:ListItem>Petición</asp:ListItem>
                            </asp:DropDownList>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button runat="server" Text="Filtrar" OnClick="FiltrarIncidencias"/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button runat="server" Text="Reiniciar" OnClick="ReiniciarFiltro"/>
                    </asp:Panel>
                </div>
               <br /><br />
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
