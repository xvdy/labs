clean:
	rm -f mbr
	rm -f loader
	rm -f scroll.img

build: clean
	nasm -o mbr mbr.s
	nasm -o loader loader.s

	qemu-img create scroll.img 3m
	dd if=mbr of=scroll.img bs=512 count=1 seek=0 conv=notrunc
	dd if=loader of=scroll.img bs=512 count=8 seek=1 conv=notrunc

run: build
	qemu-system-i386 -hda scroll.img
bochsrun:
	bochs -f bochsrc.txt -q
