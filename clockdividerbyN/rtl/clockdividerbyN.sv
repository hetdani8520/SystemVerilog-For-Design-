//ref:- https://www.edaplayground.com/x/YTp2
module clock_divider_byN #(parameter int N = 4)
  (
    input logic clk,
    input logic rstn,
    output logic clk_out //wire
  );
  
  logic [N-1:0] cnt, nx_cnt; //pr_state var, nx_state var
  
  always_ff @(posedge clk or negedge rstn) begin
    if(!rstn) begin
      cnt <= 'd0;
    end
    else begin
      cnt <= nx_cnt;
    end
  end
  
  //toggling logic to mimic clk/N behaviour (clk_out)
  always_comb begin 
    if(cnt < (N/2)) begin
        clk_out = 'd1;
    end
    else begin
      clk_out = 'd0;
    end
  end
  
  //modulo N counter - we may need even small counter (not optimized des)
  always_comb begin
   if(cnt == (N-1)) begin
     nx_cnt <= 'd0;
   end
    else begin
      nx_cnt = cnt + 1;
    end
 end
    
     
endmodule