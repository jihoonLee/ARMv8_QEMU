CROSS_COMPILE = aarch64-none-elf-

CC = $(CROSS_COMPILE)gcc
LD = $(CROSS_COMPILE)ld
OBJCOPY = $(CROSS_COMPILE)objcopy

ROOT_DIR:=$(PWD)
CFILE_DIR=$(ROOT_DIR)/cfile
ASM_DIR=$(ROOT_DIR)/asmfile
OBJ_DIR=$(ROOT_DIR)/object
LIB_DIR=$(ROOT_DIR)/header
OUT_DIR=$(ROOT_DIR)/output

IMAGE=kernel.img
ELF=kernel.elf

OBJS=$(OBJ_DIR)/crt0.o 

CFLAGS = -Wall -O2 -ffreestanding -nostdinc -nostdlib -nostartfiles


all: clean $(IMAGE)


$(IMAGE): crt0.o
	$(LD) -nostdlib -nostartfiles $(OBJS) -T $(ASM_DIR)/kernel.ld -o $(OUT_DIR)/$(ELF)
	$(OBJCOPY) -O binary $(OUT_DIR)/$(ELF) $(OUT_DIR)/$(IMAGE)


crt0.o: $(ASM_DIR)/crt0.S 
	$(CC) $(CFLAGS) -c $(ASM_DIR)/crt0.S -o $(OBJ_DIR)/crt0.o
	
clean: 
	rm -rf $(OUT_DIR)/*
	rm -rf $(OBJ_DIR)/*

run: 
	qemu-system-aarch64 -M raspi3 -kernel $(OUT_DIR)/kernel.img -d in_asm


