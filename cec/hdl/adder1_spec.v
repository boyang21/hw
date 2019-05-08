// chain 
module adder1_spec (/*AUTOARG*/
   // Outputs
   sum,
   // Inputs
   oprs
   );
   parameter WIDTH = 32;
   parameter NUM = 16;

   parameter SUM_WIDTH = WIDTH + $clog2(NUM);   
   input [NUM*WIDTH-1:0] oprs;
   output [SUM_WIDTH-1:0]     sum;
   
   wire  [WIDTH-1:0] oprs_sliced [NUM-1:0];


   logic [SUM_WIDTH-1:0] imm_sum [NUM-1:0];
   genvar 		 i;
   
   generate
      for ( i=0; i<NUM; i++)
	assign oprs_sliced[i] = oprs[(i+1)*WIDTH-1:i*WIDTH];
   endgenerate
   assign imm_sum[0] = oprs_sliced[0];
   generate
      for ( i=1; i<NUM; i++)
	// if (i == 0)
	//   assign imm_sum[0] = oprs_sliced[0];
	// else
	  assign imm_sum[i] = imm_sum[i-1] + oprs_sliced[i];
   endgenerate
   assign sum = imm_sum[NUM-1];
   
endmodule
   
   
