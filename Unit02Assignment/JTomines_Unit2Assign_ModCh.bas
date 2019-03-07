Attribute VB_Name = "JTomines_Unit2Assign_ModCh"
Sub StockMarket_Moderate_Challenge():
    
    'Declare variables
    Dim ticker, sortRange1, sortRange2, sortRangeX As String
    Dim rowAmt, rowNum, summaryRow As Long
    Dim openPrice, closePrice, yearlyChange, percentChange, runningTotal As Double
    Dim ws As Worksheet
    
    'Start Loop for each sheet
    For Each ws In ActiveWorkbook.Worksheets
        
        'Load variables
        ticker = ws.Range("A2").Value
        rowAmt = ws.UsedRange.Rows.Count
        rowNum = 2
        summaryRow = 2
        runningTotal = 0
        sortRange1 = "A2:A" & rowAmt
        sortRange2 = "B2:B" & rowAmt
        sortRangeX = "A1:G" & rowAmt
        openPrice = ws.Range("C2").Value
       
        'Sort data to ensure it is in correct order
        ws.Sort.SortFields.Clear
        ws.Sort.SortFields.Add2 Key:=Range(sortRange1), _
            SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:=xlSortNormal
        ws.Sort.SortFields.Add2 Key:=Range(sortRange2), _
            SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:=xlSortNormal
        With ws.Sort
            .SetRange Range(sortRangeX)
            .Header = xlYes
            .MatchCase = False
            .Orientation = xlTopToBottom
            .SortMethod = xlPinYin
            .Apply
        End With
    
        'Add header to new columns
        ws.Range("I1").Value = "Ticker"
        ws.Range("J1").Value = "Yearly Change"
        ws.Range("K1").Value = "Percent Change"
        ws.Range("L1").Value = "Total Stock Volume"
    
        'Start Loop for each ticker
        While rowNum <= rowAmt
        
            'Start Loop for each row with same ticker
            Do While ws.Cells(rowNum, 1).Value = ticker
                runningTotal = runningTotal + ws.Cells(rowNum, 7)
                rowNum = rowNum + 1
            Loop
           
            'Calculate Yearly Change
            closePrice = ws.Cells(rowNum - 1, 6).Value
            yearlyChange = closePrice - openPrice
            
            'Calculate Percent Change & Display
            If openPrice = 0 Then
                ws.Cells(summaryRow, 11).Value = "N/A"
            Else
                percentChange = (closePrice - openPrice) / openPrice
                ws.Cells(summaryRow, 11).Value = percentChange
                ws.Cells(summaryRow, 11).NumberFormat = "#0.00%"
            End If
           
            'Display remaining summary values
            ws.Cells(summaryRow, 9).Value = ticker
            ws.Cells(summaryRow, 10).Value = yearlyChange
            ws.Cells(summaryRow, 12).Value = runningTotal
            
            'Change colour for Yearly Increase
            If yearlyChange < 0 Then
                ws.Cells(summaryRow, 10).Interior.ColorIndex = 3 'Red
            Else
                ws.Cells(summaryRow, 10).Interior.ColorIndex = 4 'Green
            End If
            
            'Reset values for next ticker
            ticker = ws.Cells(rowNum, 1).Value
            openPrice = ws.Cells(rowNum, 3).Value
            runningTotal = 0
            summaryRow = summaryRow + 1
        
        Wend
    
    Next ws
    
End Sub


