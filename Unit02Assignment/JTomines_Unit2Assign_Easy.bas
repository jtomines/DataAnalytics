Attribute VB_Name = "JTomines_Unit2Assign_Easy"
Sub StockMarket_Easy():
    
    'Declare variables
    Dim ticker, sortRange1, sortRange2, sortRangeX As String
    Dim rowAmt, rowNum, runningTotal, summaryRow As Long
    
    'Load variables
    ticker = ActiveWorkbook.ActiveSheet.Range("A2").Value
    rowAmt = ActiveWorkbook.ActiveSheet.UsedRange.Rows.Count
    rowNum = 2
    summaryRow = 2
    runningTotal = 0
    sortRange1 = "A2:A" & rowAmt
    sortRange2 = "B2:B" & rowAmt
    sortRangeX = "A1:G" & rowAmt
            
   
    'Sort data to ensure it is in correct order
    ActiveWorkbook.ActiveSheet.Sort.SortFields.Clear
    ActiveWorkbook.ActiveSheet.Sort.SortFields.Add2 Key:=Range(sortRange1), _
        SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:=xlSortNormal
    ActiveWorkbook.ActiveSheet.Sort.SortFields.Add2 Key:=Range(sortRange2), _
        SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:=xlSortNormal
    With ActiveWorkbook.ActiveSheet.Sort
        .SetRange Range(sortRangeX)
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With

    'Add header to new columns
    ActiveWorkbook.ActiveSheet.Range("I1").Value = "Ticker"
    ActiveWorkbook.ActiveSheet.Range("J1").Value = "Total Stock Volume"

    'Start Loop for each ticker
    Do While rowNum <= rowAmt
    
        'Start Loop for each row in ticker
        Do While ActiveWorkbook.ActiveSheet.Cells(rowNum, 1).Value = ticker
            runningTotal = runningTotal + ActiveWorkbook.ActiveSheet.Cells(rowNum, 7)
            rowNum = rowNum + 1
        Loop
        
        'Display summary values
        ActiveWorkbook.ActiveSheet.Cells(summaryRow, 9).Value = ticker
        ActiveWorkbook.ActiveSheet.Cells(summaryRow, 10).Value = runningTotal
        
        'Reset values for next ticker
        ticker = ActiveWorkbook.ActiveSheet.Cells(rowNum, 1).Value
        runningTotal = 0
        summaryRow = summaryRow + 1
        
    Loop
    
End Sub




