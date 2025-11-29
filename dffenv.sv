
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "dffinterface.sv"


class env#(parameter int WIDTH=8);
  generator gen;
  driver drv;
  monitor mon;
  scoreboard score;
  
  virtual dff_intf #(.WIDTH(WIDTH)) vif1;
  
  event next; 
  
  mailbox #(transaction) gen_driver_mb;
  mailbox #(transaction) mon_score_mb;
  mailbox #(transaction) gen_score_mb;
  
  function new(virtual dff_intf vif1_ref);
    vif1 = vif1_ref;
    
    gen_driver_mb = new();
    mon_score_mb = new();
    gen_score_mb  = new();
    
    gen = new(gen_driver_mb, gen_score_mb);
    drv  = new(gen_driver_mb, vif1);
    mon = new(mon_score_mb, vif1);  
      
    score = new(gen_score_mb, mon_score_mb);
      
    gen.score_next = next;
    score.score_next = next;
      
  endfunction
  
  
  task pre_test();
    drv.reset(5);
  endtask
  
  task test();
    fork
      drv.run();
      gen.run();
      score.run();
      mon.run();
    join_any
  endtask
  
  task post_test();
    //wait(gen.done.triggered);
    #500;
    $finish();
  endtask
  
  task run();
    pre_test();
    test();
    post_test();
  endtask
  
  
endclass

