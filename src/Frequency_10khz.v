/**
 * @Description 分频器：由50Mhz分频到10khz
 * @input clk_50Mhz 50Mhz时钟输入
 * @output clk_10khz 10khz时钟输出
 */
module Frequency_10khz(clk_50Mhz, clk_10khz);
	input wire clk_50Mhz;
	output reg clk_10khz;
	
	/* 中间计数变量，最大值：2^12 = 4096 */
	reg[11:0] count_10khz;
	
	always@(posedge clk_50Mhz)
		begin
			if(count_10khz == 12'd2499)
				begin
					clk_10khz <= ~clk_10khz;
					count_10khz <= 12'd0;
				end
			else
				begin
					count_10khz <= count_10khz + 12'd1;
				end
		end
		
endmodule 