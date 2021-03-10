transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/UECCI/Documents/GitHub/UNAL/Digital1-2020-2/lab01/hdl/src/solucion/src {C:/Users/UECCI/Documents/GitHub/UNAL/Digital1-2020-2/lab01/hdl/src/solucion/src/sum1bcc.v}
vlog -vlog01compat -work work +incdir+C:/Users/UECCI/Documents/GitHub/UNAL/Digital1-2020-2/lab01/hdl/src/solucion/src {C:/Users/UECCI/Documents/GitHub/UNAL/Digital1-2020-2/lab01/hdl/src/solucion/src/sum4b.v}

vlog -vlog01compat -work work +incdir+C:/Users/UECCI/Documents/GitHub/UNAL/Digital1-2020-2/lab01/hdl/src/solucion/quartus/../src {C:/Users/UECCI/Documents/GitHub/UNAL/Digital1-2020-2/lab01/hdl/src/solucion/quartus/../src/sum4b_TB.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  sum4b_TB

add wave *
view structure
view signals
run -all
