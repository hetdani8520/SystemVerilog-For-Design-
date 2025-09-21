module day5 (
  input     logic       clk,
  input     logic       rstn,
  output    logic[7:0]  cnt_o
);
  
  logic [7:0] nx_cnt;
  
  always_ff @(posedge clk or negedge rstn) begin
    if(!rstn) begin
      cnt_o <= 8'd1;
    end
    else begin
      cnt_o <= nx_cnt;
    end
  end
  
  always_comb begin
    nx_cnt = cnt_o + 2'd2;
  end
  
  
endmodule