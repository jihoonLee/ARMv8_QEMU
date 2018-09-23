CROSS_COMPILE = aarch64-none-elf-

CC = $(CROSS_COMPILE)gcc
LD = $(CROSS_COMPILE)ld
OBJDUMP = $(CROSS_COMPILE)objdump

ROOT_DIR:=$(PWD)
CFILE_DIR=$(ROOT_DIR)/cfile
ASM_DIR=$(ROOT_DIR)/asmfile
OBJ_DIR=$(ROOT_DIR)/object
LIB_DIR=$(ROOT_DIR)/header
OUT_DIR=$(ROOT_DIR)/output
IMAGE=kernel.elf
OBJS=$(OBJ_DIR)/crt0.o $(OBJ_DIR)/main.o

CFLAGS = -Wall -fno-common -O0 -g \
         -nostdlib -nostartfiles -ffreestanding \
         -march=armv8-a

all: $(IMAGE)

$(IMAGE): crt0.o main.o 
	$(LD) $(OBJS) -T $(ASM_DIR)/kernel.ld -o $(OUT_DIR)/$(IMAGE)
	$(OBJDUMP) -d $(OUT_DIR)/kernel.elf > $(OUT_DIR)/kernel.list
	$(OBJDUMP) -t $(OUT_DIR)/kernel.elf | sed '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > $(OUT_DIR)/kernel.sym

crt0.o: $(ASM_DIR)/crt0.S 
	$(CC) $(ASM_DIR)/crt0.S -c -I$(LIB_DIR) -o $(OBJ_DIR)/crt0.o

main.o: $(CFILE_DIR)/main.c
	$(CC) $(CFILE_DIR)/main.c -c -I$(LIB_DIR) -o $(OBJ_DIR)/main.o


qemu: $(IMAGE)
	@qemu-system-aarch64 -M ? | grep virt >/dev/null || exit
	@echo "Press Ctrl-A and then X to exit QEMU"
	@echo
	qemu-system-aarch64 -machine virt -cpu cortex-a57 \
	                    -smp 4 -m 4096 \
			    -nographic -serial mon:stdio \
	                    -kernel $(OUT_DIR)/$(IMAGE)

clean:
	rm -f $(IMAGE) *.o *.list *.sym

.PHONY: all qemu clean
