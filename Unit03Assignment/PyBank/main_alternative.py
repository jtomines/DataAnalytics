"""--------------------------------------------------------------------------
Unit 03 Assignment - Py Me Up, Charlie
Sub Assignment:  PyBank
Created by:      Jose Tomines
Notes:   
      1) NOT the OFFICIAL FILE for PyBank portion of the Assignment
         (see #3 for details)
      
      2) Unlike the OFFICIAL FILE, this program makes assumption that the
         greatest Increase is the largest positive value in the Profit/Losses
         column, and the greatest Decrease is the largest negative value
         in the column.  In other words:  If all the values in the column
         were negative then 0 is stored as the the greatest Increase, and if
         all the values in the column were positive then 0 is stored as the
         greatest Decrease.  The months would default to "None Found" in the
         above cases.
         
      3) This version reads each line and has a running total, and does
         comparisons to determine the desired summary results.  This is 
         a few thousandths of a second slower than my official submission
         where I load the data into lists and let Python arithmetic functions
         calculate the summary results.  I don't know which version would be
         faster if the data file was exponentially more massive.
--------------------------------------------------------------------------"""

# Import dependencies
import os
import csv

# Declare pathname of csvfile
csvpath = os.path.join("Resources", "budget_data.csv")

# Initialize variables
numMonths = 0
total = 0
maxIncrease = 0
maxDecrease = 0
maxIncMonth = "None Found"
maxDecMonth = "None Found"

# Open csvfile        
with open(csvpath, 'r', newline = "") as csvfile:
    
    # Skip header row
    csvfile.readline()
    
    # Read each line in csvfile as list
    csvreader = csv.reader(csvfile, delimiter=",")
    for row in csvreader:

        # load meaningful variable names
        month = row[0]
        amt = int(row[1])
        
        # running count of number of months
        numMonths += 1
        
        # running sum of amount
        total += amt
        
        # evaluate if amount is larger than max increase already found
        if amt >= 0:
            if amt > maxIncrease:
                maxIncrease = amt
                maxIncMonth = month
        
        # evalute if amount is less than max decrease already found
        else:
            if amt < maxDecrease:
                maxDecrease = amt
                maxDecMonth = month

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
    
    
