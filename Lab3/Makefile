RTL= ./router.v
SVTB = ./router_test_top.sv ./router_io.cv ./test.sv
SEED = 1

default: test

test: compile simulate

simulate:
	vsim -voptargs=+acc -sv_seed $(SEED) work.router_test_top
compile:
	vlog *.sv *.v

