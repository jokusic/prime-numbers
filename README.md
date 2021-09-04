## Program Description:
this program reads in a file of numbers as entered by the user and then determines which numbers are prime. The results are then written to the second file name inputted by the user. 

## How to run the program:
- cd to the folder containing the "primes1.cob", "primes2.cob" and "primes3.cob" files
- type 'cobc -x -free -Wall primes(1,2,3).cob' to compile
- to run the program type './primes(1,2,3)'

- Note 1: brackets indiciate you can have a 1 or 2 or three to complete the line.
- Note 2: A file to be read in should already exist (will throw error if it does not).

## Assumptions:
The user will always be entering in positive numbers for primes3 when they
are requested to enter numbers by the keyboard.

The file to be read in will always be in the proper format (one positive number per line)
and it will not contain any letters or extra spaces.

