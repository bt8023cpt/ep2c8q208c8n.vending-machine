/**
 * @Description 按键计数器
 * @input key_clk 按键计数时钟信号
 * @input key_enable 按键计数使能信号
 * @input key_reset 按键计数复位信号
 * @output key_count 按键计数计数值输出
 * @output key_overflow 按键计数溢出信号
 */
module Keystroke_Count(key_clk, key_enable, key_reset, key_count, key_overflow);
	input wire key_clk;
	input wire key_enable;
	input wire key_reset;
	output reg[3:0] key_count;
	output reg key_overflow;
	
	always @(negedge key_clk or negedge key_reset)
		begin
			if(~key_reset)
				begin
					key_count <= 4'd0;
					key_overflow <= 1'b0;
				end
			else if(key_enable)
				if(key_count < 4'd4)
					begin
						key_count <= key_count + 4'd1;
						if(key_count == 4'd3)
							begin
								key_overflow <= 1'b1;
							end
					end
		end
		
endmodule 