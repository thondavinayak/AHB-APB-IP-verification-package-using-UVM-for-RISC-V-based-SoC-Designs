

`include "transaction.sv"



class scoreboard #(parameter WIDTH = 8);
  transaction #(.WIDTH(WIDTH)) tr_gen;
  transaction #(.WIDTH(WIDTH)) tr_mon;
  mailbox #(transaction) gen_mb;
  mailbox #(transaction) mon_mb;
  event score_next;
  
  function new(mailbox #(transaction) gen_mb_ref, mailbox #(transaction) mon_mb_ref);
    gen_mb = gen_mb_ref;
    mon_mb = mon_mb_ref;
  endfunction
  
  task run();
    gen_mb.get(tr_gen);
    mon_mb.get(tr_mon);
    tr_gen.display("SCORE GEN");
    tr_mon.display("SCORE MON");
    
    if(tr_mon.dout == tr_gen.din) begin
      $display(" SCOREBOARD MATCH");
    end else begin
      $display(" SCOREBOARD MISMATCH");
    end
    ->score_next;

  endtask


endclass




