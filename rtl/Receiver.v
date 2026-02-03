module UART_RX(
    input wire clk,
    input wire rst,
    input wire rx_serial,
    input wire oversample_tick,
    output reg [7:0] data_out=0,
    output reg rx_done
);

reg [1:0] current_state,next_state;
parameter idle=2'd0;
parameter start=2'd1;
parameter data=2'd2;
parameter stop=2'd3;

reg [3:0] bit_index=0;
reg [7:0] shift_reg;
reg [3:0] sample_counter=0;


always @(posedge clk or posedge rst)
begin 
   if(rst) begin
     current_state<=idle;
     bit_index<=0;
     shift_reg<=0;
     rx_done<=0;
     sample_counter<=0;
   end else begin
     current_state<=next_state;
   end
end


always @(*)
begin
   case(current_state) 
      idle:begin
        if(~rx_serial) begin
          next_state=start;
        end
      end
      
      start:begin
        if(oversample_tick) begin
             if(sample_counter==8) begin
               sample_counter=0;             
               next_state=data;
             end
        end
      end
      
      data:begin
         if(oversample_tick)begin 
              if( bit_index==8) begin
               next_state=stop;
              end
         end
      end
      
      stop:begin
         if(oversample_tick) begin
             if(rx_serial==1) begin
                next_state=idle;
             end
         end
      end
     default:next_state=idle;
 endcase
end  

always @(posedge clk) 
begin
    case(current_state)
    idle:begin
       rx_done<=0;
       sample_counter<=0;
    end
    
    start:begin
       rx_done<=0;
       bit_index<=0;
       if(oversample_tick) begin
           sample_counter<=sample_counter+1;
       end
    end
    
    
    data:begin
       if(oversample_tick) begin
          if(sample_counter==15) begin
              shift_reg<={rx_serial,shift_reg[7:1]};
              bit_index<=bit_index+1;
              sample_counter<=0;
          end else 
              sample_counter<=sample_counter+1;
       end
    end
    stop:begin
       if(oversample_tick)begin 
           if(rx_serial==1) begin
              data_out<=shift_reg;
              rx_done<=1;
           end
       end
    end
  endcase
end  

endmodule
