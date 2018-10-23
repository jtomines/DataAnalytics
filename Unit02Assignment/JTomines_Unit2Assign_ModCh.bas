Attribute VB_Name = "JTomines_Unit2Assign_ModCh"
Sub StockMarket_Moderate_Challenge():
    
    'Declare variables
    Dim ticker, sortRange1, sortRange2, sortRangeX As String
    Dim rowAmt, rowNum, summaryRow, sheetAmt As Long
    Dim openPrice, closePrice, yearlyChange, percentChange, runningTotal As Double
    
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
        openPrice = ActiveWorkbook.Worksheets(sheetNum).Range("C2").Value
       
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
        ActiveWorkbook.Worksheets(sheetNum).Range("J1").Value = "Yearly Change"
        ActiveWorkbook.Worksheets(sheetNum).Range("K1").Value = "Percent Change"
        ActiveWorkbook.Worksheets(sheetNum).Range("L1").Value = "Total Stock Volume"
    
        'Start Loop for each ticker
        While rowNum <= rowAmt
        
            'Start Loop for each row with same ticker
            Do While ActiveWorkbook.Worksheets(sheetNum).Cells(rowNum, 1).Value = ticker
                runningTotal = runningTotal + ActiveWorkbook.Worksheets(sheetNum).Cells(rowNum, 7)
                rowNum = rowNum + 1
            Loop
           
            'Calculate Yearly Change
            closePrice = ActiveWorkbook.Worksheets(sheetNum).Cells(rowNum - 1, 6).Value
            yearlyChange = closePrice - openPrice
            
            'Calculate Percent Change & Display
            If openPrice = 0 Then
                ActiveWorkbook.Worksheets(sheetNum).Cells(summaryRow, 11).Value = "N/A"
            Else
                percentChange = (closePrice - openPrice) / openPrice
                ActiveWorkbook.Worksheets(sheetNum).Cells(summaryRow, 11).Value = percentChange
                ActiveWorkbook.Worksheets(sheetNum).Cells(summaryRow, 11).NumberFormat = "#0.00%"
            End If
           
            'Display remaining summary values
            ActiveWorkbook.Worksheets(sheetNum).Cells(summaryRow, 9).Value = ticker
            ActiveWorkbook.Worksheets(sheetNum).Cells(summaryRow, 10).Value = yearlyChange
            ActiveWorkbook.Worksheets(sheetNum).Cells(summaryRow, 12).Value = runningTotal
            
            'Change colour for Yearly Increase
            If yearlyChange < 0 Then
                ActiveWorkbook.Worksheets(sheetNum).Cells(summaryRow, 10).Interior.ColorIndex = 3 'Red
            Else
                ActiveWorkbook.Worksheets(sheetNum).Cells(summaryRow, 10).Interior.ColorIndex = 4 'Green
            End If
            
            'Reset values for next ticker
            ticker = ActiveWorkbook.Worksheets(sheetNum).Cells(rowNum, 1).Value
            openPrice = ActiveWorkbook.Worksheets(sheetNum).Cells(rowNum, 3).Value
            runningTotal = 0
            summaryRow = summaryRow + 1
        
        Wend
    
    Next sheetNum
    
End Sub


