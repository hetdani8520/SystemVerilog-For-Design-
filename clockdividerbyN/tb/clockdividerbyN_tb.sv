//currently configured to divider by 4 (toggling every 2 cycles of ref clk)
//ref for more info:- https://www.realdigital.org/doc/9c21eab4a0f85c50486858a87380d1f6
module clockdividerbyN_tb;
  parameter int M = 4;
  logic clk;
  logic rstn;
  logic clk_out;
  
  clock_divider_byN #(.N(M)) c2 (.*);
  
  initial begin
    clk=0;
    forever begin
      #5 clk = ~clk;
    end
  end
  
  //dump waves
  initial begin
  $dumpfile("dump.vcd");
  $dumpvars(0);
  end
  
  initial begin
    $monitor("time=%t, cnt=%d & clk_out=%d",$time,c2.cnt,clk_out);
    rstn = 0;
    #5;
    rstn = 1;
    repeat(11) @(posedge clk);
    $finish;
  end
  
endmodule