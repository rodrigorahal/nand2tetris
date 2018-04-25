// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.

    @i    // i refers to some mem. location
    M=1   // i=1
    @R2   // sum
    M=0   // R2=0

(LOOP)

    @i
    D=M     // D=i

    @R0
    D=D-M   // D=i-R0

    @END
    D;JGT   // if (i-R0)>0 goto END

    @R1
    D=M    // D=R1

    @R2
    M=D+M   // sum=sum+R2

    @i
    M=M+1

    @LOOP
    0;JMP

(END)
    @END
    0;JMP   // Infinite Loop
