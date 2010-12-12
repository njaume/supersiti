﻿Option Explicit On

Public Class frmVentas

#Region "Variables Locales"
    Dim ol_dt As DataTable
    'Declaro esta variable como s, para poder obtener los datos del Usuario
    'en todo momento y poder validar los permisos. Además de utilizarlos en el
    'Status Strip Tools
    Public ol_dtUsr As DataTable
#End Region

#Region "Eventos"

    Private Sub frmVentas_FormClosing(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing
        CerrarAplicacion()
    End Sub

    Private Sub frmVentas_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles Me.KeyDown
        If e.KeyCode = Keys.F2 Then
            frmBuscaProducto.Show()
        End If
    End Sub

    Private Sub frmVentas_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles Me.KeyPress
        If e.KeyChar = ChrW(Keys.F2) Then
            frmBuscaProducto.ShowDialog()
        End If
    End Sub

    Private Sub frmVentas_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Me.lblFecha.Text = Format(Date.Now, "dd/MM/yyyy")
        CrearDTItems()
        IniciaStrip()
    End Sub

    'Private Sub txtProductoBarra_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtProductoBarra.KeyDown
    '    'If Not Me.txtProductoBarra.Text = "" Then
    '    Try

    '        If e.KeyCode = Keys.F2 Then
    '            frmBuscaProducto.ShowDialog()
    '        End If
    '        If Not Me.txtProductoBarra.Text = "" Then
    '            If e.KeyCode = Keys.Enter Then
    '                'Buscar en la base y completar una Clase detalle
    '                Me.txtCantidad.Focus()
    '            End If
    '        End If

    '    Catch ex As Exception
    '        Throw ex
    '    End Try
    'End Sub

    Private Sub txtCantidad_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtCantidad.KeyDown
        If e.KeyCode = Keys.Enter Then
            If Not Me.txtCantidad.Text = "" Then
                BuscarProducto(Me.txtProductoBarra.Text)
            End If
        End If
    End Sub

    Private Sub txtProductoBarra_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtProductoBarra.KeyDown
        If e.KeyCode = Keys.F3 Then
            frmBuscaProducto.ShowDialog()
        End If
        If Not Me.txtProductoBarra.Text = "" Then
            If e.KeyCode = Keys.Enter Then
                Me.txtCantidad.Focus()
            End If
        End If
    End Sub

    Private Sub txtProductoBarra_KeyPress(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtProductoBarra.KeyPress
        If e.KeyChar = ChrW(Keys.F2) Then
            frmBuscaProducto.ShowDialog()
        End If

    End Sub

    Private Sub DataGridView1_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles DataGridView1.KeyDown
        If e.KeyCode = Keys.Delete Then
            If MsgBox("¿Está seguro de quitar este Item de la venta?", MsgBoxStyle.Question + MsgBoxStyle.YesNo, ".:: ADVERTENCIA ::.") = MsgBoxResult.Yes Then
                QuitarItemDT(ol_dt, Me.DataGridView1.CurrentCell.RowIndex)
            End If
        End If
    End Sub

    ''' <summary>
    ''' Item del menú que solicita realizar un retiro de plata de la caja
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Private Sub ToolStripMenuItem4_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ToolStripMenuItem4.Click
        frmAdministraCaja.lblOperacion.Text = "Retiro"
        frmAdministraCaja.lblOperacion.ForeColor = Color.DarkGreen
        frmAdministraCaja.ShowDialog()
    End Sub

    ''' <summary>
    ''' Item del menú que solicita realizar una apertura de caja
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Private Sub ToolStripMenuItem5_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ToolStripMenuItem5.Click
        frmAdministraCaja.lblOperacion.Text = "Apertura"
        frmAdministraCaja.lblOperacion.ForeColor = Color.Blue
        frmAdministraCaja.ShowDialog()
    End Sub

    ''' <summary>
    ''' Item del menú que solicita realizar un Cierre de Caja por operador
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Private Sub ToolStripMenuItem6_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ToolStripMenuItem6.Click
        frmAdministraCaja.lblOperacion.Text = "Cierre X"
        frmAdministraCaja.lblOperacion.ForeColor = Color.DarkRed
        frmAdministraCaja.ShowDialog()
    End Sub

    ''' <summary>
    ''' Item del menú que solicita realizar un Cierre Z, un cierre completo de las ventas
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Private Sub ToolStripMenuItem7_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ToolStripMenuItem7.Click
        frmAdministraCaja.lblOperacion.Text = "Cierre Z"
        frmAdministraCaja.lblOperacion.ForeColor = Color.Red
        frmAdministraCaja.ShowDialog()
    End Sub

    Private Sub SalirDelSistemaToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SalirDelSistemaToolStripMenuItem.Click
        CerrarAplicacion()
    End Sub

    Private Sub btnBuscarProductoXNombre_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnBuscarProductoXNombre.Click
        frmBuscaProducto.ShowDialog()
    End Sub
#End Region

#Region "Métodos"

    Private Sub BuscarProducto(ByVal pstrProducto As String)
        Dim oDt As DataTable
        Dim oDetalle As clsDetalleComprobante
        Try
            oDt = New DataTable
            oDetalle = New clsDetalleComprobante

            oDt = clsProductoDAO.getProducto(0, "", "", "", 0, 0, pstrProducto)

            If Not oDt Is Nothing Then
                If oDt.Rows.Count > 1 Then
                    frmBuscaProducto.Lista(oDt)
                    frmBuscaProducto.ShowDialog()
                Else
                    oDetalle.ID = oDt.Rows(0).Item("PRO_ID")
                    oDetalle.Nombre = oDt.Rows(0).Item("PRO_NOMBRE")
                    oDetalle.Codigo = oDt.Rows(0).Item("PRO_CODIGO")
                    oDetalle.PcioUnitario = Math.Round(oDt.Rows(0).Item("LPR_PRECIO"), 2)
                    oDetalle.Cantidad = CInt(Me.txtCantidad.Text)
                    oDetalle.PcioTotal = Math.Round(CDbl(CInt(Me.txtCantidad.Text) * CDbl(oDetalle.PcioUnitario)), 2)
                    'oDetalle.Pesable = IIf(oDt.Rows(0).Item("PRO_PESABLE") = 1, "Si", "No")
                    AgregarItemDT(oDt, oDetalle)
                End If
            End If
        Catch ex As Exception
            Throw ex
        Finally
            oDt = Nothing
        End Try
    End Sub

    Public Sub IniciaStrip()
        SSTInformaUsuario.Items("TSSUsuario").Text = ol_dtUsr.Rows(0).Item("USU_NOMBRE").ToString
        SSTInformaUsuario.Items("TSSIdUsuario").Text = ol_dtUsr.Rows(0).Item("USU_ID").ToString
        SSTInformaUsuario.Items("TSSFecha").Text = FormatDateTime(Now, DateFormat.ShortDate)
        SSTInformaUsuario.Items("TSSPtoVta").Text = "0001"
        SSTInformaUsuario.Items("TSSPC").Text = Funciones.NombrePC
    End Sub

    Private Sub CerrarAplicacion()
        If MsgBox("¿Está seguro que desea cerrar la Aplicación?", MsgBoxStyle.YesNo + MsgBoxStyle.Question, ".:: CIERRE DE APLICACIÓN ::.") = MsgBoxResult.Yes Then
            BorrarDT(ol_dt)
            End
        End If
    End Sub

    Public Sub CargarMenu(ByVal po_dt As DataTable)
        'Dim o_item As MenuItem
        'Dim o_men As MenuStrip

        'For Each dr As DataRow In po_dt.Rows
        '    o_men = New MenuStrip

        'Next

    End Sub
#End Region

#Region "Creación de métodos auxiliares"

    Private Sub CrearDTItems()
        Dim oDet As New clsDetalleComprobante
        ol_dt = New DataTable

        ol_dt.Columns.Add(oDet.ID.ToString, GetType(Integer))
        ol_dt.Columns.Add(oDet.Nombre.ToString, GetType(String))
        ol_dt.Columns.Add(oDet.Codigo.ToString, GetType(Integer))
        ol_dt.Columns.Add(oDet.PcioUnitario.ToString, GetType(Double))
        ol_dt.Columns.Add(oDet.Cantidad.ToString, GetType(Integer))
        ol_dt.Columns.Add(oDet.PcioTotal.ToString, GetType(Double))
        ol_dt.Columns.Add(oDet.Pesable.ToString, GetType(Char))

    End Sub

    Private Function AgregarItemDT(ByRef dt As DataTable, ByVal campos As clsDetalleComprobante) As DataTable
        Try

            Dim dr As DataRow = dt.NewRow()

            'dr = dt.NewRow()
            dr.Item(campos.ID.ToString) = campos.ID
            dr.Item(campos.Nombre.ToString) = campos.Nombre
            dr.Item(campos.Codigo.ToString) = campos.Codigo
            dr.Item(campos.PcioUnitario.ToString) = campos.PcioUnitario
            dr.Item(campos.Cantidad.ToString) = campos.Cantidad
            dr.Item(campos.PcioTotal.ToString) = campos.PcioTotal
            dr.Item(campos.Pesable.ToString) = IIf(campos.Pesable = 1, "S", "N")
            'dr.AcceptChanges()

            dt.Rows.Add(dr)
            Return dt

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Private Function QuitarItemDT(ByVal dt As DataTable, ByVal indice As Integer) As DataTable

        dt.Rows(indice).Delete()
        dt.AcceptChanges()

        Return dt
    End Function

    Private Sub BorrarDT(ByRef dt As DataTable)
        'dt.Clear()
        dt = Nothing
    End Sub
#End Region

End Class
