.psp


PSP_O_RDONLY    equ         0x00000001
PSP_O_WRONLY    equ         0x00000002
PSP_O_RDWR      equ         0x00000003
PSP_O_NBLOCK    equ         0x00000010
PSP_O_APPEND    equ         0x00000100
PSP_O_CREAT     equ         0x00000200
PSP_O_TRUNC     equ         0x00000400
PSP_O_EXCL      equ         0x00000800
PSP_O_NOWAIT    equ         0x00008000
PSP_O_NPDRM     equ         0x40000000

sceIoWrite      equ         0x08965690
sceIoRead       equ         0x089656A0
sceIoRename     equ         0x089656A8
sceIoClose      equ         0x089656B0
sceIoGetStat    equ         0x089656B8
sceIoOpen       equ         0x089656D0
sceIoSeek       equ         0x089656D8


.relativeinclude on

.openfile "../base_files/eboot.bin", "../bin/eboot.bin", 0x880134C

.org            0x08821818

j               preload

.org            0x089DFE60

.include        "preload.asm"

.close

.create         "../bin/mlhooks", 0x08800500

.word           0x0886365C; read hook
.word           0x4

j               read

.word           0x08865420; cryptoskip
.word           0x4
.resetdelay

j               cryptoskip

.word           0x08865518; skip size check
.word           0x4

nop

.word           0x088655c0; seek hook
.word           0x4

jal             seek


.close

.create         "../bin/ml", 0x08800500

.include        "modelloader.asm"

.close