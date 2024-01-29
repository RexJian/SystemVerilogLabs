`timescale 1ns/100ps
`include "Packet.sv"
program automatic test(router_io.TB rtr_io);
  bit[3:0] sa;
  bit[3:0] da;
  logic[7:0] payload[$];
  logic[7:0] pkt2cmp_payload[$];
  int run_for_n_packets;
  int SEED = 2;
  integer repeat_times = 1;
  Packet pkt2send = new();
  Packet pkt2cmp = new();
  initial begin
    reset();
    run_for_n_packets = 2000;
    repeat(run_for_n_packets) begin
      $display("repeat time is %0d",repeat_times);
      repeat_times = repeat_times + 1;
      gen();
      fork
        send();
	  recv();
      join
       check();
    end
    repeat(10) @(rtr_io.cb);
  end
  
  task reset();
    rtr_io.reset_n = 1'b0;
    rtr_io.cb.frame_n <= '1;
    rtr_io.cb.valid_n <= '1;
    #2 rtr_io.cb.reset_n <= 1'b1;
    repeat(15) @(rtr_io.cb);
  endtask: reset
  
  task gen();
	static int pkts_generated = 0;
	pkt2send.name = $sformatf("Packet[%0d]",pkts_generated++);
	if(!pkt2send.randomize()) begin
		$display("\n %m\n [ERROR]%t: Randomize Error!!", $realtime);
		$finish;
	end
	sa = pkt2send.sa;
	da = pkt2send.da;
	$display("this package from sa = %0d, and da = %0d",sa,da);
	payload = pkt2send.payload;
  endtask: gen
  
  task send();
    send_addrs();
    send_pad();
    send_payload();
  endtask: send
  
  task send_addrs();
    rtr_io.cb.frame_n[sa] <= 1'b0;
    for(int i = 0 ; i < 4 ; i++)begin
      rtr_io.cb.din[sa] <= da[i];
      repeat(1) @(rtr_io.cb);
    end
  endtask: send_addrs

  task send_pad();
    rtr_io.cb.frame_n[sa] <= 1'b0;
    rtr_io.cb.valid_n[sa] <= 1'b1;
    rtr_io.cb.din[sa] <= 1'b1;
    repeat(5) @(rtr_io.cb);
  endtask: send_pad

  task send_payload();
    foreach(payload[index])begin
      for(int i = 0 ; i < 8 ; i++)begin
        rtr_io.cb.din[sa] <= payload[index][i];
        rtr_io.cb.valid_n[sa] <= 1'b0;
        rtr_io.cb.frame_n[sa] <= (index == (payload.size()-1)) &&(i == 7);
	repeat(1) @(rtr_io.cb);
      end
    end
    rtr_io.cb.valid_n[sa] <= 1'b1;
  endtask: send_payload
  
  task recv();
	static int pkt_cnt = 0;
	get_payload();
	pkt2cmp.payload = pkt2cmp_payload;
    	pkt2cmp.name = $sformatf("rcvdPkt[%0d]",pkt_cnt++);
  endtask: recv

  task get_payload();
	pkt2cmp_payload.delete();
	//fork begin:wd_timer_fork
		fork: frameo_wd_timer
			@(negedge rtr_io.cb.frameo_n[da]);
			begin
				repeat(1000) @(rtr_io.cb);
				$display("\n%m\n[ERROR]%t Frame signal time out\n",$realtime);
				$finish;
			end
		join_any : frameo_wd_timer
		disable fork;
    	//end : wd_timer_fork
    	//join
	forever begin
		logic[7:0] recv_data;
		for(int i = 0; i<8 ; i=i) begin
			if(rtr_io.cb.valido_n[da] == 1'b0)begin
				recv_data[i++] = rtr_io.cb.dout[da];
				if(rtr_io.cb.frameo_n[da] == 1'b1)begin
					if(i==8)begin
						pkt2cmp_payload.push_back(recv_data);
						return;
					end
					else begin
						$display("\n%m\n[ERROR]%t Packet payload not byte aligned!\n",$realtime);
						$finish;
					end
				end
			end
			@(rtr_io.cb);
		end
		pkt2cmp_payload.push_back(recv_data);	
	end
  endtask: get_payload

  task check();
	string message;
	static int pkts_checked = 0;
	if(pkt2send.compare(pkt2cmp, message) == 1'b0) begin
		$display("\n%m\n[ERROR]%t Packet #%0d %s\n", $realtime, pkts_checked, message);
		pkt2send.display();
		pkt2cmp.display();
		$finish;
	end
	$display("[NOTE]%t Packet #%0d %s",$realtime, pkts_checked++, message);
  endtask: check

endprogram: test
