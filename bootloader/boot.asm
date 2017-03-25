org 0x7C00

jmp main
welcome_msg db "Welcome to baconOS "

main:

enable_a20:
  in al, 0x92
  test al, 2
  jnz after_a20
  or al, 2
  and al, 0xFE
  out 0x92, al
after_a20:


; Fill img
times 0x0200 - 2 - ($ - $$)  db 0
dw 0xAA55
