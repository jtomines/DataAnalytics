Attribute VB_Name = "JTomines_Unit2Assign_EasyCh"
Sub StockMarket_Easy_Challenge():
    
    'Declare variables
    Dim ticker, sortRange1, sortRange2, sortRangeX As String
    Dim rowAmt, rowNum, runningTotal, summaryRow As Long
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
        ws.Range("J1").Value = "Total Stock Volume"
    
        'Start Loop for each ticker
        Do While rowNum <= rowAmt
        
            'Start Loop for each row in ticker
            Do While ws.Cells(rowNum, 1).Value = ticker
                runningTotal = runningTotal + ws.Cells(rowNum, 7)
                rowNum = rowNum + 1
            Loop
            
            'Display summary values
            ws.Cells(summaryRow, 9).Value = ticker
            ws.Cells(summaryRow, 10).Value = runningTotal
            
            'Reset values for next ticker
            ticker = ws.Cells(rowNum, 1).Value
            runningTotal = 0
            summaryRow = summaryRow + 1
            
        Loop
   
   Next ws
       
End Sub


