"""--------------------------------------------------------------------------
Unit 03 Assignment - Py Me Up, Charlie
Sub Assignment:  PyBoss
Created by:      Jose Tomines
Notes:        1) Not sure if this is mandatory for the assignment, but
                 submitted it also
              2) Used the "us_state_abbrev" dictionary as was provided in
                 in the Readme.md link
--------------------------------------------------------------------------"""

# Import dependencies
import os
import csv

us_state_abbrev = {
    'Alabama': 'AL',
    'Alaska': 'AK',
    'Arizona': 'AZ',
    'Arkansas': 'AR',
    'California': 'CA',
    'Colorado': 'CO',
    'Connecticut': 'CT',
    'Delaware': 'DE',
    'Florida': 'FL',
    'Georgia': 'GA',
    'Hawaii': 'HI',
    'Idaho': 'ID',
    'Illinois': 'IL',
    'Indiana': 'IN',
    'Iowa': 'IA',
    'Kansas': 'KS',
    'Kentucky': 'KY',
    'Louisiana': 'LA',
    'Maine': 'ME',
    'Maryland': 'MD',
    'Massachusetts': 'MA',
    'Michigan': 'MI',
    'Minnesota': 'MN',
    'Mississippi': 'MS',
    'Missouri': 'MO',
    'Montana': 'MT',
    'Nebraska': 'NE',
    'Nevada': 'NV',
    'New Hampshire': 'NH',
    'New Jersey': 'NJ',
    'New Mexico': 'NM',
    'New York': 'NY',
    'North Carolina': 'NC',
    'North Dakota': 'ND',
    'Ohio': 'OH',
    'Oklahoma': 'OK',
    'Oregon': 'OR',
    'Pennsylvania': 'PA',
    'Rhode Island': 'RI',
    'South Carolina': 'SC',
    'South Dakota': 'SD',
    'Tennessee': 'TN',
    'Texas': 'TX',
    'Utah': 'UT',
    'Vermont': 'VT',
    'Virginia': 'VA',
    'Washington': 'WA',
    'West Virginia': 'WV',
    'Wisconsin': 'WI',
    'Wyoming': 'WY',
}

employee_csv = []

# Declare pathname of csvfile
csvpath = os.path.join("Resources", "employee_data.csv")

# Open csvfile        
with open(csvpath, 'r', newline = "") as csvfile:
    
    # Skip header row
    csvfile.readline()
    
    # Read each line in csvfile as list
    csvreader = csv.reader(csvfile, delimiter=",")

    # Read employee data from file into list
    emp_csv = [row for row in csvreader]
    
# Create new list adding header line
employee_csv.append(["Emp ID","First Name","Last Name","DOB","SSN","State"])

# loop through original list to get the various information
for emp in emp_csv:
    
    # Derive first name and last name
    name = emp[1].split(" ")
    firstName = name[0]
    lastName = name[1]
    
    # Re-format DOB
    dob = emp[2].split("-")
    yearDOB = str(dob[0])
    monthDOB = str(dob[1])
    dayDOB = str(dob[2]) 
    birthDate = monthDOB + "/" + dayDOB + "/" + yearDOB
    
    # Mask the SSN
    ssn = emp[3].split("-")
    secureSSN = "***-**-" + ssn[2]
    stateAbb = us_state_abbrev[emp[4]]
    
    # Add the employee to the list in the proper format
    employee_csv.append([emp[0], firstName, lastName, birthDate, secureSSN, stateAbb])

# Create output file
with open('employee_data_reformatted.csv', 'w', newline="") as resultfile:
    writer = csv.writer(resultfile)
    
    # write the new employee matrix per line to the output file
    writer.writerows(employee_csv)

 