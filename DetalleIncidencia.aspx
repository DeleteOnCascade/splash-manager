<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleIncidencia.aspx.cs" Inherits="ProyectoFinalDAM.DetalleIncidencia" %>

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
            <table border="1">
                <tr>
                    <th>ID: <asp:Label ID="lb_IdIncidencia" runat="server" Text=""></asp:Label></th>
                    <th><asp:Label ID="lbCategoria" runat="server" Text=""></asp:Label></th>
                    <th><asp:Label ID="lbPrioridad" runat="server" Text=""></asp:Label></th>
                    <th><asp:Label ID="lbEstado" runat="server" Text=""></asp:Label></th>
                    <th><asp:Label ID="lbInformador" runat="server" Text=""></asp:Label></th>
                    
                </tr>
                <tr>
                    <th><asp:Label ID="lbResponsable" runat="server" Text=""></asp:Label></th>
                    <th><asp:Label ID="lbFechaActualizacion" runat="server" Text=""></asp:Label></th>
                    <th><asp:Label ID="lbProyecto" runat="server" Text=""></asp:Label></th>
                    <th><asp:Label ID="lbFechaCreacion" runat="server" Text=""></asp:Label></th>
                </tr>
            </table>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <table border="1">
                <tr>
                    <th><asp:Label ID="lbMotivo" runat="server" Text="Motivo: "></asp:Label></th>
                    <th><asp:textbox id="tbMotivo" ReadOnly="True" runat="server" TextMode="SingleLine" /></th>
                </tr>
                <tr>
                    <th><asp:Label ID="lbDescripcion" runat="server" Text="Descripción: "></asp:Label></th>
                    <th><asp:textbox id="tbDescripcion" runat="server" ReadOnly="True" TextMode="MultiLine" Height="156px" Width="932px"/></th>
                </tr>
            </table>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <div>
            <asp:ListView ID="ListView1" runat="server" GroupPlaceholderID="groupHolder" ItemPlaceholderID="itemHolder">
                <LayoutTemplate>
                    <table border ="1"  class="sortable" style="background-color: lightgray">
                        <tr style="background-color: lightsteelblue; margin-right:auto; width: fit-content">
                            <th>
                                <table>
                                    <tr>
                                        <th>ID: </th>
                                        <th>Responsable</th>
                                    </tr>
                                    <tr>
                                        <th>Fecha act.</th>
                                    </tr>
                                </table>
                            </th>
                        </tr>

                        <tr>
                            <th><asp:Label ID="lbNota" runat="server" Text="Descripción: "></asp:Label></th>
                            <th><asp:textbox id="tbNota" runat="server" ReadOnly="True" TextMode="MultiLine" Height="130px" Width="800px"/></th>
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
                        <td><%# Eval("ID_NOTA")%></td>
                        <td><%# Eval("DSC_NOTA")%></td>
                        <td><%# Eval("FCH_CREACION")%></td>
                        <td><%# Eval("USUARIO")%></td>
                </ItemTemplate>
            </asp:ListView>
        </div>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <table border="1">
                <tr>
                    <th><asp:Label ID="lbNota" runat="server" Text="Nota: "></asp:Label></th>
                    <th><asp:textbox id="tbNota" runat="server" TextMode="MultiLine" Height="130px" Width="800px"/></th>
                </tr>
                <tr>
                    <th></th>
                    <th><asp:Button ID="btAgregar" runat="server" Text="Agregar nota" Width="116px" OnClick="btAgregar_Click"/></th>
                    <th><input id="ckb_visibilidad" type="checkbox" /></th>
                </tr>
            </table>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <table border="1">
                <tr>
                    <th>Historial de modificaciones</th>
                </tr>
                <tr>
                    <th>Fecha modificación</th>
                    <th></th>
                    <th>Usuario</th>
                    <th></th>
                    <th>Campo</th>
                    <th></th>
                    <th>Cambio</th>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
