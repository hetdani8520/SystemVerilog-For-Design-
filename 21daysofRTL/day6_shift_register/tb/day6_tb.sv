module day6_tb;
  logic clk;
  logic rstn;
  logic x_i;  //-> Serial input
  logic [3:0]   sr_o;  //-> Shift register output
  
  //instatiate dut
  day6 dut (.*);
  
  //clock gen
  initial begin
    clk=1'b0;
    forever begin
      #5 clk = ~clk;
    end
  end
  
   //dump waves
  initial begin
  $dumpfile("dump.vcd");
  $dumpvars(0);
  end
  
  //reset & stim gen
  initial begin
    $monitor("time=%t,rstn=%d,in=%d,out=%b",$time,rstn,x_i,sr_o);
  rstn = 1'b0;
  x_i = 0;
  #1
  rstn = 1'b1;
  repeat(1) @(posedge clk) begin
  x_i = 1;
  end
  repeat (10) @(posedge clk) begin
    x_i = $urandom_range(0,1);
  end
  $finish;
  end
  
  
  
endmodule