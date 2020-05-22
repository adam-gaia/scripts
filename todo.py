#!/usr/bin/env python3
import sys
import os
import subprocess

# Words to search for
searchTerms = ["TODO", "FIXME", "HACK", "WIP"]

# Color code shortcuts
# TODO: make an arg to turn colors on/off
class c:
    RED='\033[31m'
    GREEN='\033[32m'
    YELLOW='\033[33m'
    BLUE='\033[34m'
    BLACK='\033[90m'
    PURPLE='\033[35m'
    CYAN='\033[35m'
    NORMAL='\033[m'
    UNDERLINE_ON='\033[4m'
    UNDERLINE_OFF='\033[24m'
    BOLD_ON='\033[1m'
    BOLD_OFF='\033[21m'

# Function to check if in git repo
def isGitRepo(path):
    return subprocess.call(["git", "status"], stderr=subprocess.STDOUT, stdout=open(os.devnull, 'w'), cwd=path) == 0

# Parse Args
if len(sys.argv) < 2: # If no args, check that we are running in a git repo

	# Exit early if not called in a git repo
	if not isGitRepo('.'):
		print(c.RED + "Error:" + c.NORMAL + " please provide input file(s)") # TODO: print to stderr
		exit(1)
	else:
		# Grab all files tracked by git
		command = "git ls-tree -r HEAD --name-only".split()
		result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

		if result.returncode != 0:
			print(c.RED + "Error" + c.NORMAL + " when parsing tracked git files") # TODO: print to stderr
			exit(1)
		filesToSearch = result.stdout.decode("utf-8").split('\n')
		filesToSearch[:] = [x for x in filesToSearch if x] # Remove any empty strings

else: # Take files to read from input args
	filesToSearch = sys.argv[1:]

# Create a dict of dicts to hold saved lines
outputDicts = dict()
for term in searchTerms:
	outputDicts[term] = dict()

# Loop over files
numFiles = len(filesToSearch)
for fileName in filesToSearch:

	if numFiles > 1:
		print(c.PURPLE + fileName + c.NORMAL)

	# Loop over lines of file
	with open(fileName, 'r') as f:
		lineNum = 1
		for line in f:

			# Check if each search term appears on the line
			for term in searchTerms:
				if term.lower() in line.lower():
					outputDicts[term][lineNum] = line.lstrip().strip()

			lineNum += 1

	# Print outputs
	for term in searchTerms:
		for lineNum, line in outputDicts[term].items():
			print("    ", end='')
			print(c.GREEN + str(lineNum) + c.NORMAL, end='')
			print(":", end='')
			print(line.replace(term, c.RED + term + c.NORMAL).replace(term.lower(), c.RED + term.lower() + c.NORMAL))

