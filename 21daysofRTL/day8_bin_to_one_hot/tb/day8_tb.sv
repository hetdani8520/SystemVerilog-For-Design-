module day8_tb;
  parameter int N = 4;
  parameter int M = 16;
  
  logic [N-1:0] bin_i;
  logic [M-1:0] one_hot_o;
  
  //dut inst
  day8 #(.BIN_W(N),.ONE_HOT_W(M)) dut (.*);
  
  
  //stim gen
  initial begin
  $monitor("time:%t,in:%d,one_hot_o=%b",$realtime,bin_i,one_hot_o);
  repeat(16) begin
    bin_i = $urandom_range(0,15);
    #5;
  end
  $finish;
  end
  
endmodule