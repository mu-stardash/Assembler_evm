# цель по умолчанию (при вызове make или make task1)
# собираем программу task1 из объектного файла task1.o
task1: task1.o
	gcc -g -O0 -o task1 task1.o

task1.o: task1.c
	gcc -g -O0 -c task1.c

# цель clean (при вызове make clean)
# удаляем программу и объектные файлы
clean:
	rm task1 *.o
indent:
	indent -kr -nut -ts4 task1.c
