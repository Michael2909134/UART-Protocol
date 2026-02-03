`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2025 22:44:35
// Design Name: 
// Module Name: baud_rate_generator_rx
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
module baud_rate_generator_rx(

    input  wire clk,      // System clock
    input  wire rst,      // Reset signal
    output reg  oversample_tick // Oversampling tick output for receiver
);

reg [31:0] oversample_counter;
parameter CLOCK_FREQ = 50_000_000;  // System clock frequency (e.g., 50 MHz)
parameter BAUD_RATE  = 9600;         // Desired baud rate
parameter OVERSAMPLE_TICK_COUNT = CLOCK_FREQ / (BAUD_RATE * 16); // Calculated baud tick count
always @(posedge clk or posedge rst) begin
  if (rst) begin
     oversample_counter <= 0;
     oversample_tick <= 0;
   end else if (oversample_counter == OVERSAMPLE_TICK_COUNT - 1) begin
     oversample_counter <= 0;
     oversample_tick <= 1;
   end else begin
     oversample_counter <= oversample_counter + 1;
     oversample_tick <= 0;
   end
end
endmodule