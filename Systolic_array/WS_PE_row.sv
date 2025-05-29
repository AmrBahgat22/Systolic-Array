module WS_PE_row
#(parameter in_word_size 	= 16,
				out_word_size 	= 16,
				row 				= 3)
(
	input clk,
	input rst,
	input [in_word_size -1:0] 	fmap_in,
	input [in_word_size -1:0] 	kernel_in [0:row -1],
	input [out_word_size-1:0] 	Result_in [0:row -1],
	input   		  				   Op_sel,
	
	output [in_word_size -1:0] 	fmap_out,
	output [in_word_size -1:0] 	kernel_out [0:row -1],
	output [out_word_size-1:0] 	Result_out [0:row -1]
);

wire [in_word_size-1:0] fmap_connection [0:row];

assign fmap_connection[0] 	= fmap_in;
assign fmap_out 				= fmap_connection[row];


genvar i;

generate
	for(i = 0; i < row; i = i + 1) begin : Systolic_row
			WS_PE #(in_word_size,out_word_size) PE0 
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





