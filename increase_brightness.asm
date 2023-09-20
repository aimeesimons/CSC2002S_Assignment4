.data
buffer:         .space  70000   # Buffer to store Header content
filename:       .asciiz "C:/Users/Aimee Simons/Desktop/2023/Lectures/Semester 2/CSC2002S/Assignments/Assignment4/CSC2002S_Assignment4/house_64_in_ascii_cr.ppm"
newline:        .asciiz "\n"
colourHeader:   .asciiz "P3\n# Tre\n64 64\n255"
newNumber:      .space 10
IntNum:         .space 10
.text
.globl main

main:
    la $s2, newNumber
    # Open the file for reading
    li      $v0, 13             # Syscall code for open (13)
    la      $a0, filename       # Load the address of the filename
    li      $a1, 0              
    li      $a2, 0
    syscall
    # Check if the file opened successfully
    bltz    $v0, exit           # If $v0 is negative, there was an error opening the file

    move    $a0, $v0 
    move $t1, $zero # Sum variable for average 1
    move $t2, $zero # Sum variable for average 2
    
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
        beq $t3, 10, convert   # if an endline character is found
        sb $t3, 0($s2)   
        addi $t0, $t0, 1
        addi $s2, $s2, 1
        addi $t4, $t4, 1
        j loop_read

        


convert:
    move $t6, $zero
    sub $s2, $s2, $t4
    loopNum:
        lb $t7, 0($t2)
        sb $t7, 0($t8)



    addi $t0, $t0, 1
    move $t4, $zero    
    j loop_read

close_file:
    # Close the file
    li      $v0, 16             # Syscall code for close (16)
    move    $a0, $v0            # File descriptor (returned by open) in $a0
    syscall

exit:
    # Exit the program
    li      $v0, 10             # Syscall code for exit (10)
    syscall






