module day5_tb;
  
  logic clk;
  logic rstn;
  logic [7:0]  cnt_o;
  
  //instantiate dut
  day5 dut (.*);
  
  //clock gen
  initial begin
    clk=1'b0;
    forever begin
      #5 clk = ~clk;
    end
  end
  
  //reset toggling
  initial begin
    $monitor("time=%t, cnt=%d,rstn=%d",$time,cnt_o,rstn);
    rstn = 1'b0;
    #1;
    rstn = 1'b1;
    #30;
    rstn = 1'b0;
    #5;
    rstn = 1'b1;
    #50;
    $finish;
    
  end
  
endmodule