module dff#(parameter int WIDTH=8)(dff_intf.slave intf);
  
  always @(posedge intf.clk) begin
    if(intf.rst) begin
      intf.dout <= {WIDTH{1'b0}};
    end else begin
  		intf.dout <= intf.din;
    end
    $display($time, " DUT DONE din : %b, dout : %b", intf.din, intf.dout);
  end
  
endmodule

