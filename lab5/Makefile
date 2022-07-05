clean:
	rm -f mbr
	rm -f loader
	rm -f kernel
	rm -f scroll.img

build: clean
	nasm -o mbr mbr.s
	nasm -o loader loader.s
	gcc -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -no-pie -fno-pic -c main.c -o main.o
	ld -m elf_i386 -Tlink.ld -o kernel main.o
	qemu-img create scroll.img 3m
	dd if=mbr of=scroll.img bs=512 count=1 seek=0 conv=notrunc
	dd if=loader of=scroll.img bs=512 count=8 seek=1 conv=notrunc
	dd if=kernel of=scroll.img bs=512 count=2048 seek=9 conv=notrunc
run: build
	qemu-system-i386 -hda scroll.img
bochsrun: build
	bochs -f bochsrc.txt -q
