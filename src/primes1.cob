*> Author: Michael Wirth, re-engineered by Jovana Kusic
*> Student #: 0955683
*> Date: March 22nd, 2019
*> File: primes1, original code with the addition of divisions.
*> Description: this program reads in a file of numbers as entered by the user
*> and then determines which numbers are prime. The results are then written to
*> the second file name inputted by the user. 

identification division.
program-id. primes1.

*> File variables are initialized
environment division.
input-output section.
file-control.
select input-file assign to "primes.dat"
    organization is line sequential
    file status file-status.
select output-file assign to "primes.out"
    organization is line sequential.
select standard-input assign to keyboard.

*> File pointers are initialized
data division.
file section.
fd output-file.
    01 out-line pic x(80).
fd standard-input.
    01 stdin-record pic x(80).

*> All variables to be used are initialized
working-storage section.
    77  n  picture s9(9).
    77  r  picture s9(9) usage is computational.
    77  i  picture s9(9) usage is computational.
    77  input-file-name pic x(20).
    77  output-file-name pic x(20).
    01  file-status pic 99.
        88 file-ok value 0.
    01  in-card.
        02 in-n   picture z(9).
        02 filler picture x(71).
    01  title-line.
        02 filler picture x(6) value spaces.
        02 filler picture x(20) value 'prime number results'.
    01  under-line.
        05 filler picture x(32) value
           ' -------------------------------'.
    01  not-a-prime-line.
        02 filler picture x value space.
        02 out-n-2 picture z(8)9.
        02 filler picture x(15) value ' is not a prime'.
    01  prime-line.
        02 filler picture x value space.
        02 out-n-3 picture z(8)9.
        02 filler picture x(11) value ' is a prime'.
    01  error-mess.
        02 filler picture x value space.
        02 out-n picture z(8)9.
        02 filler picture x(14) value ' illegal input'.

*> Body of code logic begins
procedure division.
    display "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*".
    display "              PRIME # CALCULATOR"
    display "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*".

    *> Grabs file name to open and write to

    
    *> Ensures the file exists in order to read its contents
    open input input-file.
    if not file-ok
    then
        display "File could not be opened!"
        stop run
    else
        open output output-file
    end-if.
    
    *> Prints title of results to the file
    write out-line from title-line after advancing 0 lines.
    write out-line from under-line after advancing 1 line.
    *> Reads each number into memory
1.  read input-file into in-card at end go to finish.
    move in-n to n.
    *> Checks for illegal input
    if n is greater than 1 go to b1.
    move in-n to out-n.
    write out-line from error-mess after advancing 1 line.
    go to 1.
    *> Any number > 1 and < 4 is considered prime
b1. if n is less than 4 go to 3.
    *> Checks to see if the number is divisble by another number
    move 2 to r.
2.  divide r into n giving i.
    multiply r by i.
    if i is not equal to n go to b2.
    move in-n to out-n-2.
    write out-line from not-a-prime-line after advancing 1 line.
    go to 1.
b2. add 1 to r.
    if r is less than n go to 2.
3.  move in-n to out-n-3.
    write out-line from prime-line after advancing 1 line.
    go to 1.
*> Closes all files that were opened and stops running program
finish.
    display "COMPLETED: results saved to primes.out".
    close input-file, output-file, standard-input.
    stop run.
end program primes1.
