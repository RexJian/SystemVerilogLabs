if [file exists "work"] {vdel -all}

vlib work

vlog *.sv *v

set SEED 1

vsim -voptargs=+acc -sv_seed $SEED work.router_test_top

add wave -position insertpoint sim:/router_test_top/dut/*

run -all
