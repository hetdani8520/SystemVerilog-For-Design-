module day3 (
  input logic clk,
  input logic rstn,
  input logic a_i,            //serial input
  output logic rising_edge_o, //rising edge output
  output logic falling_edge_o //falling edge output
);
  
  logic del_a;
  
  always_ff @(posedge clk or negedge rstn) begin
    if(!rstn) begin
      del_a <= 1'b0;
    end
    else begin
      //the del_a will be delayed version of a only if a is driven just shortly after either the clocking event or before next clocking event.
      del_a <= a_i;
    end
  end
  
  always_comb begin
    if(del_a == 1'b0 && a_i == 1'b1) begin
      rising_edge_o = 1'b1;
    end
    else begin
      rising_edge_o = 1'b0;
    end
  end
  

  always_comb begin
    if(del_a == 1'b1 && a_i == 1'b0) begin
      falling_edge_o = 1'b1;
    end
    else begin
      falling_edge_o = 1'b0;
    end
  end
  
  
  
  
endmodule