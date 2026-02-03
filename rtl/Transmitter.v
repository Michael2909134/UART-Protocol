`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2025 22:11:32
// Design Name: 
// Module Name: Transmitter
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


module UART_TX(
    input wire clk,
    input wire rst,
    input wire baud_tick,
    input wire [7:0] data_in,
    input wire send,
    output reg tx_serial,
    output reg tx_done
 );
 
 reg [1:0] current_state,next_state;
 reg [3:0] bit_index;
 reg [7:0] shift_reg;
 
 parameter idle=2'd0;
 parameter start=2'd1;
 parameter data=2'd2;
 parameter stop=2'd3;
 
 always @(posedge clk or posedge rst)
 begin
   if(rst) begin
     current_state<=idle;
     tx_serial<=1;
     tx_done<=0;
     bit_index<=0;
   end else 
     current_state<=next_state;
 end
   
 always @(*)
 begin
  next_state=current_state;
   case(current_state)
     idle:begin
        if(send) begin
            next_state=start;
        end
     end
        
     start:begin
       if(baud_tick) begin
          next_state=data;
       end
     end
        
     data:begin
       if(baud_tick) begin
           if(bit_index==7) begin
              next_state=stop;
           end
       end   
     end
        
     stop:begin
       if(baud_tick) begin
          next_state=idle;
       end
     end
        
     default:next_state=idle;
   endcase
 end

always @(posedge clk)
begin
  case(current_state)
    idle:begin
      tx_done<=0;
      tx_serial<=1;
      if(send) begin
         shift_reg<=data_in;
         bit_index<=0;
      end
    end
    
    start:begin
      if(baud_tick) begin
         tx_serial<=0;
         tx_done<=0;
      end
    end
    
    data: begin
        if (baud_tick) begin
            tx_serial <= shift_reg[0];
            shift_reg <= shift_reg >> 1;
             bit_index <= bit_index + 1;
        end
    end
                       
    stop: begin
        if (baud_tick) begin
             tx_serial <= 1; // Stop bit
             tx_done <= 1;
        end
    end
endcase
end
endmodule
                   
               
