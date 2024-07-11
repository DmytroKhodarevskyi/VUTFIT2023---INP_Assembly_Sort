; Autor reseni: Dmytro Khodarevskyi (xkhoda01)
; Pocet cyklu k serazeni puvodniho retezce: 3792
; Pocet cyklu razeni sestupne serazeneho retezce: 4778
; Pocet cyklu razeni vzestupne serazeneho retezce: 278
; Pocet cyklu razeni retezce s vasim loginem: 870
; Implementovany radici algoritmus: Bubble sort
; ------------------------------------------------

; DATA SEGMENT
                .data
; login:          .asciiz "vitejte-v-inp-2023"    ; puvodni uvitaci retezec
; login:          .asciiz "vvttpnjiiee3220---"  ; sestupne serazeny retezec
; login:          .asciiz "---0223eeiijnpttvv"  ; vzestupne serazeny retezec
 login:          .asciiz "xkhoda01"            ; SEM DOPLNTE VLASTNI LOGIN
                                                ; A POUZE S TIMTO ODEVZDEJTE

params_sys5:    .space  8   ; misto pro ulozeni adresy pocatku
                            ; retezce pro vypis pomoci syscall 5
                            ; (viz nize - "funkce" print_string)

; CODE SEGMENT
                .text
main:
        ; SEM DOPLNTE VASE RESENI
        daddi   r4, r0, login   ; vzorovy vypis: adresa login: do r4

        daddi r7, r4, 0 ; r7 = r4
        jal end_swap ; sort string

end_line_cycle:
        daddi r4, r7, 0 ; r4 = r7, reset pointer
        beq r5, r0, end_sort ; if swap flag is 0, then end of sort
        daddi r5, r0, 0 ; r5 = 0, reset swap flag

end_swap:
        lbu r1, 0(r4) ; r1 = a[i]
        lbu r2, 1(r4) ; r2 = a[i+1]

        compare:
                beq r2, r0, end_line_cycle ; if r2 = '\0', then end of string
                ; the value bubbled up to the end of the string

                ; r1 < r2? // a[i] < a[i+1]?
                sltu r3, r1, r2 ; if r1 < r2 then r3 = 1 else r3 = 0
                bnez r3, no_swap ; if r3 = 1, then r2 is greater than r1, no swap
                xor r3, r1, r2 ; r8 = r1 XOR r2
                beqz r3, no_swap ; if r8 = 0, then r1 = r2, no swap

        swap: 
                sb r1, 1(r4) ; swap
                sb r2, 0(r4) ; swap
                daddi r5, r0, 1 ; set the swap flag

        no_swap:
                daddi r4, r4, 1 ; increment pointer
                jal end_swap ; continue sorting until end of string

end_sort:
        jal print_string ; print string

        syscall 0   ; halt


print_string:   ; adresa retezce se ocekava v r4
                sw      r4, params_sys5(r0)
                daddi   r14, r0, params_sys5    ; adr pro syscall 5 musi do r14
                syscall 5   ; systemova procedura - vypis retezce na terminal
                jr      r31 ; return - r31 je urcen na return address
