Attribute VB_Name = "JTomines_Unit2Assign_Mod"
Sub StockMarket_Moderate():
    
    'Declare variables
    Dim ticker, sortRange1, sortRange2, sortRangeX As String
    Dim rowAmt, rowNum, summaryRow As Long
    Dim openPrice, closePrice, yearlyChange, percentChange, runningTotal As Double
        
    'Load variables
    ticker = ActiveWorkbook.ActiveSheet.Range("A2").Value
    rowAmt = ActiveWorkbook.ActiveSheet.UsedRange.Rows.Count
    rowNum = 2
    summaryRow = 2
    runningTotal = 0
    sortRange1 = "A2:A" & rowAmt
    sortRange2 = "B2:B" & rowAmt
    sortRangeX = "A1:G" & rowAmt
    openPrice = ActiveWorkbook.ActiveSheet.Range("C2").Value
   
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
    ActiveWorkbook.ActiveSheet.Range("J1").Value = "Yearly Change"
    ActiveWorkbook.ActiveSheet.Range("K1").Value = "Percent Change"
    ActiveWorkbook.ActiveSheet.Range("L1").Value = "Total Stock Volume"

    'Start Loop for each ticker
    While rowNum <= rowAmt
    
        'Start Loop for each row with same ticker
        Do While ActiveWorkbook.ActiveSheet.Cells(rowNum, 1).Value = ticker
            runningTotal = runningTotal + ActiveWorkbook.ActiveSheet.Cells(rowNum, 7)
            rowNum = rowNum + 1
        Loop
       
        'Calculate Yearly Change
        closePrice = ActiveWorkbook.ActiveSheet.Cells(rowNum - 1, 6).Value
        yearlyChange = closePrice - openPrice
        
        'Calculate Percent Change & Display
        If openPrice = 0 Then
            ActiveWorkbook.ActiveSheet.Cells(summaryRow, 11).Value = "N/A"
        Else
            percentChange = (closePrice - openPrice) / openPrice
            ActiveWorkbook.ActiveSheet.Cells(summaryRow, 11).Value = percentChange
            ActiveWorkbook.ActiveSheet.Cells(summaryRow, 11).NumberFormat = "#0.00%"
        End If
       
        'Display remaining summary values
        ActiveWorkbook.ActiveSheet.Cells(summaryRow, 9).Value = ticker
        ActiveWorkbook.ActiveSheet.Cells(summaryRow, 10).Value = yearlyChange
        ActiveWorkbook.ActiveSheet.Cells(summaryRow, 12).Value = runningTotal
        
        'Change colour for Yearly Increase
        If yearlyChange < 0 Then
            ActiveWorkbook.ActiveSheet.Cells(summaryRow, 10).Interior.ColorIndex = 3 'Red
        Else
            ActiveWorkbook.ActiveSheet.Cells(summaryRow, 10).Interior.ColorIndex = 4 'Green
        End If
        
        'Reset values for next ticker
        ticker = ActiveWorkbook.ActiveSheet.Cells(rowNum, 1).Value
        openPrice = ActiveWorkbook.ActiveSheet.Cells(rowNum, 3).Value
        runningTotal = 0
        summaryRow = summaryRow + 1
    
    Wend
    
End Sub

