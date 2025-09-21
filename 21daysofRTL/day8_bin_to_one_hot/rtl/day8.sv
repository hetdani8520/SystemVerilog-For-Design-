module day8#(
  parameter BIN_W       = 4,
  parameter ONE_HOT_W   = 16
)(
  input   logic [BIN_W-1:0]     bin_i,    //-> Binary input vector
  output  logic [ONE_HOT_W-1:0] one_hot_o  //-> One-hot output (exactly one bit set in a one-hot output)
);
  
  always_comb begin
    one_hot_o = 1 << bin_i;
  end
  
endmodule