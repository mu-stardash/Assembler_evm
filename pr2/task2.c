/**
 * task2.c - программа для вычисления факториала числа 5
 **/

#include <stdio.h>

int main(void)
{
    int eax = 5;         //число, факториал которого будем считать
    int ebx = 1;         //число для работы с умножением
    
    /* Начинаем цикл */
    while (eax > 0) {
	ebx = ebx * eax; //находим произведение 
	eax--;           //уменьшаем на 1 множитель 
    }
    printf("%d\n", ebx); //выводим реузльтат, который хранится в ebx
}
