.data
buffer:         .space  19   # Buffer to store Header content
filename:       .asciiz "C:/Users/Aimee Simons/Desktop/2023/Lectures/Semester 2/CSC2002S/Assignments/Assignment4/CSC2002S_Assignment4/house_64_in_ascii_cr.ppm"
newline:        .asciiz "\n"
lineBuffer:     .space 4
colourHeader:   .asciiz "P3\n# Tre\n64 64\n255"
.text
.globl main

main:
    # Open the file for reading
    li      $v0, 13             # Syscall code for open (13)
    la      $a0, filename       # Load the address of the filename
    li      $a1, 0              
    li      $a2, 0
    syscall
    # Check if the file opened successfully
    bltz    $v0, exit           # If $v0 is negative, there was an error opening the file

    move    $a0, $v0 

    li      $v0, 14             # Syscall code for read (14)
    la      $a1, buffer         # Load the address of the buffer
    li      $a2, 19            # Read Header of file
    syscall

    read_loop:
        li $v0, 14
        la $a1, lineBuffer # read numbers 
        li $a2, 4
        syscall

        bltz    $v0, close_file # end of file

        li $v0, 4
        la $a0, lineBuffer
        syscall
        j read_loop



close_file:
    # Close the file
    li      $v0, 16             # Syscall code for close (16)
    move    $a0, $v0            # File descriptor (returned by open) in $a0
    syscall

exit:
    # Exit the program
    li      $v0, 10             # Syscall code for exit (10)
    syscall






