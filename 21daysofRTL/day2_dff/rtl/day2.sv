module day2 (
	input logic clk,
  	input logic reset, //active low reset
    input logic d_i,
    output logic q_norst_o,
    output logic q_syncrst_o,
    output logic q_asyncrst_o
);
  

  //non-resettable flop
  always_ff @(posedge clk) begin
    q_norst_o <= d_i;
  end
  
  //async rst (active low reset)
  always_ff @(posedge clk or negedge reset) begin
    if(!reset) begin
      q_asyncrst_o <= 1'b0;
    end 
    else begin  
      q_asyncrst_o <= d_i;
    end
  end
  
  //sync rst (active low reset)
  always_ff @(posedge clk) begin
    if(!reset) begin
      q_syncrst_o <= 1'b0;
    end
    else begin
      q_syncrst_o <= d_i;
    end
  end
  
endmodule