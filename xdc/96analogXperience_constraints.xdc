
# ----------------------------------------------------------------------------
# Low-speed expansion connector
# ----------------------------------------------------------------------------
# Bank 65
set_property -dict {PACKAGE_PIN A6 IOSTANDARD LVCMOS18} [get_ports dac_sdo]
set_property -dict {PACKAGE_PIN A7 IOSTANDARD LVCMOS18} [get_ports dac_sck]
#set_property -dict {PACKAGE_PIN G6 IOSTANDARD LVCMOS33} [get_ports dac_ldac];
set_property -dict {PACKAGE_PIN C7 IOSTANDARD LVCMOS18} [get_ports dac_cs]

# Set the bank voltage for IO Bank 65 to 3.3V
#set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 65]];
