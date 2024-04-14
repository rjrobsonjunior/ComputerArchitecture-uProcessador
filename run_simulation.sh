# Compile vhd files
ghdl -a ULA.vhd
ghdl -a ULA_tb.vhd

# Develop the design
ghdl -e ULA
ghdl -e ULA_tb
# Run the simULAtion and generate the wave file
ghdl ULA_tb -r --wave=ULA_tb.ghw 

# Open the wave file using GtkWave
gtkwave ULA_tb.ghw


