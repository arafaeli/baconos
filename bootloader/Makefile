# Bootloader Makefile

PROJECT=baconos
IMG=${PROJECT}.img

NASM=nasm
GCC=gcc
QEMU64=qemu-system-x86_64

CFLAGS=-fno-leading-underscore -nostdlib -nostdinc -fno-builtin -fno-stack-protector

ASM_files=boot.asm
C_files=kernel.c

all: ${IMG}

gdt.asm: gdt.yaml
	python ../tools/gdt_gen.py gdt.yaml > gdt.asm

${IMG}: ${ASM_files} gdt.asm
	${NASM} -f bin -o ${IMG} ${ASM_files}

run: all
	${QEMU64} -hda ${IMG}

debug:
	${QEMU64} -hda ${IMG} -s -S

gdb:
	gdb -ex 'target remote localhost:1234' \
			-ex 'set architecture i8086' \
			-ex 'break *0x7c00' \
			-ex 'continue' \
			-ex 'layout asm'

clean:
	rm -rf *.bin *.img *.o
