module day2_tb;
  	logic clk;
  	logic reset; //active low reset
    logic d_i;
    logic q_norst_o;
    logic q_syncrst_o;
    logic q_asyncrst_o;
  
  //dut instantiation
  day2 dut (.*);
  
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
  
  //stim gen
  initial begin $monitor("time=%t,d_i=%d,q_syncrst_o=%d,q_norst_o=%d,q_asyncrst_o=%d,reset=%d",$time,d_i,q_syncrst_o,q_norst_o,q_asyncrst_o,reset);
    
    //async rst/non-resettable
    reset = 1'b0; //q_asyncrst_o = 0
    d_i = 1'b1;
    #1;
    reset = 1'b1; //q_asyncrst_o = 0
    
    repeat(5) begin
      @(posedge clk); //5 //15 //25 //35 //45
    d_i = $urandom_range(0,1);
    end
    
    //sync rst
    @(posedge clk); //55
    d_i = 1'b1;
    reset = 1'b0; //q_syncrst_o = 0
    @(posedge clk); //65
    reset = 1'b1; //q_syncrst_o = 1 (retain value of d_i from prev clk edge)
    
    repeat(2) @(posedge clk);
    $finish;
  end
  
  
endmodule