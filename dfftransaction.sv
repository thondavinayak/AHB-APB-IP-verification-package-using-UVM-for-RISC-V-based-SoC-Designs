
`ifndef TRANSACTION_SV
`define TRANSACTION_SV

class transaction#(parameter int WIDTH = 8);
  rand logic [WIDTH-1:0] din;
  logic [WIDTH-1:0] dout;

  
  function transaction#(WIDTH) copy();
      transaction#(WIDTH) tmp;
      tmp = new();
      tmp.din  = this.din;
      tmp.dout = this.dout;
   	  return tmp;
	endfunction
  
  function void display(string s);
    $display($time, " %s : din : %b, dout : %b ", s, din, dout);
  endfunction
  
endclass

`endif

