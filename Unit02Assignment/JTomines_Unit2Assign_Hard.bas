Attribute VB_Name = "JTomines_Unit2Assign_Hard"
Sub StockMarket_Hard():
    
    'Declare variables
    Dim ticker, initTicker, sortRange1, sortRange2, sortRangeX, percentRange, maxVolTicker, maxIncTicker, maxDecTicker As String
    Dim rowAmt, rowNum, summaryRow, pctCounter As Long
    Dim openPrice, closePrice, yearlyChange, percentChange, maxIncrease, maxDecrease, runningTotal, maxVolume As Double
                
    'Load variables
    initTicker = ActiveWorkbook.ActiveSheet.Range("A2").Value
    ticker = initTicker
    rowAmt = ActiveWorkbook.ActiveSheet.UsedRange.Rows.Count
    rowNum = 2
    summaryRow = 2
    runningTotal = 0
    sortRange1 = "A2:A" & rowAmt
    sortRange2 = "B2:B" & rowAmt
    sortRangeX = "A1:G" & rowAmt
    openPrice = ActiveWorkbook.ActiveSheet.Range("C2").Value
    maxVolume = 0
    maxVolTicker = ticker
    maxIncTicker = ""
    maxDecTicker = ""
    pctCounter = 0
   
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
    
        'Start Loop for each row in ticker
        Do While ActiveWorkbook.ActiveSheet.Cells(rowNum, 1).Value = ticker
            runningTotal = runningTotal + ActiveWorkbook.ActiveSheet.Cells(rowNum, 7)
            rowNum = rowNum + 1
        Loop
               
        'Calculate Yearly Change
        closePrice = ActiveWorkbook.ActiveSheet.Cells(rowNum - 1, 6).Value
        yearlyChange = closePrice - openPrice
        
        'Calculate Percent Change & display
        If openPrice = 0 Then
            ActiveWorkbook.ActiveSheet.Cells(summaryRow, 11).Value = "N/A"
        Else
            percentChange = (closePrice - openPrice) / openPrice
            ActiveWorkbook.ActiveSheet.Cells(summaryRow, 11).Value = percentChange
            ActiveWorkbook.ActiveSheet.Cells(summaryRow, 11).NumberFormat = "#0.00%"
            pctCounter = pctCounter + 1
        End If
        
        'Display remaining summary values
        ActiveWorkbook.ActiveSheet.Cells(summaryRow, 9).Value = ticker
        ActiveWorkbook.ActiveSheet.Cells(summaryRow, 10).Value = yearlyChange
        ActiveWorkbook.ActiveSheet.Cells(summaryRow, 12).Value = runningTotal
        
        'Change colour & percentage format
        If yearlyChange < 0 Then
            ActiveWorkbook.ActiveSheet.Cells(summaryRow, 10).Interior.ColorIndex = 3
        Else
            ActiveWorkbook.ActiveSheet.Cells(summaryRow, 10).Interior.ColorIndex = 4
        End If
        
        'Assess if runningTotal is the maxVolume
        If runningTotal > maxVolume Then
            maxVolume = runningTotal
            maxVolTicker = ticker
        End If
        
        'Assess percentage extremes
        If pctCounter = 1 Then
            maxIncrease = percentChange
            maxDecrease = percentChange
            maxIncTicker = ticker
            maxDecTicker = ticker
        ElseIf pctCounter > 1 Then
            If percentChange > maxIncrease Then
                maxIncrease = percentChange
                maxIncTicker = ticker
            End If
            If percentChange < maxDecrease Then
                maxDecrease = percentChange
                maxDecTicker = ticker
            End If
        End If
        
        'Reset values for next ticker
        ticker = ActiveWorkbook.ActiveSheet.Cells(rowNum, 1).Value
        openPrice = ActiveWorkbook.ActiveSheet.Cells(rowNum, 3).Value
        runningTotal = 0
        summaryRow = summaryRow + 1
        
    Wend
    
    'Display the maxima
    ActiveWorkbook.ActiveSheet.Range("P1").Value = "Ticker"
    ActiveWorkbook.ActiveSheet.Range("Q1").Value = "Value"
    ActiveWorkbook.ActiveSheet.Range("O2").Value = "Greatest % Increase"
    ActiveWorkbook.ActiveSheet.Range("O3").Value = "Greatest % Decrease"
    ActiveWorkbook.ActiveSheet.Range("O4").Value = "Greatest Total Volume"
    ActiveWorkbook.ActiveSheet.Range("P2").Value = maxIncTicker
    ActiveWorkbook.ActiveSheet.Range("P3").Value = maxDecTicker
    ActiveWorkbook.ActiveSheet.Range("P4").Value = maxVolTicker
    If pctCounter = 0 Then
        ActiveWorkbook.ActiveSheet.Range("Q2").Value = "None Found"
        ActiveWorkbook.ActiveSheet.Range("Q3").Value = "None Found"
    Else
        ActiveWorkbook.ActiveSheet.Range("Q2").Value = maxIncrease
        ActiveWorkbook.ActiveSheet.Range("Q3").Value = maxDecrease
    End If
    ActiveWorkbook.ActiveSheet.Range("Q4").Value = maxVolume
    ActiveWorkbook.ActiveSheet.Range("Q2:Q3").NumberFormat = "#0.00%"
    
End Sub


