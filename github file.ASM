format PE console
;cinvoke getchar
entry start
include 'win32ax.inc'

section '.data' data readable writable
    instruction file 'reading.txt'
    indexcounter dd 0
    formatChar db '%c', 0
    endMsg db 'done', 0

section '.code' code readable executable
start:
    mov ecx, [indexcounter]

main_loop:
    mov eax, [indexcounter]
    lea ebx, [instruction + eax]
    mov al, byte [ebx]
    test al, al
    jz end_loop
    push eax
    push formatChar
    call [printf]
    cinvoke getchar
    inc dword [indexcounter]
    jmp main_loop

end_loop:
    invoke ExitProcess, 0
section '.idata' import data readable
    library kernel, 'kernel32.dll',\
            msvcrt, 'msvcrt.dll'

    import kernel,\
            ExitProcess, 'ExitProcess'

    import msvcrt,\
            printf, 'printf',\
            getchar, 'getchar'