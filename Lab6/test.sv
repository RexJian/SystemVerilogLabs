`include "Environment.sv"
program automatic test(router_io.TB rtr_io);
	
	Environment env;	
	initial begin
		env = new("env", rtr_io);
		env.configure();
		env.run();
	end
endprogram: test
