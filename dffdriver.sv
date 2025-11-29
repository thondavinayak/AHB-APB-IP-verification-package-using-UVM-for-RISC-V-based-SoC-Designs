
`include "transaction.sv"
`include "dffinterface.sv"



class driver #(parameter int WIDTH = 8);
  transaction #(.WIDTH(WIDTH)) tr;
  mailbox #(transaction) driver_mb;
  virtual dff_intf #(.WIDTH(WIDTH)) vif1;
  
  function new(mailbox #(transaction) driver_mb_ref, virtual dff_intf vif1_ref);
  	driver_mb = driver_mb_ref;
    vif1 = vif1_ref;
  endfunction
  
  task reset(int num_cycles);
  	vif1.rst = 1'b1;
    repeat(num_cycles) begin
      @(posedge vif1.clk);
    end
    vif1.rst = 1'b0;
    $display(" Driver : RST Done");
  endtask

  
    task run();
      forever begin
        driver_mb.get(tr);
        vif1.din = tr.din;
        @(posedge vif1.clk);
        vif1.din = {WIDTH{1'b0}};
        tr.display("DRV");
        @(posedge vif1.clk);
      end
    endtask
  
endclass
