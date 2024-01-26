`timescale 1ns/100ps
program automatic test(router_io.TB rtr_io);
  bit[3:0] sa;
  bit[3:0] da;
  logic[7:0] payload[$];
  logic[7:0] pkt2cmp_payload[$];
  int run_for_n_packets;
  int SEED = 2;
  integer repeat_times = 1;
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
    //sa = 3;
    //da = 7;
    sa = $urandom;
    da = $urandom;
    payload.delete();
    repeat($urandom_range(9,2))
      payload.push_back($urandom);
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
    get_payload();
  endtask: recv

  task get_payload();
	pkt2cmp_payload.delete();
	fork begin:wd_timer_fork
		fork: frameo_wd_timer
			@(negedge rtr_io.cb.frameo_n[da]);
			begin
				repeat(1000) @(rtr_io.cb);
				$display("\n%m\n[ERROR]%t Frame signal time out\n",$realtime);
				$finish;
			end
		join_any : frameo_wd_timer
		disable fork;
    	end : wd_timer_fork
    	join
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
    if(!compare(message))begin
      $display("\n%m\n[ERROR]%t Packet #%0d %s\n",$realtime, pkts_checked, message);
      $finish;
    end
    $display("[NOTE]%t Packet #%0d %s",$realtime, pkts_checked++, message);
  endtask: check

  function bit compare(ref string message);
    if(payload.size() != pkt2cmp_payload.size())begin
      message = "Payload size mismatch:\n";
      message = {message,$sformatf("payload.size() = %0d , pkt2cmp_payload.size() = %0d\n",payload.size(), pkt2cmp_payload.size())};
      return (0);
    end
    else if(payload == pkt2cmp_payload)begin
      message = "Successfully Compared";
      return(1);
    end
    else begin
      message = "Payload content mismatch:\n";
      message = {message,$sformatf("Packet Sent: %p\nPkt Received: %p",payload,pkt2cmp_payload)};
      return(0);
    end
  endfunction: compare
endprogram: test
