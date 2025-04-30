FILES = ./build/kernel.asm.o ./build/kernel.o
FLAGS = -g -ffreestanding -nostdlib -nostartfiles -nodefaultlibs -Wall -O0 -Iinc -m32 -fno-pie

all:
	nasm -f bin ./src/boot.asm -o ./bin/boot.bin
	# nasm -f elf -g ./src/kernel.asm -o ./build/kernel.asm.o
	gcc $(FLAGS) -std=gnu99 -c ./src/kernel.c -o ./build/kernel.o
	ld -m elf_i386 -T ./src/linkerScript.ld build/kernel.o -o ./bin/kernel.bin
	# i686-elf-ld -g -relocatable $(FILES) -o ./build/completeKernel.o
	# i686-elf-gcc $(FLAGS) -T ./src/linkerScript.ld -o ./bin/kernel.bin -ffreestanding -O0 -nostdlib ./build/completeKernel.o

	dd if=./bin/boot.bin >> ./bin/os.img
	dd if=./bin/kernel.bin >> ./bin/os.img
	dd if=/dev/zero bs=512 count=8 >> ./bin/os.img
	

clean:
	rm -f ./bin/boot.bin
	rm -f ./bin/kernel.bin
	rm -f ./bin/os.bin
	rm -f ./build/kernel.asm.o
	rm -f ./build/kernel.o
	rm -f ./build/completeKernel.o