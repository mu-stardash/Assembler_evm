/* Функция call-as.c считывает число из стандартного ввода, если больше 2^15 - 1, то считывает еще одно, его же и возвращает 

    Компиляция и редактирование связей:
    as --32 -gstabs+ -o func-for-c.o func-for-c.S
    gcc -m32 -gstabs+ -o c-as call-as.c func-for-c.o
    вызывающая программа на C в файле call-as.c
    функции на ассемблере в файле main.S
	
    Copyright (c) 2020, Dasha Efimova <dashulya0301178@gmail.com>
*/

#include <stdio.h>
#include <stdlib.h>

short readSym() {

    long long num = 0; // переменная для вводимого числа
    char c;              // переменная для символа

    /* Если конец ввода, то */
    if ( (c = getchar() ) == EOF)
	exit(0); // то выходим

    /* Иначе, если введен знак минус */
    else {
	if(c == '-') {
		/* то пока не был нажат Enter */
	    while(c != '\n'){
		c = getchar(); //получаем символы
		/* Если символ является цифрой */
		if(c >= '0' && c <= '9')
		    num = num * 10 - c + '0'; // то получаем отрицательное число
		/* Иначе, если был нажат Enter */
		else {
		    if(c == '\n')
			break; // выходим из цикла
			
			/* Иначе был введен неправильный символ */
		    else {
			/* Выводим соответствующее сообщение и переходим на ввод нового числа */	
			printf("You entered a character incorrectly, enter again:\n");
			while (c != '\n')
			c = getchar();
			return 0;
		    }
		}
	    }
	}

	/* Если было введено положительное число */
	else {
		/* Если символ является цифрой */
	    if (c >= '0' && c <= '9') 
		num = c - '0'; // то получаем его код
		/* Иначе, если нажали Enter */
	    else {
		if(c == '\n')
		/* то введенное число = 0 */	
		num = 0;

		/* Иначе был введен неправиьный символ, выводим сообщение и переходим на ввод нового числа */
		else {
		    printf("You entered a character incorrectly, enter again:\n");
		    while(c != '\n')
		    c = getchar();
		    return 0;
		}
	    }

		/* Пока не был введен Enter */
	    while(c != '\n'){
		c = getchar(); // получаем символ
		/* Если символ является цифрой */
		if (c >= '0' && c <= '9')
		    num = num * 10 + c - '0'; // то получаем положительное число
		
		/* Иначе, если нажали Enter */
		else {
		    if (c == '\n')
			break; // выходим из цикла

			/* Иначе был введен неправиьный символ, выводим сообщение и переходим на ввод нового числа */
		    else {
			printf("You entered a character incorrectly, enter again:\n");
			return 0;
		    }
		}
	  }
	}
	
	/* Если было введено слишком большое число для short, то выводим соотв. сообщение */
	if(num >= 32768 || num <= -32769){
	    printf("The number is too large, please enter a new one:\n");
	    return 0;
    } 
	else return num; // иначе возвращаем число
  }
}
