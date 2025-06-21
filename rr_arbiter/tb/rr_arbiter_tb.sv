module rr_arbiter_tb;
  parameter int M = 4;
  logic clk;
  logic rstn;
  logic [M-1:0] req;
  logic [M-1:0] gnt;
  
  //dut instantiation
  rr_arbiter #(.N(M)) r1 (.*);
  
  //clock gen
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
  
  //stim gen
  initial begin
    $monitor("time=%t, req=%b, gnt=%b,pr_token_cntr=%d",$time,req,gnt,r1.pr_token_cntr);
    rstn = 0;
    req = 4'b0000;
    #1;
    rstn = 1;
    @(posedge clk);
    req=4'b0010; //best-case scenario (token counter & req match) - same cycle gnt
    @(posedge clk);
    req=4'b0100;
    repeat(10) @(posedge clk);
    $finish;
  end
  
endmodule