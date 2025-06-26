module req_ack_tb;
  logic clk;
  logic rstn;
  
  //dut instantiation
  req_ack_protocol dut (.*);
  
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
    $monitor("time=%t,req=%d,ack=%d",$time,dut.req,dut.ack);
    rstn=0;
    #1;
    rstn=1;
    repeat(6) @(posedge clk);
    $finish;
  end
  
endmodule