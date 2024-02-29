`ifndef INC_RECEIVER_SV
`define INC_RECEIVER_SV
`include "router_test.svh"
`include "ReceiverBase.sv"
class Receiver extends ReceiverBase;
	pkt_mbox out_box;
	
	extern function new(string name = "Receiver", int port_id, pkt_mbox out_box, virtual router_io.TB rtr_io);
	extern virtual task start();
endclass: Receiver

function Receiver::new(string name, int port_id, pkt_mbox out_box, virtual router_io.TB rtr_io);
	super.new(name,rtr_io);
	
	//$display("[TRACE]%t %s:%m",$realtime, name);
	this.da = port_id;
	this.out_box = out_box; 
endfunction

task Receiver::start();
	
	//$display("[TRACE]%t %s:%m",$realtime, this.name);
	fork
		forever begin
			this.recv();
			begin
				Packet pkt = new pkt2cmp;
				this.out_box.put(pkt);
			end
		end		
	join_none
endtask
`endif
