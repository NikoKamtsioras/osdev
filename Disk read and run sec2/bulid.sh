#!/bin/bash

# Assemble boot sector
nasm -f bin bs.asm -o boot.bin

# Assemble all sector files (s2.asm, s3.asm, ...)
for sector in s*.asm; do
    # Convert s2.asm -> s2.bin etc.
    out="${sector%.asm}.bin"
    echo "Assembling $sector -> $out"
    nasm -f bin "$sector" -o "$out"
done

# Create empty sector filler (if needed)
empty_sector="empty_sector.bin"
dd if=/dev/zero of="$empty_sector" bs=1024 count=1 status=none

# Concatenate boot sector + all sectors + optional empty filler
cat boot.bin s*.bin "$empty_sector" > full_image.bin

echo "Build complete: full_image.bin"

