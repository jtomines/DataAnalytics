"""--------------------------------------------------------------------------
Unit 03 Assignment - Py Me Up, Charlie
Sub Assignment:  PyParagraph
Created by:      Jose Tomines

Notes:  I have always tried to make a program as universal as possible without
        looking at the specific data it will work on.  Unfortunately
        universality can actually add too much time, especially if the solution
        is for a one-off situation.  This exercise actually had me thinking
        of different situations that don't get captured with a simple split
        statement.  Here are the specific issues which I dealt with:
        1) Hyphenated Words.  Looking into the 2 different files
           I can see a few hyphenated words which are really 2 words to
           describe complex concept.  At the same time there are legitmate
           hyphenated words that are actually just 1 word, eg. fifty-five.
           At the same time, One-hundred-and-one, in my opinion should be
           consider 4 words.  So, I decided to implement the rule that all
           hyphenated words should be considered many words instead of one,
           except for those numbers between 21 - 99.
        2) Determining sentence ends based on punctuation.  You can't really
           do a split based solely on a period, exclamation point, or question
           mark... since titles such as Mr. and Ph.D would cause issues.  ". ",
           "? ", & "! ", may work for most cases (except Mr. ), but then
           quotes would screw that up (even for the regex hint provided)... 
           eg. He said, "Crap!".  I did find a comprehensive function
           created by this Ph.D that works on "Huckleberry Finn", so I decided
           to use the same concepts, but not so comprehensively.
        3) Determining number of characters in a word.  This is also an issue
           because some non-alphanumeric characters are still considered part
           of the word, eg $200, or 35%, while others are just part of the
           punctuation.  And even the character "&" is a word on its own.  Went
           with my gut feel!
        So taking these two ideas, I decided on the solution below.  Perhaps
        I could have done it with REGEX, but I wanted to get this over with
        within the hour instead of taking the time to learn REGEX!
        
        Note that I also put in a prompt so that you can decide which file
        to analyze!
--------------------------------------------------------------------------"""

# Import dependencies
import os
import csv
import re

# Request which file to work on
print("Which file do you wish to analyze:  (1) paragraph_1.txt or (2) paragraph_2.txt")
fileChoice = input("Please enter (1) or (2) ")
while fileChoice != "1" and fileChoice != "2":
    fileChoice = input("Invalid entry.  Please enter (1) or (2)  ")

# Declare pathname of csvfile based on choice above
if fileChoice == "1":
    filepath = os.path.join("Resources", "paragraph_1.txt")
else:
    filepath = os.path.join("Resources", "paragraph_2.txt")

# Open csvfile and read paragraph into memory variable       
with open(filepath, encoding="utf-8") as txtfile:
    rawParagraph = txtfile.readline()

# Prepare the word forms of (21 - 99) so that they can be considered one word
prepParagraph = rawParagraph.replace("ty-one", "tyone")
prepParagraph = prepParagraph.replace("ty-two", "tytwo")
prepParagraph = prepParagraph.replace("ty-three", "tythree")
prepParagraph = prepParagraph.replace("ty-four", "tyfour")
prepParagraph = prepParagraph.replace("ty-five", "tyfive")
prepParagraph = prepParagraph.replace("ty-six", "tysix")
prepParagraph = prepParagraph.replace("ty-seven", "tyseven")
prepParagraph = prepParagraph.replace("ty-eight", "tyeight")
prepParagraph = prepParagraph.replace("ty-nine", "tynine")


# With numbers gone, remove all hyphens from hyphenated word
prepParagraph = prepParagraph.replace("-", " ")

# Prepare any Titles
prepParagraph = prepParagraph.replace("Mr. ", "Mr ")
prepParagraph = prepParagraph.replace("Mrs. ", "Mrs ")
prepParagraph = prepParagraph.replace("Ms. ", "Ms ")
prepParagraph = prepParagraph.replace("Dr. ", "Dr ")
prepParagraph = prepParagraph.replace("Ph.D ", "PhD ")
prepParagraph = prepParagraph.replace("Mr. ", "Mr ")
# There is probably more, but I can't replicate the universe

# Prepare for end of sentences
prepParagraph = prepParagraph.replace('." ', '<STOP> ')
prepParagraph = prepParagraph.replace('!" ', '<STOP> ')
prepParagraph = prepParagraph.replace('?" ', '<STOP> ')
prepParagraph = prepParagraph.replace('.) ', '<STOP> ')
prepParagraph = prepParagraph.replace('!) ', '<STOP> ')
prepParagraph = prepParagraph.replace('?) ', '<STOP> ')
prepParagraph = prepParagraph.replace('. ', '<STOP> ')
prepParagraph = prepParagraph.replace('! ', '<STOP> ')
prepParagraph = prepParagraph.replace('? ', '<STOP> ')

# Remove common punctuations except & @ $ % < >
prepParagraph = prepParagraph.replace('!', '')
prepParagraph = prepParagraph.replace('#', '')
prepParagraph = prepParagraph.replace('*', ' ')
prepParagraph = prepParagraph.replace('(', '')
prepParagraph = prepParagraph.replace(')', '')
prepParagraph = prepParagraph.replace('+', ' ')
prepParagraph = prepParagraph.replace('_', ' ')
prepParagraph = prepParagraph.replace(',', '')
prepParagraph = prepParagraph.replace('"', '')
prepParagraph = prepParagraph.replace('{', '')
prepParagraph = prepParagraph.replace('}', '')
prepParagraph = prepParagraph.replace('[', '')
prepParagraph = prepParagraph.replace(']', '')
prepParagraph = prepParagraph.replace('?', '')
prepParagraph = prepParagraph.replace('/', ' ')
prepParagraph = prepParagraph.replace(':', '')
prepParagraph = prepParagraph.replace(':', '')
prepParagraph = prepParagraph.replace("'", "")

# Ensure there are no double spaces
prepParagraph = prepParagraph.replace('   ', ' ')
prepParagraph = prepParagraph.replace('  ', ' ')
prepParagraph = prepParagraph.replace('.', '')


# Parse paragraph into sentences
sentences = prepParagraph.split("<STOP> ")

# Parse each line into words
sentenceWords = []
for line in sentences:
    sentenceWords.append(line.split(" "))

# Create list of the size of each word in the paragraph
lettersPerWord = []
for line in range(int(len(sentenceWords))):
    for word in sentenceWords[line]:
        lettersPerWord.append(int(len(word)))

# Calculate the desired values for the Analysis
wordCount = int(len(lettersPerWord))
sentenceCount = int(len(sentences))
meanLetterCount = round(sum(lettersPerWord) / wordCount,1)
meanSentenceLength = round(wordCount / sentenceCount,1)

# Display Paragraph Analysis Report
print(f"\n\nParagraph Analysis of file: {filepath}")
print("-----------------------------------------------------")
print(f"Approximate Word Count:      {wordCount}")
print(f"Approximate Sentence Count:  {sentenceCount}")
print(f"Average Letter Count:        {meanLetterCount}")
print(f"Average Sentence Length:     {meanSentenceLength}")





