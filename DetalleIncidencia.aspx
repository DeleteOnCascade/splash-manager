<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleIncidencia.aspx.cs" Inherits="ProyectoFinalDAM.DetalleIncidencia" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="/Style/EstiloGeneral.css"/>
    </head>
<body>
    <form id="form1" runat="server">
        <div>
            <div>
                <asp:Label ID="lbUsername" runat="server" Text=""></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btLogout" runat="server" Text="SALIR" OnClick="SalirLogout" />
            </div>
        <br />
        <div class="extender">
            <asp:Panel ID="Panel1" runat="server" Height="40px" style="border: thin double #808080; background-color: #c8c8e8" class="extender">
                <table class="extender">
                    <tr><th></th></tr>
                    <tr>
                        <th>&nbsp;</th>
                        <th><a href="/MiVista">Mi vista</a></th>
                        <th>| &nbsp;&nbsp;</th>
                        <th><a href="/Home">Ver incidencias</a></th>
                        <th width ="1200"></th>
                        <th><asp:TextBox ID="tbIncidencia" runat="server" placeholder="Buscar..."></asp:TextBox></th>
                        <th><asp:Button ID="btBuscar" runat="server" Text="BUSCAR" Width="116px" OnClick="BuscarIncidencia"/></th>
                    </tr>
                </table>
            </asp:Panel>
        </div>
        <br />
        <br />

            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

            <div class="extender">
                <table class="extender">
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
                        <th></th>
                    </tr>
                </table>
            </div>

            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

            <div class="extender">
                <table class="extender">
                    <tr>
                        <th style="width: 250px"><asp:Label ID="lbMotivo" runat="server" Text="&nbsp;Motivo: "></asp:Label></th>
                        <td><asp:textbox id="tbMotivo" ReadOnly="True" runat="server" TextMode="SingleLine" Enabled="False" Width="100%"/></td>
                    </tr>
                    <tr>
                        <th><asp:Label ID="lbDescripcion" runat="server" Text="&nbsp;Descripción: "></asp:Label></th>
                        <td><asp:textbox id="tbDescripcion" runat="server" ReadOnly="True" TextMode="MultiLine" Enabled="False" width="100%"/></td>
                    </tr>
                </table>
            </div>

            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

            <div class="extender" style="border:1px solid; padding-left:10px">
                <h4>Acciones: </h4>
                <div style="display:inline-flex">
                    <asp:Button ID="btCambiar" runat="server" Text="Cambiar estado a:" OnClick="CambiarEstadoIncidencia" /> &nbsp;
                            <asp:DropDownList ID="dropListEstado" runat="server" Rows="6" SelectionMode="Single">
                                <asp:ListItem>nueva</asp:ListItem>
                                <asp:ListItem>asignada</asp:ListItem>
                                <asp:ListItem>aceptada</asp:ListItem>
                                <asp:ListItem>feedback</asp:ListItem>
                                <asp:ListItem>resuelta</asp:ListItem>
                                <asp:ListItem>cerrada</asp:ListItem>
                            </asp:DropDownList>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btAsignar" runat="server" Text="Asignar a:" OnClick="AsignarIncidencia" /> &nbsp;
                    <asp:DropDownList ID="dropListAsignar" runat="server" SelectionMode="Single"/> &nbsp; &nbsp; &nbsp;
                    <asp:Button ID="btEliminar" runat="server" Text="Eliminar Incidencia" OnClick="EliminarIncidencia" />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Label ID="lbUpload" runat="server" Text="&nbsp;Adjuntar archivo: "></asp:Label>
                    &nbsp;&nbsp;
                    <asp:FileUpload ID="fuArchivo" runat="server" />&nbsp;&nbsp;
                    <asp:Button ID="btSubirArchivo" runat="server" Text="Subir archivo" OnClick="SubirArchivo" />
                </div>
               <br /><br />
            </div>

            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

            <div class="extender" style="border:1px solid; padding-left:10px; padding-bottom: 20px">
            <h4>Archivos: </h4>
                <asp:Label ID="lbArchivo" runat="server" Text=""></asp:Label>
                <asp:GridView ID="gridArchivos" runat="server" AutoGenerateColumns="False" CssClass="simple">
                    <Columns>
                        <asp:BoundField DataField="id_archivo" HeaderText="ID" />
                        <asp:HyperLinkField DataNavigateUrlFields="nombre" DataNavigateUrlFormatString="~/Files/{0}" DataTextField="nombre" HeaderText="Archivos:" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lnbt_delete" runat="server" OnClick="EliminarArchivo" OnClientClick="return confirm('¿Eliminar archivo?');">Delete</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

            <div class="extender">
                <asp:ListView ID="lvNota" runat="server" GroupPlaceholderID="groupHolder" ItemPlaceholderID="itemHolder">
                    <LayoutTemplate>
                        <table class="extender">
                            <tr style="margin-right:auto; width: fit-content">
                                <th style="width: 250px">Datos</th>
                                <th>Descripción</th>
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
                        <th>
                            <small>
                                <a href="/DetalleNota.aspx?id=<%# Eval("ID_NOTA")%>"><%# Eval("ID_NOTA")%></a>&nbsp;
                                <%# Eval("USUARIO")%>&nbsp;&nbsp;
                                <%# Eval("FCH_CREACION")%>
                            </small><br />
                        </th>
                        <td>&nbsp;<%# Eval("DSC_NOTA")%></td>
                    </ItemTemplate>
                </asp:ListView>
            </div>

            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

            <div class="extender">
                <table class="extender">
                    <tr>
                        <th><asp:Label ID="lbNota" runat="server" Text="Nota: "></asp:Label></th>
                        <td><asp:textbox id="tbNota" runat="server" TextMode="MultiLine" Height="130px" Width="800px" class="extender"/></td>
                    </tr>
                    <tr>
                        <th></th>
                        <th><asp:Button ID="btAgregar" runat="server" Text="Agregar nota" Width="116px" OnClick="AgregarNota"/></th>
                    </tr>
                </table>
            </div>

            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

            <div class="extender">
            <hr /><br />
                <asp:ListView ID="listViewHistorial" runat="server" GroupPlaceholderID="groupHolder" ItemPlaceholderID="itemHolder">
                    <LayoutTemplate>
                        <table class="extender">
                            <tr class="extender">
                                <th colspan="4" style="height:40px">Historial de modificaciones</th>
                            </tr>
                            <tr style="background-color: lightsteelblue; margin-right:auto; width: fit-content;">
                                <th>Fecha modificación</th>
                                <th>Usuario</th>
                                <th>Campo</th>
                                <th>Cambio</th>
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
                            <td style="text-align:center"><%# Eval("FCH_MODIFICADO")%></td>
                            <td style="text-align:center"><%# Eval("USUARIO")%></td>
                            <td style="text-align:center"><%# Eval("CAMPO")%></td>
                            <td style="text-align:center"><%# Eval("CAMBIO")%></td>
                    </ItemTemplate>
                </asp:ListView>
            </div>

        </div>
    </form>
</body>
</html>
