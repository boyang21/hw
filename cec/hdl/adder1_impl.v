// tree
module adder1_impl (/*AUTOARG*/
   // Outputs
   sum,
   // Inputs
   oprs
   );
   parameter WIDTH = 32;
   parameter NUM = 16; //

   localparam SUM_WIDTH = WIDTH + $clog2(NUM);
   localparam TREE_DEPTH = $clog2(NUM)+1;

   input [NUM*WIDTH-1:0]  oprs;   
   output [SUM_WIDTH-1:0] sum;

   wire [WIDTH-1:0] 	  oprs_sliced [NUM-1:0];


   logic [SUM_WIDTH-1:0] imm_sum[TREE_DEPTH-1:0] [NUM-1:0];

   generate
      for ( i=0; i<NUM; i++)
	assign oprs_sliced[i] = oprs[(i+1)*WIDTH-1:i*WIDTH];
   endgenerate
   genvar 		 i;
   genvar 		 j;
   
   generate
      for ( i=0; i<NUM; i++) begin
	 assign imm_sum[0][i][SUM_WIDTH-1:WIDTH] = {(SUM_WIDTH-WIDTH)'d0};
	 assign imm_sum[0][i][WIDTH-1:0] = oprs_sliced[i];
      end
   endgenerate
   generate
      for ( i=1; i<TREE_DEPTH; i++)
	  for (j=0; j<NUM/(1<<i); j++)
	    assign imm_sum[i][j] = imm_sum[i-1][2*j] + imm_sum[i-1][2*j+1];
   endgenerate
   
   assign sum = imm_sum[TREE_DEPTH-1][0];
   
endmodule
   
   
