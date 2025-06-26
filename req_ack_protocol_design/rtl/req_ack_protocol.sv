module req_ack_protocol(
  input logic clk,
  input logic rstn
);
  
  logic req, ack;
  
 /*
 unsythesizable logic
  //master
  initial begin  
  while(!ack) begin
    req = 1;
  end
    req = 0;
  end
  */
  
  typedef enum logic [1:0] {IDLE,S0} master_state;
  
  master_state pr_mst_state, nx_mst_state;
  
  typedef enum logic [1:0] {IDLE_S,S_S0,S_S1} slave_state;
  
  slave_state pr_slv_state, nx_slv_state;
  
  //master fsm
  always_ff @(posedge clk or negedge rstn) begin
    if(!rstn) begin
      pr_mst_state <= IDLE;
    end
    else begin
      pr_mst_state <= nx_mst_state;
    end
  end
  
  always_comb begin
    case(pr_mst_state)
      IDLE: begin
        req = 1;
        if(ack) begin
          nx_mst_state = S0;
        end
        else begin
          nx_mst_state = IDLE;
        end
      end
      
      S0: begin
        req = 0;
        if(!ack) begin
          nx_mst_state = IDLE;
        end
        else begin
          nx_mst_state = S0;
        end
      end
    endcase
  end
  
  
  //slave fsm
  always_ff @(posedge clk or negedge rstn) begin
    if(!rstn) begin
      pr_slv_state <= IDLE_S;
    end
    else begin
      pr_slv_state <= nx_slv_state;
    end
  end
  
  always_comb begin
    case(pr_slv_state)
      IDLE_S:begin
        ack = 0;
        if(req) begin
          nx_slv_state = S_S0;
        end
        else begin
          nx_slv_state = IDLE_S;
        end
      end
      
      //dummy state for slave to perform some operation
      S_S0: begin
        ack = 0;
        nx_slv_state = S_S1;
      end
      
      S_S1: begin
        ack = 1;
        if(!req) begin
          nx_slv_state = IDLE_S;
        end else begin
          nx_slv_state = S_S1;
        end
      end
    endcase
  end
  
endmodule