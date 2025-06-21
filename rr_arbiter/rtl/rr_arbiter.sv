//ref:- https://www.edaplayground.com/x/KztJ
//TODO: we need to make a sync decision on when gnt needs to deassert?
//-currently it deasserts when corr req goes low (but that also delays the gnt for any other req that triggers on successive clock cycle - leaving a 1 cycle delay b/w gnt & req)
module rr_arbiter #(parameter int N = 4)
  (
    input logic clk,
    input logic rstn,
    input logic [N-1:0] req,
    output logic [N-1:0] gnt
  );
  
  logic [$clog2(N)-1:0] pr_token_cntr, nx_token_cntr; //counter width should be log(N)
  
  typedef enum logic [1:0] {S0,S1} state;
  
  state pr_state, nx_state;
  
  always_ff @(posedge clk or negedge rstn) begin
    if(!rstn) begin
      pr_token_cntr <= 0;
      pr_state <= S0;
      //gnt <= 0;
    end
    else begin
      pr_state <= nx_state;
      pr_token_cntr <= nx_token_cntr;
    end
  end
  
  always_comb begin
    case(pr_state)
      S0: begin 
        if(req & (1 << pr_token_cntr)) begin
        	nx_token_cntr = pr_token_cntr;
            gnt = (req & (1 << pr_token_cntr));
            nx_state = S1; 
           end
           else begin
             nx_token_cntr = pr_token_cntr + 1;
             nx_state = S0;
             gnt = 'd0;
           end
          end
      
      S1: begin
        //if req has gone low
        if(!(req & (1 << pr_token_cntr))) begin
          gnt = 'd0;
          nx_token_cntr = pr_token_cntr + 1;
          nx_state = S0;
        end
        else begin //if req has not gone low
          gnt = (req & (1 << pr_token_cntr)); //gnt stays asserted
          nx_token_cntr = pr_token_cntr; //token counter value is retained
          nx_state = S1; //stay in here until the req deasserts
        end 
      end
    endcase
  end
  
endmodule