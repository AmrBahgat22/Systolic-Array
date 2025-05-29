module OS_PE_column
#(parameter in_word_size 	= 16,
				out_word_size 	= 16,
				row 				= 3,
				column			= 3)
(
	input clk,
	input rst,
	input [in_word_size -1:0] 	fmap_in	 [0:column -1],
	input [in_word_size -1:0] 	kernel_in [0:row -1],
	input [out_word_size-1:0] 	Result_in [0:row -1],
	input Op_sel,
	
	output [in_word_size -1:0] 	fmap_out   [0:column -1],
	output [in_word_size -1:0] 	kernel_out [0:row -1],
	output [out_word_size-1:0] 	Result_out [0:row -1]
);

wire [(in_word_size * row) - 1:0] kernel_connection [0:column + 1];
wire [(in_word_size * row) - 1:0] Result_connection [0:column + 1];



genvar i;
genvar j;

// Connect Kernel & Result inputs to the wire array
generate
   for(j = 0;j < row; j = j + in_word_size) begin : Systolic_intreconnect_input
     assign kernel_connection[0][(in_word_size-1)+j:j] = kernel_in [j/in_word_size];
	  assign Result_connection[0][(in_word_size-1)+j:j] = Result_in[j/in_word_size];
	end
 endgenerate
 
 // Connect Kernel & Result output to the wire array
 generate
   for(j = 0;j < row; j = j + in_word_size) begin : Systolic_intreconnect_output
     assign kernel_out [j/in_word_size] = kernel_connection[column + 1][(in_word_size-1)+j:j];
	  assign Result_out[j/in_word_size] = Result_connection[column + 1][(in_word_size-1)+j:j];
	end
 endgenerate
 
 
 
 
 wire [in_word_size:0] kn_inter_in [0:row -1];
 wire [in_word_size:0] Rs_inter_in [0:row -1];
 
 wire [in_word_size:0] kn_inter_out [0:row -1];
 wire [in_word_size:0] Rs_inter_out [0:row -1];
 
generate
	for(i = 0; i < column; i = i + 1) begin : Systolic_column
	
		for(j = 0;j < row; j = j + in_word_size) begin : intreconnect_in
			assign kn_inter_in [j/in_word_size] = kernel_connection[i][(in_word_size-1)+j:j];
			assign Rs_inter_in [j/in_word_size] = Result_connection[i][(in_word_size-1)+j:j];
		end
		
		for(j = 0;j < row; j = j + in_word_size) begin : intreconnect_out
			assign kn_inter_out [j/in_word_size] = kernel_connection[i+1][(in_word_size-1)+j:j];
			assign Rs_inter_out [j/in_word_size] = Result_connection[i+1][(in_word_size-1)+j:j];
		end
		
			OS_PE_row #(in_word_size,out_word_size,row) PE0_row 
			(
				clk,
				rst,
				fmap_in[i],
				kn_inter_in,
				Rs_inter_in,
				Op_sel,
				fmap_out[i],
				kn_inter_out[],
				Rs_inter_out[]);
	end
endgenerate


endmodule