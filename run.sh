#!/usr/bin/zsh

rm -R bin
mkdir bin
nasm -f bin ./Sector1/boot.asm -o ./bin/boot.bin
nasm -f elf64 ./Sector2+/extendedProg.asm -o ./bin/extendedProg.o
x86_64-elf-gcc -Ttext 0x8000 -ffreestanding -mno-red-zone -m64 -c "./Kernel/kernel.cpp" -o "./bin/kernel.o"
x86_64-elf-ld -T"link.ld"
cd ./bin
cat boot.bin kernel.bin >> boot.bin
qemu-system-x86_64 -fda boot.bin