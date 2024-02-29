`timescale 1ns/100ps
`include "Packet.sv"
`include "router_test.svh"
`include "Driver.sv"
`include "Receiver.sv"
`include "Generator.sv"
`include "Scoreboard.sv"
class Environment;

	string name;
	rand int run_for_n_packets;
	virtual router_io.TB rtr_io;

	semaphore sem[];
	Driver drvr[];
	Receiver rcvr[];
	Generator gen;
	Scoreboard sb;

	constraint valid{
	  this.run_for_n_packets inside{[1500:2500]};	
	}

	extern function new(string name = "Env", virtual router_io.TB rtr_io);
	extern virtual task run();
	extern virtual function void configure();
	extern virtual function void build();
	extern virtual task start();
	extern virtual task wait_for_end();
	extern virtual task reset();

endclass: Environment

function Environment::new(string name = "Env", virtual router_io.TB rtr_io);
	$display("[TRACE]%t %s:%m",$realtime, name);
	this.name = name;
	this.rtr_io = rtr_io;
endfunction: new

task Environment::run();
	$display("[TRACE]%t %s:%m",$realtime, this.name);
	this.build();
	this.reset();
	this.start();
	this.wait_for_end();
endtask: run

function void Environment::configure();
	$display("[TRACE]%t %s:%m",$realtime, this.name);
	this.randomize();
endfunction: configure

function void Environment::build();
	$display("[TRACE]%t %s:%m",$realtime, this.name);
	if(this.run_for_n_packets == 0) this.run_for_n_packets = 2000;
	this.sem = new[16];
	this.drvr = new[16];
	this.rcvr = new[16];
	this.gen = new("Generator",this.run_for_n_packets);
	this.sb = new("Scoreboard",this.run_for_n_packets);
	foreach (sem[i])
		this.sem[i] = new(1);
	for(int i=0; i<drvr.size(); i++)
		this.drvr[i] = new($psprintf("drvr[%0d]",i), i, this.sem, this.gen.out_box[i], this.sb.driver_mbox, this.rtr_io);
	for(int i=0; i<rcvr.size(); i++)
		this.rcvr[i] = new($psprintf("rcvr[%0d]",i), i, this.sb.receiver_mbox, this.rtr_io);	
endfunction: build

task Environment::reset();
	$display("[TRACE]%t %s:%m",$realtime, this.name);
	this.rtr_io.reset_n <= 1'b0;
	this.rtr_io.cb.frame_n <= '1;
	this.rtr_io.cb.valid_n <= '1;
	#2 this.rtr_io.cb.reset_n <= 1'b1;
	repeat(15) @(this.rtr_io.cb);
endtask: reset

task Environment:: start();
	$display("[TRACE]%t %s:%m",$realtime, this.name);
	this.gen.start();
	this.sb.start();
	foreach(this.drvr[i])
		this.drvr[i].start();
	foreach(this.rcvr[i])
		this.rcvr[i].start();
endtask: start

task Environment::wait_for_end();
	$display("[TRACE]%t %s:%m",$realtime, this.name);
	wait(this.sb.DONE.triggered);
endtask:wait_for_end
