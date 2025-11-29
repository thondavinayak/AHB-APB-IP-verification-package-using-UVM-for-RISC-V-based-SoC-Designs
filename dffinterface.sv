`ifndef DFFINTERFACE_SV
`define DFFINTERFACE_SV

interface dff_intf#(parameter int WIDTH = 8);
  logic clk;
  logic rst;
  logic [WIDTH-1:0] din;
  logic [WIDTH-1:0] dout;
  
  modport slave(
    input clk, 
    input rst, 
    input din, 
    output dout
  );
  
  modport master(
    input clk, 
    input rst,
    output din, 
    input dout
  );
  
  
endinterface

`endif
