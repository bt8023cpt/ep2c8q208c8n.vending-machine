/**
 * @Description 分频器：由10khz分频到1hz
 * @input clk_10khz 10khz时钟输入
 * @output clk_1hz 1hz时钟输出
 */
module Frequency_1hz(clk_10khz, clk_1hz);
	input wire clk_10khz;
	output reg clk_1hz;
	
	/* 中间计数变量，最大值：2^13 = 8192 */
	reg[12:0] count_1hz;
	
	always@(posedge clk_10khz)
		begin
			if(count_1hz == 13'd4999)
				begin
					clk_1hz <= ~clk_1hz;
					count_1hz <= 13'd0;
				end
			else
				begin
					count_1hz <= count_1hz + 13'd1;
				end
		end
		
endmodule 