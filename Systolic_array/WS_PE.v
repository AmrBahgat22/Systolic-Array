module WS_PE
#(parameter in_word_size 	= 16,
				out_word_size 	= 16) 
(
	input     clk,
	input     rst,
	input     wire   [in_word_size-1:0]   fmap_in,
	input     wire	  [in_word_size-1:0]   kernel_in,
	input		 wire   [out_word_size-1:0]  Result_in,
	input 	 wire 			  				  Op_sel,
	
	output    reg    [in_word_size-1:0]   fmap_out,
	output    reg    [in_word_size-1:0]   kernel_out,
	output    reg    [out_word_size-1:0]  Result_out
);

localparam Preload_op = 0;
localparam Conv_op	 = 1;

wire    [out_word_size-1:0] Mul;


assign Mul = fmap_in * kernel_out;

always @ (posedge clk or negedge rst) begin 
		if (!rst) begin 
			fmap_out 	<= 0;
			kernel_out 	<= 0;
			Result_out 	<= 0;				
		end else begin 
			fmap_out 	<= fmap_in;
			Result_out  <= Result_in + Mul;
			if(Op_sel == Preload_op) kernel_out 	<= kernel_in;
		end 
	end 
	
endmodule 