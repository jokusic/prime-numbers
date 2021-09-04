*> Author: Michael Worth, re-engineered by Jovana Kusic
*> Student #: 0955683
*> Date: March 22nd, 2019
*> File: primes2, re-engineered code to remove obsolete features.
*> Description: this program reads in a file of numbers as entered by the user
*> and then determines which numbers are prime. The results are then written to
*> the second file name inputted by the user. 

identification division.
program-id. primes2.

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
    77  num  pic s9(9).
    77  remain pic s9(9) usage is comp.
    77  counter  pic s9(9) usage is comp.
    77  eof pic x(4).
    77  temp pic s9(9).
    77  input-file-name pic x(20).
    77  output-file-name pic x(20).
    01  file-status pic 99.
        88 file-ok value 0.
    01  in-card.
        02 in-n   pic z(9).
        02 filler pic x(71).
    01  title-line.
        02 filler pic x(6) value spaces.
        02 filler pic x(20) value 'prime number results'.
    01  under-line.
        05 filler pic x(32) value
           ' -------------------------------'.
    01  not-a-prime-line.
        02 filler pic x value space.
        02 out-n-2 pic z(8)9.
        02 filler pic x(15) value ' is not a prime'.
    01  prime-line.
        02 filler pic x value space.
        02 out-n-3 pic z(8)9.
        02 filler pic x(11) value ' is a prime'.
    01  error-mess.
        02 filler pic x value space.
        02 out-n pic z(8)9.
        02 filler pic x(14) value ' illegal input'.

*> Body of code logic begins
procedure division.
    display "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*".
    display "              PRIME # CALCULATOR"
    display "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*".
    
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
    read input-file into in-card
    perform until eof = "TRUE"
        
        move in-n to num
        
        *> Checks for illegal input
        if num <= 1
        then
            move in-n to out-n
            write out-line from error-mess after advancing 1 line
        end-if
        
        if num >= 4
        then
            move 2 to remain
            *> Checks to see if the number is divisble by another number
            perform until (remain >= num or temp = num)

                divide remain into num giving counter
                multiply remain by counter
                
                if counter is not equal to num
                then
                    add 1 to remain
                else
                    move in-n to out-n-2
                    write out-line from not-a-prime-line after advancing 1 line
                    *> Exit loop condition
                    move num to temp
                end-if
            end-perform
        end-if
        
        *> Any number > 1 and < 4 is considered prime 
        if (remain >= num) or (num < 4 and num > 1)
        then
            move in-n to out-n-3
            write out-line from prime-line after advancing 1 line
        end-if
            
        *> Set end of loop condiiton
        read input-file into in-card
            at end move "TRUE" to eof
        end-read    
    end-perform.
      
    *> Closes all files that were opened and stops running program  
    display "COMPLETED: results saved to primes.out". 
    close input-file, output-file, standard-input.
    stop run.
end program primes2.

