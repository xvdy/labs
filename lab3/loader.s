%include "boot.inc"

SECTION loader vstart=LOADER_BASE_ADDR

loader_entry:
  jmp loader_start

setup_protection_mode_message:
  db "hello loader ... "

setup_protection_mode_message_length equ $ - setup_protection_mode_message

setup_protection_mode_message_length equ $ - setup_protection_mode_message
;*************************** 16-bits real mode ********************************;
loader_start:
  call clear_screen

  mov ax, setup_protection_mode_message
  mov dx, 0x00
  mov cx, setup_protection_mode_message_length
  call print_message_real_mode

  jmp $

clear_screen:
  mov byte ah, 0x06
  mov byte al, 0x00
  mov byte bh, 0x07
  ; start (0, 0)
  mov byte cl, 0x00
  mov byte ch, 0x00
  ; end: (dl, dh) = (x:79, y:24)
  mov byte dl, 0x4f
  mov byte dh, 0x18

  int 0x10
  ret

; args:
;  - ax message
;  - cx length
;  - dx position
print_message_real_mode:
  mov bp, ax
  mov ah, 0x13  ; int num
  mov al, 0x01
  mov bh, 0x00  ; page number
  mov bl, 0x07
  int 0x10
  ret
