# Compile vhd files
ghdl -a ULA.vhd

# Develop the design
ghdl -e ULA

# Run the simULAtion and generate the wave file
ghdl -r --wave=ULA.ghw ULA

# Open the wave file using GtkWave
gtkwave ULA.ghw


