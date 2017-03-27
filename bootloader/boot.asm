org 0x7C00
bits 16

; Data
jmp main
welcome_msg db "Welcome to baconOS "

%include "gdt.asm"

; Code (16-bit)
main:

enable_a20:
  in al, 0x92
  test al, 2
  jnz after_a20
  or al, 2
  and al, 0xFE
  out 0x92, al
after_a20:

; Disable ints
cli
load_gdt:
  lgdt [gdt_descriptor]

init_pmode:
  mov eax, cr0
  or eax, 0x1
  mov cr0, eax
  jmp long CODE_SEG:main32

bits 32

main32:

init_segs:
  mov ax, DATA_SEG
  mov ds, ax
  mov ss, ax
  mov es, ax
  mov fs, ax
  mov gs, ax


init_stack:
  mov ebp, 0x90000
  mov esp, ebp

; Enable ints
sti
kernel:
  push 0xdeadbeef
 
done:
  jmp done


; Fill img
times 0x0200 - 2 - ($ - $$)  db 0
dw 0xAA55
