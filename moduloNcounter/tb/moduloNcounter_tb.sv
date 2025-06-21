module moduloNcounter_tb;
  parameter int M = 10;
  logic clk;
  logic rstn;
  logic [M-1:0] cnt;
  
  moduloNcounter #(.N(M)) c1 (.*);
  
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
    $monitor("time=%t, cnt=%d",$time,cnt);
    rstn = 0;
    #1;
    rstn = 1;
    repeat(11) @(posedge clk);
    $finish;
  end
  
endmodule