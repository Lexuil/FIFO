`timescale 1ns / 1ns

module FIFO_TB;
	reg wclk = 0;
	reg wr;
	reg [2:0] datin;
	
	reg rclk = 0;
	reg rd;
	wire [2:0] datout;
	
	wire full;
	wire empy;
	wire dato;
	
	reg rst;
	
	FIFO uut(.wclk(wclk), .wr(wr), .datin(datin), .rclk(rclk), .rd(rd), .datout(datout), .full(full), .empy(empy), .dato(dato), .rst(rst));

	initial begin
		
		wr = 1;
		datin = 2;
		wclk = 1;
		#2;
		wclk = 0;
		#2;
		
		datin = 6;
		wclk = 1;
		#2;
		wclk = 0;
		#2;
		
		datin = 4;
		wclk = 1;
		#2;
		wclk = 0;
		#2;
		
		datin = 1;
		wclk = 1;
		#2;
		wclk = 0;
		#2;
		
		datin = 7;
		wclk = 1;
		#2;
		wclk = 0;
		#2;
		
		datin = 4;
		wclk = 1;
		#2;
		wclk = 0;
		wr = 0;
		
		rd = 1;
		rclk = 1;
		#2;
		rclk = 0;
		#2;
		
		rclk = 1;
		#2;
		rclk = 0;
		#2;
		
		rclk = 1;
		#2;
		rclk = 0;
		#2;
		rd = 0;
		
		wr = 1;
		datin = 1;
		wclk = 1;
		#2
		wclk = 0;
		#2
		
		datin = 5;
		wclk = 1;
		#2
		wclk = 0;
		#2
		
		datin = 6;
		wclk = 1;
		#2
		wclk = 0;
		wr = 0;
		#2
		
		rd = 1;
		rclk = 1;
		#2;
		rclk = 0;
		#2;
		
		rclk = 1;
		#2;
		rclk = 0;
		#2;
		
		rclk = 1;
		#2;
		rclk = 0;
		#2;
		
		rclk = 1;
		#2;
		rclk = 0;
		#2;
		
		rclk = 1;
		#2;
		rclk = 0;
		#2;
		rd = 0;
		
		
	end

	initial begin: TEST_CASE
		$dumpfile("FIFO_TB.vcd");
		$dumpvars(-1,uut);
		#(20000) $finish;
	end

endmodule
