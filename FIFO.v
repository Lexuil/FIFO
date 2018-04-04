module FIFO
	#(
		parameter DATO_WIDTH = 8,
		parameter FIFO_LENGTH = 2
	)(
		input wclk,
		input [DATO_WIDTH-1:0] datin,
		input rclk,
		input rst,
		output reg [DATO_WIDTH-1:0] datout,
		output reg full,
		output reg empy,
		output reg dato
	);

	parameter fifo_depth = (1 <<FIFO_LENGTH);

// Registers	
	reg [DATO_WIDTH-1:0] f [0:(fifo_depth-1)];
	reg orwr;
	reg [fifo_depth-1:0] cont = 0;
	reg [fifo_depth-1:0] contw = 0;
	reg [fifo_depth-1:0] contr = 0;
	
	always @(posedge orwr) begin
		if(rst) begin

			for(i=0;i < fifo_depth;i=i+1)begin
				f[i] <= 0;
			end

			cont <= 0;
			contw <= 0;
			contr <= 0;
			datout <= 0;
		end else begin
			case({rclk,wclk})
				2'b01:
					if(~full) begin
						f[contw] <= datin;
						contw <= contw + 3'b001;	
						if(contw >= fifo_depth) contw <= 3'b000;
						cont <= cont + 3'b001;
					end
				2'b10:
					if(~empy) begin
						datout <= f[contr];
						f[contr] <= 0;
						contr <= contr + 3'b001;
						if(contr >= fifo_depth) contr <= 3'b000;
						cont <= cont - 3'b001;
					end
				2'b11:
					if(full) begin
						datout <= f[contr];
						f[contr] <= 0;
						contr <= contr + 3'b001;
						if(contr >= fifo_depth) contr <= 3'b000;
						f[contw] <= datin;
						contw <= contw + 3'b001;	
						if(contw >= fifo_depth) contw <= 3'b000;
					end else if(empy) begin
						datout <= datin;
					end else begin
						if(~full) begin
							f[contw] <= datin;
							contw <= contw + 3'b001;	
							if(contw >= fifo_depth) contw <= 3'b000;
						end
						if(~empy) begin
							datout <= f[contr];
							f[contr] <= 0;
							contr <= contr + 3'b001;
							if(contr >= fifo_depth) contr <= 3'b000;
						end
					end
			endcase
		end
	end
	
	always @(*) begin
		orwr = wclk | rclk | rst;
		if(cont == 0) begin
			empy = 1;
			dato = 0;
			full = 0;
		end
		if(cont > 0) begin
			empy = 0;
			dato = 1;
			full = 0;
		end
		if(cont == fifo_depth) begin
			empy = 0;
			dato = 0;
			full = 1;
		end
	end

endmodule