// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed.
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.


@8192  // number of registers to fill
D=A
@n
M=D   // n = 8192

@SCREEN
D=A
@n
M=D+M   // n = screen's base address + 8192

@key
M=0   // key = 0

@fill
M=0   // fill = 0

(READ)
    // read contents of the kbd register and save it to a key register
    // jump to FILL if kbd != last pressed key
    // jump back to read if kbd == last pressed key

    @KBD
    D=M
    @key
    D=D-M
    @READ
    D;JEQ   // if KBD == key goto READ

    @KBD
    D=M
    @key
    M=D

    @key
    D=M
    @BLACK
    D;JGT
    @WHITE
    D;JEQ

(BLACK)
    D=-1
    @fill
    D=D-M
    @READ
    D;JEQ

    @fill
    M=-1
    @FILL
    0;JMP

(WHITE)
    D=0
    @fill
    D=D-M
    @READ
    D;JEQ

    @fill
    M=0
    @FILL
    0;JMP

(FILL)
    // fill the screen with black or white pixels and jump back to read

    @SCREEN
    D=A
    @addr
    M=D   // addr = 16384 (screen's base address)

    (LOOP)
        @addr
        D=M
        @n
        D=D-M
        @READ
        D;JGT   // if i>n goto READ

        @fill
        D=M
        @addr
        A=M
        M=D   // RAM[addr]=-1 or 0

        @addr
        M=M+1   // addr++
        @LOOP
        0;JMP
