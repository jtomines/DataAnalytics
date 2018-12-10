"""--------------------------------------------------------------------------
Unit 03 Assignment - Py Me Up, Charlie
Sub Assignment:  PyPoll
Created by:      Jose Tomines
Notes:           
--------------------------------------------------------------------------"""

# Import dependencies
import os
import csv

# Declare pathname of csvfile
csvpath = os.path.join("Resources", "election_data.csv")

candidateVotes = []

# Open csvfile        
with open(csvpath, 'r', newline = "") as csvfile:
    
    # Skip header row
    csvfile.readline()
    
    # Read each line in csvfile as list
    csvreader = csv.reader(csvfile, delimiter=",")

    # Read Candidate name from each row to create ballot list
    ballot = [row[2] for row in csvreader]
    
    # Determine number of votes cast
    numVotes = len(ballot)
    
    # Determine list of candidates
    candidates = list(set(ballot))

    # Count the votes for each candidate and store in matrix
    for name in candidates:
        candidateVotes.append([name, ballot.count(name)])
    
    # Sort matrix in order of votes in reverse
    candidateVotes.sort(key=lambda x:x[1], reverse =True)

# Print Election Results report
print("Election Results")
print("------------------------------")

# Print Total Votes
print("Total Votes:  " + str(numVotes))
print("------------------------------")

# Print each candidates voting summary
for row in candidateVotes:
    
    # determine percentage
    percentVote = row[1] * 100 / numVotes

    # apply display formatting for name
    name = row[0] + ":"
    
    # print candidate row 
    print(f"{name:11} {percentVote:6.3f}%  ({row[1]})")

# Print winner of election
print("------------------------------")    
print("Winner:  " + candidateVotes[0][0])  # Because of sorting, winner is first row in matrix
print("------------------------------")    

# Save the same report to file
with open('JTomines_PyPoll-ElectionResults.txt', 'w') as resultFile:
    resultFile.write("\nElection Results")
    resultFile.write("\n------------------------------")
    
    # Print Total Votes
    resultFile.write("\nTotal Votes:  " + str(numVotes))
    resultFile.write("\n------------------------------")
    
    # Print each candidates voting summary
    for row in candidateVotes:
        
        # determine percentage
        percentVote = row[1] * 100 / numVotes
    
        # apply display formatting for name
        name = row[0] + ":"
        
        # print candidate row 
        resultFile.write(f"\n{name:11} {percentVote:6.3f}%  ({row[1]})")
    
    # Print winner of election
    resultFile.write("\n------------------------------")    
    resultFile.write("\nWinner:  " + candidateVotes[0][0])  # Because of sorting, winner is first row in matrix
    resultFile.write("\n------------------------------")    
