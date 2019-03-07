"""--------------------------------------------------------------------------
Unit 03 Assignment - Py Me Up, Charlie
Sub Assignment:  PyBank
Created by:      Jose Tomines
Notes:   
      1) OFFICIAL FILE for PyBank portion of the Assignment (see #3 for details)
      
      2) This program makes assumption that the greatest Increase is the
         largest value in the Profit/Losses column, and the greatest Decrease
         is the smallest value in the column.  In other words:
         If all the values in the column were negative, then greatest Increase
         would be the smallest (in absolute value) of the negative amounts.
         Conversely if all the values in the column were positive, then the
         greatest Decrease is the smallest (in absolute value) of the positive
         amounts.  This ensures there is a value found for greatest Increase and
         Decrease regardless of the data.
         
      3) This version reads each line and stores all values into two lists in
         memory.  It then calculates the desired summary results using Python
         arithmetic functions on the lists.  My original file read each line
         to keep a running total, and do comparisons to determine the
         desired summary results.  The original, called "main_alternative.py"
         was a few thousandths of a second slower than this official submission.
         I don't know which version would be faster if the data file was
         exponentially more massive.
--------------------------------------------------------------------------"""

# Import dependencies
import os
import csv

# Declare lists to store all data from file
amtList=[]
mnthList=[]

# Declare pathname of csvfile
csvpath = os.path.join("Resources", "budget_data.csv")

# Open csvfile        
with open(csvpath, 'r', newline = "") as csvfile:
    
    # Skip header row
    csvfile.readline()
    
    # Read each line in csvfile as list
    csvreader = csv.reader(csvfile, delimiter=",")

    # Read each row and create lists
    for row in csvreader:
        amtList.append(int(row[1]))
        mnthList.append(row[0])

# Calculate total number months
numMonths = len(mnthList)

# Calculate the overall total
total = sum(amtList)

# Determine the Greatest Increase
maxIncrease = max(amtList)

# Determine the Greatest Decrease
maxDecrease = min(amtList)

# Determine the month for the Greatest Increase
maxIncMonth = mnthList[amtList.index(maxIncrease)]

# Determine the month for the Greatest Decrease
maxDecMonth = mnthList[amtList.index(maxDecrease)]

# Display the report that includes calculations
print("Financial Analysis")
print("---------------------------------------------------")
print("Total Months:  " + str(numMonths))
print("Total:  $" + str(total))
print("Average Change:  $" + str(round(total/numMonths,2)))
print("Greatest Increase in Profits:  " + maxIncMonth + " ($" + str(maxIncrease) + ")")
print("Greatest Decrease in Profits:  " + maxDecMonth + " ($" + str(maxDecrease) + ")")

# Save the report to file
with open('JTomines_PyBank-FinancialAnalysis.txt', 'w') as resultFile:
    resultFile.write("Financial Analysis")
    resultFile.write("\n---------------------------------------------------")
    resultFile.write("\nTotal Months:  " + str(numMonths))
    resultFile.write("\nTotal:  $" + str(total))
    resultFile.write("\nAverage Change:  $" + str(round(total/numMonths,2)))
    resultFile.write("\nGreatest Increase in Profits:  " + maxIncMonth + " ($" + str(maxIncrease) + ")")
    resultFile.write("\nGreatest Decrease in Profits:  " + maxDecMonth + " ($" + str(maxDecrease) + ")")
