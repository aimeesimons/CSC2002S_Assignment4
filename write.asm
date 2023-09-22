.data
    filename:   .asciiz "C:/Users/Aimee Simons/Desktop/2023/Lectures/Semester 2/CSC2002S/Assignments/Assignment4/CSC2002S_Assignment4/house_64_in_ascii_lf.ppm"
    message:    .asciiz "Hello World!\n"
    colourHeader:   .asciiz "P3\n# Hse\n64 64\n255\n"
    outputStr:      .space 30
    number:         .asciiz "177\n"

.text
.globl main
    main:
        la $s3, outputStr
        la $s4, colourHeader
        move $t1, $zero
        la $s0, number
    loop1:
        lb $t0, 0($s4)
        sb $t0, 0($s3)
        beq $t0, 10, increment
        beq $t1, 4, loop
        addi $s3, $s3, 1
        addi $s4, $s4, 1
        j loop1
    increment:
        addi $t1, $t1, 1
        addi $s3, $s3, 1
        addi $s4, $s4, 1
        j loop1
     
        loop:
            loop2:
                lb $t3, 0($s0)
                sb $t3, 0($s3)
                beq $t3, 10 print
                addi $s3, $s3, 1
                addi $s0, $s0, 1
            j loop2
            
print:
    li $v0, 13
    la $a0, filename
    li $a1, 1
    li $a2, 0
    syscall
    
    move $t1, $v0

    li $v0, 15
    move $a0, $t1
    la $a1, outputStr
    li $a2, 23
    syscall

    li $v0, 16
    move $a0, $t1
    syscall



    # Exit the program
    li      $v0, 10
    syscall
