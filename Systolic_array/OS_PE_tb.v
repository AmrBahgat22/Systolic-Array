module OS_PE_tb (); 

localparam in_word_size 	= 16;
localparam out_word_size 	= 16;
localparam inputs_num 		= 10;

// [1] Declare test Bench 
	reg    							clk;
	reg     							rst;
	reg   [in_word_size-1:0]   IN_Img;
	reg	[in_word_size-1:0]   IN_Weight;
	reg   [out_word_size-1:0]  Result_in;
	reg			  				  	Op_sel;
	
	wire  [in_word_size-1:0]   OUT_Img;
	wire  [in_word_size-1:0]   OUT_Weight;
	wire  [out_word_size-1:0]  Result_out;
	
	// Testing variables
	reg [in_word_size-1:0] fmap_in 	[0:inputs_num-1];
	reg [in_word_size-1:0] weight_in	[0:inputs_num-1];
	reg [7:0]				  counter;

// [2] DUT 
OS_PE DUT(
	clk,
	rst,
	IN_Img,
	IN_Weight,
	Result_in,
	Op_sel,
	OUT_Img,
	OUT_Weight,
	Result_out
);





// [4] initial Block 

initial begin
		$readmemb("E:\weights.txt",fmap_in);
		$readmemb("E:\weights.txt",weight_in);

		clk  			= 1'b0;
		rst  			= 1'b1;
		IN_Img   	= 1'b0;
	   IN_Weight	= 1'b0;
		Result_in	= 1'b0;
		Op_sel		= 1'b0;
		counter 		= 0;
		
		#5
		rst = 1'b0;
		
		#5
		rst = 1'b1;
		
		forever begin
			#10 clk = ~clk ;
		end
end


always@(posedge clk) begin
	if(counter < inputs_num) begin
		counter 		= counter + 1;
		IN_Img 		= fmap_in[counter-1];
		IN_Weight 	= weight_in[counter-1];
	end else begin
		Op_sel = 1'b1;
		counter 		= counter + 1;
		if(counter > inputs_num + 4)	$stop;
	end 
end

endmodule

