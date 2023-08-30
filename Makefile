.PHONY: build run

all: run

build:
	cargo objcopy --release -- -Obinary out.bin

run: build
	xfel ddr d1
	xfel write 0x40200000 out.bin
	xfel exec 0x40200000

run_f133: build
	xfel ddr f133
	xfel write 0x40200000 out.bin
	xfel exec 0x40200000
