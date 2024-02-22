`timescale 1ns/100ps
`include "Packet.sv"
`include "router_test.svh"
`include "Driver.sv"
`include "Receiver.sv"
`include "Generator.sv"
`include "Scoreboard.sv"
program automatic test(router_io.TB rtr_io);

	int run_for_n_packets;
	int TRACE_ON = 1;
	
	semaphore sem[];
	Driver drvr[];
	Receiver rcvr[];
	Generator gen;
	Scoreboard sb;
	
	
	
	initial begin
		
		run_for_n_packets = 200;
		sem = new[16];
		drvr = new[16];
		rcvr = new[16];
		gen = new("gen", run_for_n_packets);
		sb = new("sb", run_for_n_packets);
		run_for_n_packets = 200;
		foreach(sem[i])
			sem[i] = new(1);
		foreach(drvr[i])
			drvr[i] = new($sformatf("drvr[%0d]",i), i, sem, gen.out_box[i], sb.driver_mbox, rtr_io);
		foreach(rcvr[i])
			rcvr[i] = new($sformatf("rcvr[%0d]",i), i, sb.receiver_mbox, rtr_io);
		reset();
		gen.start();
		sb.start();
		foreach(drvr[i])
			drvr[i].start();
		foreach(rcvr[i])
			rcvr[i].start();
		wait(sb.DONE.triggered);
	end
	task reset();
		rtr_io.reset_n = 1'b0;
		rtr_io.cb.frame_n <= '1;
		rtr_io.cb.valid_n <= '1;
		#2 rtr_io.cb.reset_n <= 1'b1;
		repeat(15) @(rtr_io.cb);
	endtask: reset
  

endprogram: test
