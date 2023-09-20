.data
buffer:         .space  70000   # Buffer to store Header content
filename:       .asciiz "C:/Users/Aimee Simons/Desktop/2023/Lectures/Semester 2/CSC2002S/Assignments/Assignment4/CSC2002S_Assignment4/house_64_in_ascii_cr.ppm"
newline:        .asciiz "\n"
colourHeader:   .asciiz "P3\n# Tre\n64 64\n255"
newNumber:      .space 10
IntNum:         .space 10
message1:       .asciiz "Average pixel value of the origianl image:\n"
message2:       .asciiz "Average pixel value of the new image:\n"
.text
.globl main

main:
    la $s2, newNumber
    la $t8, IntNum
    # Open the file for reading
    li      $v0, 13             # Syscall code for open (13)
    la      $a0, filename       # Load the address of the filename
    li      $a1, 0              
    li      $a2, 0
    syscall
    # Check if the file opened successfully
    bltz    $v0, exit           # If $v0 is negative, there was an error opening the file

    move    $a0, $v0 
    li $t1, 0 # Sum variable for average 1
    li $t2, 0 # Sum variable for average 2
    
    li $v0, 14
    la $a1, buffer
    la $a2, 70000
    syscall
    lb $t3, 0($a1)
    beq, $t3, 0, close_file # check if it is an empty file
    add $a1, $a1, 19 # skip over header lines
    
    move $t0, $a1
    loop_read:
        lb $t3, 0($t0)
        ble $t3, 0, close_file    # if reached the end of the file
        beq $t3, 13, convert   # if an endline character is found
        sb $t3, 0($s2)   
        addi $t0, $t0, 1
        addi $s2, $s2, 1
        addi $t4, $t4, 1
        j loop_read

        


convert:
    li $t6, 0
    sub $s2, $s2, $t4
    loopNum:
        lb $t7, 0($s2)
        beq $t7, 0, end_loop
        mul $t6, $t6, 10
        sub $t7, $t7, '0'
        add $t6, $t6, $t7
        addi $s2, $s2, 1
        j loopNum
    end_loop:
        addi $t0, $t0, 1
        sub $s2, $s2, $t4
        move $t4, $zero 
        add $t1, $t1, $t6 # add number to average1 sum
        add $t6, $t6, 10 # add 10 for brightness
        add $t2, $t2, $t6   # add number to average2 sum
    j loop_read

close_file:
    # Close the file
    li      $v0, 16             # Syscall code for close (16)
    move    $a0, $v0            # File descriptor (returned by open) in $a0
    syscall

    li $v0, 4
    la $a0, message1
    syscall

    li $v0, 4
    la $a0, message2
    syscall

exit:
    # Exit the program
    li      $v0, 10             # Syscall code for exit (10)
    syscall






