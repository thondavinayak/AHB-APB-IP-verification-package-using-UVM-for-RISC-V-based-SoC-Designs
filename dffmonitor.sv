
`include "transaction.sv"
`include "dffinterface.sv"


class monitor #(parameter WIDTH = 8);
  mailbox #(transaction) monitor_mb;
  transaction #(.WIDTH(WIDTH)) tr;
  virtual dff_intf #(.WIDTH(WIDTH)) vif1;
  
  function new(mailbox #(transaction) monitor_mb_ref, virtual dff_intf vif1_ref);
    monitor_mb = monitor_mb_ref;
    vif1 = vif1_ref;
    tr = new();
  endfunction
  
  task run();
    forever begin
      @(posedge vif1.clk);
      @(posedge vif1.clk);
      tr.din = vif1.din;
      tr.dout = vif1.dout;
      monitor_mb.put(tr);
      tr.display("MONITOR");    
    end
  endtask
  
endclass

