<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="ProyectoFinalDAM.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="./Style/EstiloGeneral.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="extender" style="display: inline-flex;">
            <img src="Resources/Images/SplashBT_Logo.png" alt="Splash Logo" />
            <div class="extender" style="float: right; text-align: right">
                <asp:Label ID="lbUsername" runat="server" Text=""></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btLogout" runat="server" Text="SALIR" OnClick="Salir" />
            </div>
        </div>
        <br />
        <div class="extender" style="border: 1px solid;">
            <asp:Panel ID="panelOpciones" runat="server" Height="40px" Style="background-color: #c8c8e8" class="extender">
                <table class="extender">
                    <tr>
                        <th></th>
                    </tr>
                    <tr></tr>
                    <tr>
                        <th>&nbsp;</th>
                        <th><a href="./MiVista">Mi vista</a></th>
                        <th>| &nbsp;&nbsp;</th>
                        <th><a href="./Home">Ver incidencias</a></th>
                        <th>| &nbsp;&nbsp;&nbsp;</th>
                        <th><a href="./Registro">Registrar usuario</a></th>
                        <th width="1000"></th>
                        <th>
                            <asp:TextBox ID="tbIncidencia" runat="server" placeholder="Buscar..."></asp:TextBox></th>
                        <th>
                            <asp:Button ID="btBuscar" runat="server" Text="Ir a" Width="116px" OnClick="BuscarIncidencia" /></th>
                    </tr>
                </table>
            </asp:Panel>
        </div>
        <br />

        <div class="extender" style="border: 1px solid; padding-left: 10px; margin-right: 20px; background-color: #c8c8e8;">
            <h4>Filtrar: </h4>
            <div style="display: inline-flex;">
                <asp:Panel ID="panelFiltros" runat="server" Style="height: fit-content; width: fit-content;" class="extender">
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
                    <asp:DropDownList ID="dropListAsignar" runat="server" SelectionMode="Single" />
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
                        <asp:Button runat="server" Text="Filtrar" OnClick="FiltrarIncidencias" />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button runat="server" Text="Reiniciar" OnClick="ReiniciarFiltro" />
                </asp:Panel>
            </div>
            <br />
            <br />
        </div>

        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

        <div class="extender" style="border: 1px solid; padding-left: 10px; margin-right: 30px; background-color: #c8c8e8; height: 30px">
            <div style="display: inline-flex;">
                <asp:Panel ID="panel1" runat="server" Style="height: fit-content; width: fit-content; margin-top: 7px" class="extender">
                    <asp:Label runat="server" Font-Bold="True">Mostrando incidencias&nbsp;</asp:Label>
                    <asp:Label runat="server" Text="" ID="lbNumIncidencias" Font-Bold="True"></asp:Label>
                </asp:Panel>
            </div>
            <br />
        </div>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

        <div class="extender" style="border: 1px solid">
            <asp:ListView ID="listIncidencias" runat="server" GroupPlaceholderID="groupHolder" ItemPlaceholderID="itemHolder"
                OnPagePropertiesChanging="listIncidencias_PagePropertiesChanging">
                <LayoutTemplate>
                    <table class="extender">
                        <tr style="background-color: lightsteelblue;">
                            <th>ID</th>
                            <th>Categoría</th>
                            <th>Prioridad</th>
                            <th>Estado</th>
                            <th>Actualizada</th>
                            <th>&nbsp;Resumen</th>
                        </tr>
                        <tr id="groupHolder" runat="server"></tr>
                        <tr>
                            <td colspan="6" style="text-align: center;">
                                <asp:DataPager ID="dataPagerIncidencias" runat="server" PagedControlID="listIncidencias" PageSize="19">
                                    <Fields>
                                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="true" ShowPreviousPageButton="true" ShowNextPageButton="false" />
                                        <asp:NumericPagerField ButtonType="Button" />
                                        <asp:NextPreviousPagerField ButtonType="Button" ShowNextPageButton="true" ShowLastPageButton="true" ShowPreviousPageButton="false" />
                                    </Fields>
                                </asp:DataPager>
                            </td>
                        </tr>
                    </table>
                </LayoutTemplate>
                <GroupTemplate>
                    <tr>
                        <tr id="itemHolder" runat="server"></tr>
                    </tr>
                </GroupTemplate>
                <ItemTemplate>
                    <td class="<%# Eval("ESTADO")%>" style="text-align: center"><a href="./DetalleIncidencia.aspx?id=<%# Eval("ID_INCIDENCIA")%>"><%# Eval("ID_INCIDENCIA")%></a></td>
                    <td class="<%# Eval("ESTADO")%>" style="text-align: center"><%# Eval("CATEGORIA")%></td>
                    <td class="<%# Eval("ESTADO")%>" style="text-align: center"><%# Eval("PRIORIDAD")%></td>
                    <td class="<%# Eval("ESTADO")%>" style="text-align: center"><%# Eval("ESTADO")%> &nbsp; <small>(<%# Eval("RESPONSABLE")%>)</small></td>
                    <td class="<%# Eval("ESTADO")%>" style="text-align: center"><%# Eval("FCH_ACTUALIZACION")%></td>
                    <td class="<%# Eval("ESTADO")%>">&nbsp;<%# Eval("MOTIVO")%></td>
                </ItemTemplate>
            </asp:ListView>
            <br />
        </div>
    </form>
</body>
</html>
