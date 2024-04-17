# -a Compile vhd files 
# -e Develop the design
ghdl -a ULA.vhd
ghdl -e ULA
ghdl -a ULA_tb.vhd
ghdl -e ULA_tb

# Run the simULAtion and generate the wave file
ghdl ULA_tb -r --wave=ULA_tb.ghw 

# Open the wave file using GtkWave
#gtkwave ULA_tb.ghw


