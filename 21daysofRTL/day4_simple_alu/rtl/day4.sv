module day4 (
  input     logic [7:0]   a_i,  //- First 8-bit input vector
  input     logic [7:0]   b_i,  //- Second 8-bit input vector
  input     logic [2:0]   op_i, //- Encoded operation

  output    logic [7:0]   alu_o  //- ALU output
);
  
  logic carry;
  
  always_comb begin
    case(op_i)
      3'b000:begin
        {carry,alu_o} = {1'b0,a_i} + {1'b0,b_i}; //ADD (need to handle the overflow case) - maybe add carry
      end
      3'b001:begin
        alu_o = (a_i > b_i) ? (a_i - b_i): -(a_i - b_i); //SUB (a<b case handled)
      end
      3'b010:begin
        alu_o = a_i << b_i[2:0]; //SLL
      end
      3'b011:begin
        alu_o = a_i >> b_i[2:0]; //LSR
      end
      3'b100:begin
        alu_o = a_i & b_i; //AND
      end
      3'b101:begin
        alu_o = a_i | b_i; //OR
      end
      3'b110:begin
        alu_o = a_i ^ b_i; //XOR
      end
      3'b111:begin
        alu_o = (a_i==b_i) ? 8'd1:8'd0; //EQL
      end
    endcase
  end
  
endmodule