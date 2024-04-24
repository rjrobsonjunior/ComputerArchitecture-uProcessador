# -a Compile vhd files 
# -e Develop the design

ghdl -a ULA.vhd
ghdl -e ULA
#ghdl -a ULA_tb.vhd
#ghdl -e ULA_tb

ghdl -a reg16bits.vhd
ghdl -e reg16bits.vhd
#ghdl -a reg16bits_tb.vhd
#ghdl -e reg16bits_tb.vhd

ghdl -a MUX4_16.vhd
ghdl -e MUX4_16

ghdl -a RegisterBank.vhd
ghdl -e RegisterBank
# Run the simULAtion and generate the wave file
#ghdl -r ULA_tb --wave=ULA_tb.ghw 

# Open the wave file using GtkWave
#gtkwave ULA_tb.ghw


