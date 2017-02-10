#map clock
set_property PACKAGE_PIN W5 [get_ports clock]
set_property IOSTANDARD LVCMOS33 [get_ports clock]
#map segments
# a
set_property PACKAGE_PIN W7 [get_ports {seven[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seven[6]}]
# b
set_property PACKAGE_PIN W6 [get_ports {seven[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seven[5]}]
# c
set_property PACKAGE_PIN U8 [get_ports {seven[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seven[4]}]
# d
set_property PACKAGE_PIN V8 [get_ports {seven[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seven[3]}]
#e
set_property PACKAGE_PIN U5 [get_ports {seven[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seven[2]}]
#f
set_property PACKAGE_PIN V5 [get_ports {seven[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seven[1]}]
#g
set_property PACKAGE_PIN U7 [get_ports {seven[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seven[0]}]


# button maps
set_property PACKAGE_PIN W19 [get_ports btn_left]
set_property IOSTANDARD LVCMOS33 [get_ports btn_left]

set_property PACKAGE_PIN T17 [get_ports btn_right]
set_property IOSTANDARD LVCMOS33 [get_ports btn_right]

set_property PACKAGE_PIN U18 [get_ports btn_cntr]
set_property IOSTANDARD LVCMOS33 [get_ports btn_cntr]


# an select pins
set_property PACKAGE_PIN U2 [get_ports {an_sel[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an_sel[0]}]

set_property PACKAGE_PIN U4 [get_ports {an_sel[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an_sel[1]}]

set_property PACKAGE_PIN V4 [get_ports {an_sel[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an_sel[2]}]

set_property PACKAGE_PIN W4 [get_ports {an_sel[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an_sel[3]}]
