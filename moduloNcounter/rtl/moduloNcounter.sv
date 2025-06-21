module moduloNcounter #(parameter int N = 4)
  (
    input logic clk,
    input logic rstn,
    output logic [N-1:0] cnt //pr_state
  );
  
  logic [N-1:0] nx_cnt; //nx_state var
  
  always_ff @(posedge clk or negedge rstn) begin
    if(!rstn) begin
      cnt <= 'd0;
    end
    else begin
      cnt <= nx_cnt;
    end
  end
  
  always_comb begin //this triggers on change in cnt (which happens only on a clock)
      if(cnt == (N-1)) begin
        nx_cnt = 'd0;
      end 
      else begin
        nx_cnt = cnt + 1;
      end
  end
    
endmodule