<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MiVista.aspx.cs" Inherits="ProyectoFinalDAM.MiVista" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="./Style/EstiloGeneral.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="extender" style="display: inline-flex;">
                <img src="Resources/Images/SplashBT_Logo.png" alt="Splash Logo" />
                <div class="extender" style="float: right; text-align: right">
                    <asp:Label ID="lbUsername" runat="server" Text=""></asp:Label>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btLogout" runat="server" Text="SALIR" OnClick="Salir" />
                </div>
            </div>
            <br />
            <div class="extender" style="border: 1px solid;">
                <asp:Panel class="extender" ID="panelOpciones" runat="server" Height="40px " Style="background-color: #c8c8e8">
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
                            <th width="1200"></th>
                            <th>
                                <asp:TextBox ID="tbIncidencia" runat="server" placeholder="Buscar..."></asp:TextBox></th>
                            <th>
                                <asp:Button ID="btBuscar" runat="server" Text="Ir a" Width="116px" OnClick="BuscarIncidencia" /></th>
                        </tr>
                    </table>
                </asp:Panel>
            </div>
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <h4>&nbsp;Mis Incidencias: </h4>
            <div class="extender" style="border: 1px solid">
                <asp:ListView ID="listViewIncidencias" runat="server" GroupPlaceholderID="groupHolder" ItemPlaceholderID="itemHolder"
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
                                    <asp:DataPager ID="dataPagerIncidencias" runat="server" PagedControlID="listViewIncidencias" PageSize="10">
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
            </div>
        </div>
    </form>
</body>
</html>
