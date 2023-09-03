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

# This could probably be simpler, but hey, it works.
ferris_1024x600:
	# render Ferris on gray background, scaled down, centered
	convert -size 1024x600 -gravity center xc:'#3d3d3d' -background none \
		src/ferris.svg -scale x600 -composite src/ferris_1024x600.png
	# convert to raw RGB data
	convert src/ferris_1024x600.png -depth 8 -colorspace RGB src/ferris.rgb
	# rename... this could be skipped with a Rust code change
	mv src/ferris.rgb src/ferris.data
