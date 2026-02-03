`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2025 23:14:59
// Design Name: 
// Module Name: Uart_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Uart_tb;

// Signals
   reg clk;
   reg rst;
   reg [7:0] data_in;
   reg send;
   wire [7:0] data_out;
   wire tx_done;
   wire rx_done;
   UART_TOP_MODULE uut (
       .clk(clk),
       .rst(rst),
       .data_in(data_in),
       .send(send),
       .data_out(data_out),
       .tx_done(tx_done),
       .rx_done(rx_done)
   );

// Clock generation
initial 
begin
    clk = 0;
    forever #5 clk = ~clk; // 50 MHz clock
end

initial
begin
  data_in=8'b01101010;
  send=0;
  rst=1;
  #10 rst=0;
  #10 send=1;
  #10 send=0;
  
end
endmodule
