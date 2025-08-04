module day3_tb;
  
  logic clk;
  logic rstn;
  logic a_i;            //serial input
  logic rising_edge_o; //rising edge output
  logic falling_edge_o; //falling edge output
  
  
  //dut inst
  day3 dut (.*);
  
  //dump waves
  initial begin
  $dumpfile("dump.vcd");
  $dumpvars(0);
  end
  
  //clk gen
  initial begin
    clk=1'b0;
    forever begin
     #5 clk = ~clk; 
    end
  end
  
  initial begin
 $monitor("time=%t,a_i=%d,rising_edge_o=%d,falling_edge_o=%d",$time,a_i,rising_edge_o,falling_edge_o);
    rstn = 1'b0;
    a_i = 1'b0;
    #1;
    rstn = 1'b1;
    repeat(3) @(posedge clk);
    
    //rising edge detector
    @(posedge clk);
    #1;
    a_i = 1'b1;
    repeat(2) @(posedge clk);
    
    //falling edge detector
    @(posedge clk);
    #1;
    a_i= 1'b0;
    repeat(2) @(posedge clk);
    $finish;
  end
  
endmodule