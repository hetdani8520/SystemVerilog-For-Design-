module day1_tb;
  logic [7:0] a_i;
  logic [7:0] b_i;
  logic sel_i;
  logic [7:0] y_o;
  
  //dut instantiation
  day1 dut (.*);
  
  //dump waves
  initial begin
  $dumpfile("dump.vcd");
  $dumpvars(0);
  end
  
  //stim gen
  initial begin
    $monitor("sel=%d,a=%d,b=%d,y=%d",sel_i,a_i,b_i,y_o);
    repeat(5) begin
    sel_i = $urandom_range(0,1);
    a_i = $urandom_range(0,255);
    b_i = $urandom_range(0,255);
    #1;
    end
    #2;
    $finish;
  end
  
  
endmodule