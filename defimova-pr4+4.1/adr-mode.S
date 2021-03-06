
/*

    Демонстрация режимов адресации.

*/
    .include "my-macro"	# подключение файла с макроопределениями
    
.data # секция данных, распределение памяти

B1:	.byte	0
B2:	.byte	10
BBB:	.byte	15,16,31,32,63,64

S1:	.short	0
S2:	.short	20
SSS:	.short	15,16,31,32,63,64

I1:	.long	30

# 	Двумерный массив 3 x 3

Smatrix:

	.short 11,12,13
	.short 21,22,23
	.short 31,32,33

	.text # секция команд процесора

.global _start # точка входа - глобальная метка

_start:

		nop
		
#	Непосредственная (Immediate) адресация 

	 	movb	$15, %al
		movb	$15, B1
		movw	$14, %ax
		movl	$5, %eax

#	Прямая адресация, Исп. адрес = Смещение

	 	movb	B2, %al
		movw	$15,S1
		movw	S2, %ax
		movl	I1, %eax

#	Базовая адресация, Исп. адрес = значение в базовом регистре
#
#	EBX - базовый регистр

		movl	$SSS,%ebx	# адрес массива в ebx
		movw	(%ebx), %ax	# 1-ый элемент в рег.
		addl	$2,%ebx		# наращиваем адрес на 2
		movw	(%ebx), %ax 	# 2-ой элемент в рег
		addl	$2,%ebx		# и т.д.
		movw	(%ebx), %ax 

#	Базовая адресация со смещением,
#	Исп. адрес = значение в базовом регистре + смещение 
#
#	EBX - базовый регистр

		subl	%ebx,%ebx	# база = 0 - на 1-ый элемент 
		movw	SSS(%ebx), %ax	# 1-ый элемент в рег.
		addl	$2,%ebx		# наращиваем адрес на 2
		movw	SSS(%ebx), %ax 	# 2-ой элемент в рег
		addl	$2,%ebx		# и т.д.
		movw	SSS(%ebx), %ax 

#	Индексная адресация со смещением,
#	Исп. адрес = значение в индексном регистре*масш. множ. + смещение 
#
#	EBX - индексный регистр

		subl	%ebx,%ebx	  # индекс = 0 - на 1-ый элемент 
		movw	SSS(,%ebx,2), %ax # 1-ый элемент в рег.
					  # база опущена, масш. множ.=2
		incl	%ebx		  # наращиваем индекс на 1
		movw	SSS(,%ebx,2), %ax # 2-ой элемент в рег
		incl	%ebx		  # и т.д.
		movw	SSS(,%ebx,2), %ax 

#	Базово индексная адресация со смещением,
#	Исп. адрес = значение в базовом регистре +
#            значение в индексном регистре*масш. множ. + смещение 
#
#	EDX - базовый регистр - указатель строк матрицы Smatrix - i
#	EBX - индексный регистр - указатель столбцов матрицы - j
	

#		Установка начального значения цикла по строкам:

		mov	$Smatrix,%edx     # i = 0

Next_String:
#		Установка начального значения цикла по столбцам

		subl	%ebx,%ebx	  # j = 0		
		
#	Внимание! i и j управляются разными способами!

#	  Для перехода к следующей строке к i нужно прибавить
#	  длину строки матрицы в байтах - в нашем случае - 6
		  
#	  Для перехода к следующему столбцу к j нужно прибавить 1
		  
#	Последовательная передача элементов матрицы в рег. ax

Next_Row:		

		leal	(%edx,%ebx,2), %ecx # демонстрация 
#                                             исполнительного адреса

#	команда leal вычисляет Исп. адрес и посылает его в регистр 2 операнда
#	команда пристутствует только для учебных целей

		movw	(%edx,%ebx,2), %ax  # элемент ij в рег.
		
		incl	%ebx		  # j++ 
		cmpl	$3,%ebx		  # столбцы закончились?
		jne	Next_Row          # НЕТ - идем дальше
		
		addl	$6, %edx	  # ДА, i++ (но по 6 байтов !)
		cmpl	$Smatrix+18, %edx # строки закончились?
		jne	Next_String       # НЕТ - идем дальше
					  # ДА - на след. команду
					  
		Finish # конец работы, возврат в ОС (макро из файла my-macro)
		.end   # последняя строка исходного текста	
