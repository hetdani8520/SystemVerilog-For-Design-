module day6 (
  input logic clk,
  input logic rstn,
  input logic x_i,  //-> Serial input
  output logic [3:0]   sr_o  //-> Shift register output
);
  
  always_ff @(posedge clk or negedge rstn) begin
    if(!rstn) begin
      sr_o <= 4'd0;
    end
    else begin
      sr_o[0] <= x_i;
      for(int i=1;i<4;i++) begin
        sr_o[i] <= sr_o[i-1];
      end 
    end
  end
  
endmodule