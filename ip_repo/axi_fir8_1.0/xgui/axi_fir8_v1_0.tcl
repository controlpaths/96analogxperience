# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  set C_S00_AXI_DATA_WIDTH [ipgui::add_param $IPINST -name "C_S00_AXI_DATA_WIDTH" -parent ${Page_0} -widget comboBox]
  set_property tooltip {Width of S_AXI data bus} ${C_S00_AXI_DATA_WIDTH}
  set C_S00_AXI_ADDR_WIDTH [ipgui::add_param $IPINST -name "C_S00_AXI_ADDR_WIDTH" -parent ${Page_0}]
  set_property tooltip {Width of S_AXI address bus} ${C_S00_AXI_ADDR_WIDTH}
  ipgui::add_param $IPINST -name "C_S00_AXI_BASEADDR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S00_AXI_HIGHADDR" -parent ${Page_0}

  set param_io_width [ipgui::add_param $IPINST -name "param_io_width"]
  set_property tooltip {Input/Output data width} ${param_io_width}
  set param_io_decimal [ipgui::add_param $IPINST -name "param_io_decimal"]
  set_property tooltip {WIdth of decimal part for Input/Output data.} ${param_io_decimal}
  set param_coeff_decimal [ipgui::add_param $IPINST -name "param_coeff_decimal"]
  set_property tooltip {WIdth of decimal part for Cofficients} ${param_coeff_decimal}

}

proc update_PARAM_VALUE.param_coeff_decimal { PARAM_VALUE.param_coeff_decimal } {
	# Procedure called to update param_coeff_decimal when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.param_coeff_decimal { PARAM_VALUE.param_coeff_decimal } {
	# Procedure called to validate param_coeff_decimal
	return true
}

proc update_PARAM_VALUE.param_io_decimal { PARAM_VALUE.param_io_decimal } {
	# Procedure called to update param_io_decimal when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.param_io_decimal { PARAM_VALUE.param_io_decimal } {
	# Procedure called to validate param_io_decimal
	return true
}

proc update_PARAM_VALUE.param_io_width { PARAM_VALUE.param_io_width } {
	# Procedure called to update param_io_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.param_io_width { PARAM_VALUE.param_io_width } {
	# Procedure called to validate param_io_width
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_DATA_WIDTH { PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to update C_S00_AXI_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_DATA_WIDTH { PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to validate C_S00_AXI_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_ADDR_WIDTH { PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to update C_S00_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_ADDR_WIDTH { PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to validate C_S00_AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_BASEADDR { PARAM_VALUE.C_S00_AXI_BASEADDR } {
	# Procedure called to update C_S00_AXI_BASEADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_BASEADDR { PARAM_VALUE.C_S00_AXI_BASEADDR } {
	# Procedure called to validate C_S00_AXI_BASEADDR
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_HIGHADDR { PARAM_VALUE.C_S00_AXI_HIGHADDR } {
	# Procedure called to update C_S00_AXI_HIGHADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_HIGHADDR { PARAM_VALUE.C_S00_AXI_HIGHADDR } {
	# Procedure called to validate C_S00_AXI_HIGHADDR
	return true
}


proc update_MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.param_io_width { MODELPARAM_VALUE.param_io_width PARAM_VALUE.param_io_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.param_io_width}] ${MODELPARAM_VALUE.param_io_width}
}

proc update_MODELPARAM_VALUE.param_io_decimal { MODELPARAM_VALUE.param_io_decimal PARAM_VALUE.param_io_decimal } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.param_io_decimal}] ${MODELPARAM_VALUE.param_io_decimal}
}

proc update_MODELPARAM_VALUE.param_coeff_decimal { MODELPARAM_VALUE.param_coeff_decimal PARAM_VALUE.param_coeff_decimal } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.param_coeff_decimal}] ${MODELPARAM_VALUE.param_coeff_decimal}
}

