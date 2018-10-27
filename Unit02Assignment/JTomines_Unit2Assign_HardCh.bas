Attribute VB_Name = "JTomines_Unit2Assign_HardCh"
Sub StockMarket_Hard_Challenge():
    
    'Declare variables
    Dim ticker, sortRange1, sortRange2, sortRangeX, percentRange, maxVolTicker, maxIncTicker, maxDecTicker As String
    Dim rowAmt, rowNum, summaryRow, pctCounter As Long
    Dim openPrice, closePrice, yearlyChange, percentChange, maxIncrease, maxDecrease, runningTotal, maxVolume As Double
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
        maxVolume = 0
        maxVolTicker = ticker
        maxIncTicker = ""
        maxDecTicker = ""
        pctCounter = 0
       
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
        
            'Start Loop for each row in ticker
            Do While ws.Cells(rowNum, 1).Value = ticker
                runningTotal = runningTotal + ws.Cells(rowNum, 7)
                rowNum = rowNum + 1
            Loop
                   
            'Calculate Yearly Change
            closePrice = ws.Cells(rowNum - 1, 6).Value
            yearlyChange = closePrice - openPrice
            
            'Calculate Percent Change & display
            If openPrice = 0 Then
                ws.Cells(summaryRow, 11).Value = "N/A"
            Else
                percentChange = (closePrice - openPrice) / openPrice
                ws.Cells(summaryRow, 11).Value = percentChange
                ws.Cells(summaryRow, 11).NumberFormat = "#0.00%"
                pctCounter = pctCounter + 1
            End If
            
            'Display remaining summary values
            ws.Cells(summaryRow, 9).Value = ticker
            ws.Cells(summaryRow, 10).Value = yearlyChange
            ws.Cells(summaryRow, 12).Value = runningTotal
            
            'Change colour & percentage format
            If yearlyChange < 0 Then
                ws.Cells(summaryRow, 10).Interior.ColorIndex = 3
            Else
                ws.Cells(summaryRow, 10).Interior.ColorIndex = 4
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
            ticker = ws.Cells(rowNum, 1).Value
            openPrice = ws.Cells(rowNum, 3).Value
            runningTotal = 0
            summaryRow = summaryRow + 1
            
        Wend
        
        'Display the maxima
        ws.Range("P1").Value = "Ticker"
        ws.Range("Q1").Value = "Value"
        ws.Range("O2").Value = "Greatest % Increase"
        ws.Range("O3").Value = "Greatest % Decrease"
        ws.Range("O4").Value = "Greatest Total Volume"
        ws.Range("P2").Value = maxIncTicker
        ws.Range("P3").Value = maxDecTicker
        ws.Range("P4").Value = maxVolTicker
        If pctCounter = 0 Then
            ws.Range("Q2").Value = "None Found"
            ws.Range("Q3").Value = "None Found"
        Else
            ws.Range("Q2").Value = maxIncrease
            ws.Range("Q3").Value = maxDecrease
        End If
        ws.Range("Q4").Value = maxVolume
        ws.Range("Q2:Q3").NumberFormat = "#0.00%"
        
    Next ws
    
End Sub


