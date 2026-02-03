`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2025 22:51:09
// Design Name: 
// Module Name: UART_TOP_MODULE
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
`define BAUD_RATE = 9600;
`define CLOCK_FREQ = 50000000;

module UART_TOP_MODULE(
    input wire clk,
    input wire rst,
    input wire [7:0] data_in, // Data to transmit
    input wire send,          // Signal to start transmission
    output wire [7:0] data_out,// Received data for output
    output wire tx_done,      // TX done flag
    output wire rx_done       // RX done flag
);

// Internal signals
wire baud_tick;
wire oversample_tick;
wire tx_serial;

// Instantiate baud generator for TX
 baud_rate_generator_tx baud_gen_tx_inst (
    .clk(clk),
    .rst(rst),
    .baud_tick(baud_tick)
);
baud_rate_generator_rx baud_gen_rx_inst (
    .clk(clk),
    .rst(rst),
    .oversample_tick(oversample_tick)
);

// Instantiate UART TX
UART_TX uart_tx_inst (
    .clk(clk),
    .rst(rst),
    .baud_tick(baud_tick),
    .data_in(data_in),
    .send(send),
    .tx_serial(tx_serial),
    .tx_done(tx_done)
);

// Instantiate UART RX
UART_RX uart_rx_inst (
    .clk(clk),
    .rst(rst),
    .rx_serial(tx_serial),
    .oversample_tick(oversample_tick),
    .data_out(data_out),
    .rx_done(rx_done)
);

endmodule

    
    