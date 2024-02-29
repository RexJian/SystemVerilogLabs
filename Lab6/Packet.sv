`ifndef INC_PACKET_SV
`define INC_PACKET_SV
class Packet;
	rand bit[3:0] sa,da;
	rand logic[7:0] payload[$];
	string name;
	constraint valid{
		sa inside {[0:15]};
		da inside {[0:15]};
		payload.size() inside{[2:8]};	
	}
	extern function new(string name = "Packet");
	extern function bit compare(Packet pkt2cmp, ref string message);
	extern function void display(string prefix = "NOTE");
endclass: Packet


function Packet::new(string name);
	this.name = name;
endfunction: new

function bit Packet::compare(Packet pkt2cmp, ref string message);
	if(payload.size() != pkt2cmp.payload.size()) begin
		message = "Payload size Mismatch\n";
		message = {message, $sformatf("payload.size() = %0d, pkt2cmp.payload.size() = %0d\n", payload.size(), pkt2cmp.payload.size())};
		return (0);
	end
	else if(payload == pkt2cmp.payload) begin
		message = "Successfully Compared";
		return (1);
	end
	else begin
		message = "Payload Content Mismatch\n";
		message = {message, $sformatf("Packet Sent: %p\n Pkt Received: %p",payload, pkt2cmp.payload)};
		return (0);
	end
endfunction: compare

function void Packet::display(string prefix);
	$display("[%s]%t %s sa = %0d, da = %0d",prefix, $realtime, name, sa, da);
	foreach(payload[i])
		$display("[%s]%t %s payload[%0d] = %0d",prefix, $realtime, name, i, payload[i]);
endfunction: display

`endif
