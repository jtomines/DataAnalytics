Attribute VB_Name = "JTomines_Unit2Assign_EasyCh"
Sub StockMarket_Easy_Challenge():
    
    'Declare variables
    Dim ticker, sortRange1, sortRange2, sortRangeX As String
    Dim rowAmt, rowNum, runningTotal, summaryRow, sheetAmt As Long
    
    'Initialize workbook variables
    sheetAmt = ActiveWorkbook.Sheets.Count
    
    'Start Loop for each sheet
    For sheetNum = 1 To sheetAmt
    
        'Load variables
        ticker = ActiveWorkbook.Worksheets(sheetNum).Range("A2").Value
        rowAmt = ActiveWorkbook.Worksheets(sheetNum).UsedRange.Rows.Count
        rowNum = 2
        summaryRow = 2
        runningTotal = 0
        sortRange1 = "A2:A" & rowAmt
        sortRange2 = "B2:B" & rowAmt
        sortRangeX = "A1:G" & rowAmt
        
        'Sort data to ensure it is in correct order
        ActiveWorkbook.Worksheets(sheetNum).Sort.SortFields.Clear
        ActiveWorkbook.Worksheets(sheetNum).Sort.SortFields.Add2 Key:=Range(sortRange1), _
            SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:=xlSortNormal
        ActiveWorkbook.Worksheets(sheetNum).Sort.SortFields.Add2 Key:=Range(sortRange2), _
            SortOn:=xlSortOnValues, Order:=xlAscending, DataOption:=xlSortNormal
        With ActiveWorkbook.Worksheets(sheetNum).Sort
            .SetRange Range(sortRangeX)
            .Header = xlYes
            .MatchCase = False
            .Orientation = xlTopToBottom
            .SortMethod = xlPinYin
            .Apply
        End With
    
        'Add header to new columns
        ActiveWorkbook.Worksheets(sheetNum).Range("I1").Value = "Ticker"
        ActiveWorkbook.Worksheets(sheetNum).Range("J1").Value = "Total Stock Volume"
    
        'Start Loop for each ticker
        Do While rowNum <= rowAmt
        
            'Start Loop for each row in ticker
            Do While ActiveWorkbook.Worksheets(sheetNum).Cells(rowNum, 1).Value = ticker
                runningTotal = runningTotal + ActiveWorkbook.Worksheets(sheetNum).Cells(rowNum, 7)
                rowNum = rowNum + 1
            Loop
            
            'Display summary values
            ActiveWorkbook.Worksheets(sheetNum).Cells(summaryRow, 9).Value = ticker
            ActiveWorkbook.Worksheets(sheetNum).Cells(summaryRow, 10).Value = runningTotal
            
            'Reset values for next ticker
            ticker = ActiveWorkbook.Worksheets(sheetNum).Cells(rowNum, 1).Value
            runningTotal = 0
            summaryRow = summaryRow + 1
            
        Loop
   
   Next sheetNum
       
End Sub


