.data
buffer:         .space  60000   # Buffer to store file contents
filename:       .asciiz "C:/Users/Aimee Simons/Desktop/2023/Lectures/Semester 2/CSC2002S/Assignments/Assignment4/CSC2002S_Assignment4/sample_images/house_64_in_ascii_lf.ppm"
newNumber:      .space 10
outputStr:      .space 60000 # buffer to store the output string
outputFile:     .asciiz "C:/Users/Aimee Simons/Desktop/2023/Lectures/Semester 2/CSC2002S/Assignments/Assignment4/CSC2002S_Assignment4/output files/greyscale_House.ppm"
greyHeader:   .asciiz "P2\n# Hse\n64 64\n255\n" #file header
newline:        .asciiz "\n"
.text
.globl main

main:
    la $s2, newNumber # load the address of the number
    la $s3, outputStr #load the address of the output string; this will be modified.
    la $s1, outputStr #load the address of the output string; this will not be modified.
    la $s4, greyHeader
    move $t1, $zero
    loop1:
        lb $t0, 0($s4)  # '
        sb $t0, 0($s3)
        beq $t0, 10, increment
        beq $t1, 4, openFile
        addi $s3, $s3, 1      # copying the header to the output string
        addi $s4, $s4, 1
        j loop1
    increment:
        addi $t1, $t1, 1
        addi $s3, $s3, 1
        addi $s4, $s4, 1
        j loop1           #'

    openFile:
        # Open the file for reading
        li      $v0, 13             # Syscall code for open (13)
        la      $a0, filename       # Load the address of the filename
        li      $a1, 0              
        li      $a2, 0
        syscall
    # Check if the file opened successfully
    bltz    $v0, exit           # If $v0 is negative, there was an error opening the file

    move    $a0, $v0 
    li $t1, 0 # Sum variable for average
    li $t2, 0 # counter for average

    li $v0, 14
    la $a1, buffer
    la $a2, 60000
    syscall

    lb $t3, 0($a1)
    beq, $t3, 0, close_file # check if it is an empty file
    add $a1, $a1, 19 # skip over header lines
    
    move $t0, $a1
    loop_read:
        lb $t3, 0($t0)
        ble $t3, 0, close_file    # if reached the end of the file
        beq $t3, 10, convert   # if an endline character is found
        beq $t3, 13, close_file # if reached the end of the file, in case crlf file is used , this is unused if not
        sb $t3, 0($s2)   
        addi $t0, $t0, 1
        addi $s2, $s2, 1
        addi $t4, $t4, 1
        j loop_read

        


convert:              #converting to an integer
    li $t6, 0
    sub $s2, $s2, $t4
    move $t8, $zero
    loopNum:
        lb $t7, 0($s2)
        beq $t8, $t4, end_loop
        mul $t6, $t6, 10
        sub $t7, $t7, '0'
        add $t6, $t6, $t7
        addi $s2, $s2, 1
        addi $t8, $t8, 1
        j loopNum
    end_loop:
        addi $t0, $t0, 1
        sub $s2, $s2, $t4
        add $t1, $t1, $t6 # add number to average sum
        addi $t2, $t2, 1
        beq $t2, 3, avg # if the counter is equal to 3, calculate the average
        move $t4, $zero 
        j loop_read
        grey:
            move $s0, $zero
            move $s7, $t1
            loopLen:
                div $s7, $s7, 10
                addi $s0, $s0, 1
                beqz $s7, cont
                j loopLen
            cont:
                move $t4, $s0
                sub $t4, $t4, 1
                add $s3, $s3, $t4 # offset the output string to accomondate for the length of the number.e.g. 1 for 2 digits and 2 for 3 digits.
                move $t4, $zero 
                move $t5, $zero
                convertBack:        # convert back to string to print to textfile 
                    div $t1, $t1, 10
                    mfhi $t7
                    beq $t7, 0, zero # add endline character to string
                    add $t7, $t7, '0'
                    sb $t7, 0($s3)
                    addi $s3, $s3, -1 #copying the string "in reverse"
                    addi $t5, $t5, 1  # counter for loop
                    j convertBack
           
avg:
    div $t1, $t1, $t2 # divide by 3
    li $t2, 0 #set counter to zero
    j grey #save to output string

zero: # if the remainder is zero
    beq $t1, 0, print # if the quotient is also zero
    add $t7, $t7, '0'
    sb $t7, 0($s3)
    addi $s3, $s3, -1
    addi $t5, $t5, 1  # counter for loop
    j convertBack


print:
    addi $t5, $t5, 1
    add $s3, $s3, $t5

    addi $t9, $zero, 0xA
    sb $t9, 0($s3)                # add a newline character to the end of the string
    addi $s3, $s3, 1

    j loop_read

close_file:
    # Close the file
    li      $v0, 16             # Syscall code for close (16)
    move    $a0, $v0           # File descriptor (returned by open) in $a0
    syscall

    li $v0, 13           # open output file
    la $a0, outputFile
    li $a1, 1
    li $a2, 0
    syscall

    sub $s1, $s3, $s1 # calculate offset

    move $a0, $v0
    li $v0, 15
    la $a1, outputStr #write output string to file
    move $a2, $s1   # number of bytes to write
    syscall

    li $v0, 16    # close the file
    move $a0, $v0
    syscall

exit:
    # Exit the program
    li      $v0, 10             # Syscall code for exit (10)
    syscall






