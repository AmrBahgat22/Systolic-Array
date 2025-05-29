module WS_Systolic_tb();

// Simulation Inputs
parameter in_word_size = 16;
parameter out_word_size = 16;
parameter inputs_lengths = 7;
parameter row = 1; // PE in row
parameter column = 4;	// PE in column

localparam	test_4x4_fmap = 0;
localparam	test_3x3_fmap = 0;

localparam  conv_counts = inputs_lengths + 1;
localparam  out_counts  = column;

localparam Preload_op = 0;
localparam Conv_op	 = 1;


reg [in_word_size -1:0] fmap 		[0:column -1][0:inputs_lengths-1];
reg [in_word_size -1:0] kernel 	[0:row -1][0:inputs_lengths-1];

integer i = 0;

reg test = test_3x3_fmap;


/*
	image_4x4:
	
	a3 8e c5 ba
	f5 c3	82 77
	a5 66 25 42
	e1 6a d5 d9
	
	
	kernel:
	
	4c ee
	5a eb
	
	
	
	im2row:
	
	00 00 00 00 00 00 00 00 c3 f5 8e a3
	00 00 00 00 00 00 00 82 c3 c5 8e 00
	00 00 00 00 00 00 c5 ba 82 77 00 00
	00 00 00 00 00 f5 c3 a5 66 00 00 00
	00 00 00 00 c3 82 66 25 00 00 00 00
	00 00 00 82 77 25 42 00 00 00 00 00
	00 00 a5 66 e1 6a 00 00 00 00 00 00
	00 66 25 6a d5 00 00 00 00 00 00 00
	25 42 d5 d9 00 00 00 00 00 00 00 00
	
	c3 f5 8e a3
	82 c3 c5 8e
	c5 ba 82 77
	f5 c3 a5 66
	c3 82 66 25
	82 77 25 42
	a5 66 e1 6a
	66 25 6a d5
	25 42 d5 d9
*/

/*
	image_3x3:
	
	a3 8e c5 
	f5 c3	82 
	a5 66 25 
	
	
	kernel:
	
	03 02
	04 05
	
	Expected output:
	
	aa8  8ca
	8F7  59e
	
	im2row:

	00 00 00 c3 f5 8e a3
	00 00 82 c3 c5 8e 00   ----\
	00 66 a5 c3 f5 00 00   ----/
	25 66 82 c3 00 00 00
	
	kernel flattened:
	
	00
	00
	00
	05
	04
	02
	03
	
	||
	||
	||
	\/
	
	
	
	im2row without zeros:
	
	c3 f5 8e a3
	82 c3 c5 8e
	f5 c3 a5 66
	c3 82 66 25
	
	
	for matlab testing copy these lines:
	fmap = [163 142 197; 245 195 130; 165 102 37];
	kernel = [3 2; 4 5];
	Result = conv2(fmap,kernel);
	
*/


// INPUTs
reg clk;
reg rst;
reg [in_word_size -1:0] 	fmap_in	 [0:column -1];
reg [in_word_size -1:0] 	kernel_in [0:row -1];
reg [out_word_size-1:0] 	Result_in [0:row -1];

// OUTPUTs	
wire [in_word_size -1:0] 	fmap_out   [0:column -1];
wire [in_word_size -1:0] 	kernel_out [0:row -1];
wire [out_word_size-1:0] 	Result_out [0:row -1];

// Parameters
reg [7:0] counter;
reg 		 start_conv;
reg		 Op_sel;


WS_Systolic #(in_word_size,out_word_size,row,column) DUT
(
	clk,
	rst,
	fmap_in,
	kernel_in,
	Result_in,
	Op_sel,
	fmap_out,
	kernel_out,
	Result_out
);


initial begin
	if(test == test_3x3_fmap) begin
		$readmemh("E:\image_3x3_im2row.txt",fmap);
		$readmemh("E:\kernels_2x2_flattened.txt",kernel);
	end
	
	clk  			= 1'b0;
	rst  			= 1'b1;
	counter 		= 0;
	start_conv	= 0;
	Op_sel 		= Preload_op;
	
		for(i = 0; i < column; i = i + 1) begin  
			fmap_in[i] <= 0;
		end
		
		for(i = 0; i < row; i = i + 1) begin  
			kernel_in[i] <= 0;
		end
		
		for(i = 0; i < row; i = i + 1) begin  
			Result_in[i] <= 0;
		end

	#5
	rst = 1'b0;
		
	#5
	rst = 1'b1;
		
	forever begin
		#10 clk = ~clk ;
	end
end



always@(posedge clk) begin
	if(!Op_sel) begin
		if(counter < column) begin // Preload the kernels
			// Input kernel
			for(i = 0; i < row; i = i + 1) begin
				kernel_in[i] = kernel[i][(column-1) - counter];
			end
			
			// Increment the counter 
			counter = counter + 1;
			
		end else begin
			counter = 0;
			Op_sel = Conv_op;
		end
	end else begin					// Start Convolution
		if(counter < conv_counts +1) begin
			// Input fmap
			for(i = 0; i < column; i = i + 1) begin
				fmap_in[i] = fmap[i][counter];
			end
		
			// Increment the counter 
			counter = counter + 1;
		end else begin
			$stop;
		end
	end
end



endmodule


