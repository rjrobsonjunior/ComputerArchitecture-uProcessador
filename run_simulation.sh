# Compile vhd files
ghdl -a ULA.vhd

# Develop the design
ghdl -e ULA

# Run the simULAtion and generate the wave file
ghdl ULA -r --wave=ULA.ghw 

# Open the wave file using GtkWave
gtkwave ULA.ghw


