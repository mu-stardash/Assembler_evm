#    Демонстрация директив определения данных.
#    Переполнение

#    Ассемблирование и редактирование связей - команда make

    .include "my-macro" # подключение файла с макроопределениями

.data # секция данных, распределение памяти


#                       Система счисления операнда

Diff_bases: .byte  65   # 10
           .byte  0101  # 8
           .byte  041   # 8
           .byte  0x41  # 16
           .byte  0X41  # 16

#                  8      16     10
           .long  02345, 0x4E5, 1253

#                       Выражение

Arifm_Expression:

            .byte 35+30, 20+45
            .byte 70-5, 80-15

Address_expression:

            .long Arifm_Expression, Address_expression

Str:    .ascii  "abc ABC 123"
Str1:   .ascii  "Две капли сверкнут, сверкнут"
Str2:   .asciz  "на дне!"

B1:     .byte   255
B2:     .byte   240
Bm1:    .byte   -1
Bp1:    .byte   +1
Bmmax:  .byte   -128
Bpmax:  .byte   +127
BBB:    .byte   15,16,31,32,63,64
S1:     .short  255
S2:     .short  240
Smax:   .short  65535
S3:     .short  -32768
S4:     .short  +32767
SSS:    .short  15,16,31,32,63,64
L1:     .long   4294967295
Il:     .int    4294967295
I1:     .int    -2147483648
I2:     .int    +2147483647
Q:      .quad   -2147483648

        .text # секция команд процесора

.global _start # точка входа - глобальная метка

_start:         movw    S1, %ax
                addw    S2, %ax
                xor     %eax,%eax
                movb    B1, %al
                addb    B2, %al
                jc      UnsignedOverflow
                nop
                nop

UnsignedOverflow:
                xor     %eax,%eax
                movw    Smax,%ax
                addw    $1,%ax
                jc      UnSiOver
                nop
                nop
UnSiOver:
                xor     %eax,%eax
                movw    S4, %ax
                addw    $1, %ax
                jo      SignedOverflow
                nop
                nop
SignedOverflow:
                xor     %eax, %eax
                movw    S3, %ax
                subw    $1, %ax
                jo      UnSignOver
                nop
                nop
UnSignOver:

                Finish # конец работы, возврат в ОС (макро из файла my-macro)
                .end   # последняя строка исходного текста

