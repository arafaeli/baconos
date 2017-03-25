# Bootloader Makefile

PROJECT=baconos
IMG=${PROJECT}.img

NASM=nasm
GCC=gcc
QEMU64=qemu-system-x86_64

ASM_files=bootloader.asm

all: ${IMG}

${IMG}: ${ASM_files}
	${NASM} -f bin -o ${IMG} ${ASM_files}

run: all
	${QEMU64} -hda ${IMG}

debug:
	${QEMU64} -hda ${IMG} -s -S

gdb:
	gdb -ex 'target remote localhost:1234' \
			-ex 'set architecture i8086' \
			-ex 'break *0x7c00' \
			-ex 'continue'

clean:
	rm -rf *.bin *.img *.o
