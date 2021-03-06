
.include "my-macro"	# подключение файла с макроопределениями

.text # секция команд процесcора 
        
.global _start 	# точка входа - глобальная метка
_start:	
        movl $5, %eax 		#помещаем число 5 в регистр eax, факториал которого будем считать
	movl $1, %ebx 		#помещаем число 1 в регистр ebx, для работы с умножением

L1: 	
        cmpl  $0, %eax 		#Условие: сравниваем  eax с 0
	je    L2   		#Если равно 0, то переходим к метке L2 ( к завершению программы)
	imull %eax, %ebx	#Если НЕТ, то выполняем знаковое умножение
	decl  %eax   		#уменьшаем eax на 1, переходим к следующему множителю 
	jmp   L1 		#переходим к началу цикла ( к L1)
	
L2:	
        Finish             # конец работы, 
                           # возврат в ОС
                           # (макро из файла my-macro)

.end  # последняя строка исходного текста
      # as прекращает чтение файла исходного текста
        
