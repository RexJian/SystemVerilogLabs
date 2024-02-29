`ifndef INC_GENERATOR_SV
`define INC_GENERATOR_SV
`include "Packet.sv"
`include "router_test.svh"
class Generator;
	string name;
	int run_for_n_packets;
	Packet pkt2send;
	pkt_mbox out_box[];
	
	extern function new(string name = "Generaotor",int run_for_n_packets = 200);
	extern virtual task gen();
	extern virtual task start();

endclass

function Generator::new(string name, int run_for_n_packets);
	
	//$display("[TRACE]%t:%m",$realtime, name);
	this.name = name;
	this.pkt2send = new();
	this.out_box = new[16];
	this.run_for_n_packets = run_for_n_packets;
	foreach(this.out_box[i])
		this.out_box[i] = new();

endfunction: new

task Generator::gen();
	static int pkts_generated = 0;	
	//$display("[TRACE]%t:%m",$realtime, this.name);
	this.pkt2send.name = $psprintf("Packet[%0d]", pkts_generated++);
	if(!this.pkt2send.randomize())begin
		$display("\n%m\n[ERROR]%t Randomization Failed!\n",$realtime);
		$finish;
	end
endtask: gen

task Generator::start();		
	//$display("[TRACE]%t:%m",$realtime, this.name);
	fork
		for(int i=0; i < this.run_for_n_packets || this.run_for_n_packets<=0; i++) begin
			this.gen();
			begin //This block of begin and end is used to declare pkt
				Packet pkt = new this.pkt2send;
				this.out_box[pkt.sa].put(pkt);
			end
		end
	join_none
endtask: start

`endif
