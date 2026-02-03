`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2025 22:42:05
// Design Name: 
// Module Name: buad_rate_generator_tx
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

module baud_rate_generator_tx(

    input  wire clk,      // System clock
    input  wire rst,      // Reset signal
    output reg  baud_tick // Baud tick output for transmitter
);

reg [31:0] counter;
parameter CLOCK_FREQ = 50_000_000;  // System clock frequency (e.g., 50 MHz)
parameter BAUD_RATE  = 9600;         // Desired baud rate
parameter BAUD_TICK_COUNT = CLOCK_FREQ / BAUD_RATE; // Calculated baud tick count

always @(posedge clk or posedge rst) begin
   if (rst) begin
     counter   <= 0;
     baud_tick <= 0;
   end else if (counter == BAUD_TICK_COUNT - 1) begin
     counter   <= 0;
     baud_tick <= 1;
   end else begin
     counter   <= counter + 1;
     baud_tick <= 0;
    end
end
endmodule