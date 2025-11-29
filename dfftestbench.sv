
`include "env.sv"
`include "dffinterface.sv"

module testbench();
  localparam int WIDTH = 8;
  
  dff_intf #(.WIDTH(WIDTH)) intf1();
  
  dff #(.WIDTH(WIDTH)) dff1 (intf1.slave);
  
  initial begin
    intf1.clk = 1'b0;
  	forever begin
    	#5; intf1.clk = ~intf1.clk;
    end
  end
  
  env #(.WIDTH(WIDTH)) env1;
  
  initial begin
    env1 = new(intf1);
    env1.gen.count = 3;
    env1.run();
  end
  
  initial begin
    $dumpfile("file1.vcd");
    $dumpvars(0, testbench);
    $dumpon();
  end
   
  /*
  initial begin
    $dumpfile("file1.vcd");
    $dumpvars(0, testbench);
    $dumpon();
  	intf1.rst = 1'b1;
    #50;
    intf1.rst = 1'b0;
    intf1.din = 16'hABCD;
    #20;
    intf1.din = 16'hEFAB;
    #20;
    intf1.rst = 1'b1;
    #50;
    $dumpoff();
    $finish();
  end
  */
  
                           
                           
                     
endmodule
