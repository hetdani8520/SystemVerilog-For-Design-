module day4_tb;
  logic [7:0]   a_i;  //- First 8-bit input vector
  logic [7:0]   b_i;  //- Second 8-bit input vector
  logic [2:0]   op_i; //- Encoded operation
  logic [7:0]   alu_o;  //- ALU output
  
  //dut inst
  day4 dut (.*);
  
  initial begin
    $monitor("time=%t,a_i=%d,b_i=%d,op_i=%b,carry=%d,alu_o=%d",$realtime,a_i,b_i,op_i,dut.carry,alu_o);
    a_i = 8'd0;
    b_i = 8'd0;
    op_i = 3'd0;
    #1;
    repeat(10) begin
      a_i = $urandom_range(0,255);
      b_i = $urandom_range(0,255);
      op_i = $urandom_range(0,7);
      #5;
    end
    //SUB (a<b) - mod result as output which looks good when a<b
    a_i = 8'd253;
    b_i = 8'd255;
    op_i = 8'd1;
    #5;
    //ADD (overflow case) -carry captured correctly
    a_i = 8'd255;
    b_i= 8'd255;
    op_i = 8'd0;
    #5;
    $finish;
  end
  
endmodule