module WS_Systolic
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
	input 	 					   Op_sel,
	output [in_word_size -1:0] 	fmap_out   [0:column -1],
	output [in_word_size -1:0] 	kernel_out [0:row -1],
	output [out_word_size-1:0] 	Result_out [0:row -1]
);

wire [in_word_size - 1:0] kernel_connection [0:column][0:row-1];
wire [in_word_size - 1:0] Result_connection [0:column ][0:row-1];

assign kernel_connection[0] = kernel_in;
assign Result_connection[0] = Result_in;

assign kernel_out = kernel_connection[column ];
assign Result_out = Result_connection[column ];

genvar i;


generate
	for(i = 0; i < column; i = i + 1) begin : Systolic_row

			WS_PE_row #(in_word_size,out_word_size,row) PE0_row 
			(
				clk,
				rst,
				fmap_in[i],
				kernel_connection[i],
				Result_connection[i],
				Op_sel,
				fmap_out[i],
				kernel_connection[i+1],
				Result_connection[i+1]);
	end
endgenerate



endmodule