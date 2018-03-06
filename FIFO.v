module FIFO(wclk,wr,datin,rclk,rd,datout,full,empy,dato,rst);

	input wclk;
	input wr;
	input [2:0] datin;
	
	input rclk;
	input rd;
	output reg [2:0] datout;
	
	output reg full;
	output reg empy;
	output reg dato;
	
	input rst;
	
	reg [2:0] f [0:4];
	/*
	reg [2:0] f1;
	reg [2:0] f2;
	reg [2:0] f3;
	reg [2:0] f4;
	*/
	
	reg [2:0] cont = 0;
	reg [2:0] contw = 0;
	reg [2:0] contr = 0;
	
	always @(posedge wclk) begin
	
		if(wr == 1 && cont <= 4) begin
			cont = cont + 3'b001;
			f[contw] = datin;
			
			if(contw == 4) contw = 3'b000;
			else contw = contw + 3'b001;
			
		end
	
	end
	
	always @(posedge rclk) begin	
		
		if(rd == 1 && cont > 0) begin
			datout = f[contr];
			f[contr] = 0;
			cont = cont - 3'b001;
			
			if(contr == 4) contr = 3'b000;
			else contr = contr + 3'b001;
			
		end
		
	end
	
	always @(*) begin
		/*
		if(rst == 1) begin
			f[0] = 3'b000;
			f[1] = 3'b000;
			f[2] = 3'b000;
			f[3] = 3'b000;
			f[4] = 3'b000;
		end
	*/
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
	
		if(cont == 5) begin
			empy = 0;
			dato = 0;
			full = 1;
		end
		
	end

endmodule
