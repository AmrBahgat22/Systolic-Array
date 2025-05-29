module OS_PE_row
#(parameter in_word_size 	= 16,
				out_word_size 	= 16,
				PE_in_row 		= 3)
(
	input clk,
	input rst,
	input [in_word_size-1:0] 	fmap_in,
	input [in_word_size-1:0] 	kernel_in [0:PE_in_row],
	input [out_word_size-1:0] 	Result_in [0:PE_in_row],
	input Op_sel,
	
	output [in_word_size-1:0] 	fmap_out,
	output [in_word_size-1:0] 	kernel_out [0:PE_in_row],
	output [out_word_size-1:0] Result_out [0:PE_in_row]
);

wire [in_word_size-1:0] fmap_connection [0:PE_in_row + 1];

assign fmap_in 	= fmap_connection[0];
assign fmap_out 	= fmap_connection[PE_in_row + 1];


genvar i;

generate
	for(i = 0; i < PE_in_row; i = i + 1) begin : Systolic_row
			OS_PE #(in_word_size,out_word_size) PE0 
			(clk,
			 rst,
			 fmap_connection[i],
			 kernel_in[i],
			 Result_in[i],
			 Op_sel,
			 fmap_connection[i+1],
			 kernel_out[i],
			 Result_out[i]);
	end
endgenerate

endmodule





