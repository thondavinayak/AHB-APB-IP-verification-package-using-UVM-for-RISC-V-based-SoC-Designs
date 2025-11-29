
`include "transaction.sv"


class generator#(parameter WIDTH = 8);
  transaction #(.WIDTH(WIDTH))tr;
  mailbox #(transaction) driver_mb;
  mailbox #(transaction) score_mb;
  event score_next;
  event done;
  int count;
  
  function new(mailbox #(transaction) driver_mb_ref, mailbox #(transaction) score_mb_ref);
    this.driver_mb = driver_mb_ref;
    this.score_mb = score_mb_ref;
    tr = new();
  endfunction
  
  task run();
    for(int i=0; i < count; i=i+1) begin
      assert(tr.randomize());
      tr.display(" GEN RANDOMIZE");
      driver_mb.put(tr.copy());
      score_mb.put(tr.copy());
      tr.display("GEN");
      @(score_next);
    end
    ->done;
  endtask
  
  
  
endclass




