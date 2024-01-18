`timescale 1ns/100ps
program automatic test(router_io.TB rtr_io);
  bit[3:0] sa;
  bit[3:0] da;
  logic[7:0] payload[$];
  int run_for_n_packets;
  int SEED = 2;
  initial begin
    reset();
    run_for_n_packets = 1;
    repeat(run_for_n_packets) begin
      gen();
      send();
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
    sa = 3;
    da = 7;
    payload.delete();
    repeat(2)
      payload.push_back($urandom(SEED));
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

endprogram: test
