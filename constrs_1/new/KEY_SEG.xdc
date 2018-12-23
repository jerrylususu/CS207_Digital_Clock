set_property IOSTANDARD LVCMOS33 [get_ports {col[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {col[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {col[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {col[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {row[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {row[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {row[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {row[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_an[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_an[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_an[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_an[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_an[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_an[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_an[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg_an[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports rst]

set_property PACKAGE_PIN M2 [get_ports {col[3]}]
set_property PACKAGE_PIN K6 [get_ports {col[2]}]
set_property PACKAGE_PIN J6 [get_ports {col[1]}]
set_property PACKAGE_PIN L5 [get_ports {col[0]}]

set_property PACKAGE_PIN K4 [get_ports {row[3]}]
set_property PACKAGE_PIN J4 [get_ports {row[2]}]
set_property PACKAGE_PIN L3 [get_ports {row[1]}]
set_property PACKAGE_PIN K3 [get_ports {row[0]}]

set_property PACKAGE_PIN C19 [get_ports {seg_an[0]}]
set_property PACKAGE_PIN E19 [get_ports {seg_an[1]}]
set_property PACKAGE_PIN D19 [get_ports {seg_an[2]}]
set_property PACKAGE_PIN F18 [get_ports {seg_an[3]}]
set_property PACKAGE_PIN E18 [get_ports {seg_an[4]}]
set_property PACKAGE_PIN B20 [get_ports {seg_an[5]}]
set_property PACKAGE_PIN A20 [get_ports {seg_an[6]}]
set_property PACKAGE_PIN A18 [get_ports {seg_an[7]}]

#set_property PACKAGE_PIN E13 [get_ports {seg_out[0]}]
#set_property PACKAGE_PIN C15 [get_ports {seg_out[1]}]
#set_property PACKAGE_PIN C14 [get_ports {seg_out[2]}]
#set_property PACKAGE_PIN E17 [get_ports {seg_out[3]}]

#set_property PACKAGE_PIN F16 [get_ports {seg_out[4]}]
#set_property PACKAGE_PIN F14 [get_ports {seg_out[5]}]
#set_property PACKAGE_PIN F13 [get_ports {seg_out[6]}]
#set_property PACKAGE_PIN F15 [get_ports {seg_out[7]}]








set_property PACKAGE_PIN Y18 [get_ports clk]
set_property PACKAGE_PIN R4 [get_ports rst]





#set_property MARK_DEBUG true [get_nets {row_IBUF[0]}]
#set_property MARK_DEBUG true [get_nets {row_IBUF[1]}]
#set_property MARK_DEBUG true [get_nets {row_IBUF[2]}]
#set_property MARK_DEBUG true [get_nets {row_IBUF[3]}]
#set_property MARK_DEBUG true [get_nets {seg_out_OBUF[0]}]
#set_property MARK_DEBUG true [get_nets {seg_out_OBUF[1]}]
#set_property MARK_DEBUG true [get_nets {seg_out_OBUF[2]}]
#set_property MARK_DEBUG true [get_nets {seg_out_OBUF[3]}]
#set_property MARK_DEBUG true [get_nets {seg_out_OBUF[4]}]
#set_property MARK_DEBUG true [get_nets {seg_out_OBUF[5]}]
#set_property MARK_DEBUG true [get_nets {seg_out_OBUF[6]}]
#set_property MARK_DEBUG false [get_nets <const1>]
#set_property MARK_DEBUG true [get_nets {col_OBUF[3]}]
#set_property MARK_DEBUG true [get_nets {col_OBUF[2]}]
#set_property MARK_DEBUG true [get_nets {col_OBUF[0]}]
#set_property MARK_DEBUG true [get_nets {col_OBUF[1]}]
#create_debug_core u_ila_0 ila
#set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
#set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
#set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
#set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
#set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
#set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
#set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
#set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
#set_property port_width 1 [get_debug_ports u_ila_0/clk]
#connect_debug_port u_ila_0/clk [get_nets [list clk_IBUF_BUFG]]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
#set_property port_width 4 [get_debug_ports u_ila_0/probe0]
#connect_debug_port u_ila_0/probe0 [get_nets [list {col_OBUF[0]} {col_OBUF[1]} {col_OBUF[2]} {col_OBUF[3]}]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
#set_property port_width 4 [get_debug_ports u_ila_0/probe1]
#connect_debug_port u_ila_0/probe1 [get_nets [list {row_IBUF[0]} {row_IBUF[1]} {row_IBUF[2]} {row_IBUF[3]}]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
#set_property port_width 7 [get_debug_ports u_ila_0/probe2]
#connect_debug_port u_ila_0/probe2 [get_nets [list {seg_out_OBUF[0]} {seg_out_OBUF[1]} {seg_out_OBUF[2]} {seg_out_OBUF[3]} {seg_out_OBUF[4]} {seg_out_OBUF[5]} {seg_out_OBUF[6]}]]
#set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
#set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
#set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
#connect_debug_port dbg_hub/clk [get_nets clk_IBUF_BUFG]





