/**
 * @Description 延时15s模块：5秒后会显示15秒倒计时
 * @input delay_clk 1Hz时钟
 * @input delay_enable 使能信号
 * @input delay_reset 复位信号
 * @output delay_number 倒计时当前值
 * @output delay_overflow 15秒到达，溢出信号
 */
module Delay_15s(delay_clk, delay_enable, delay_reset, delay_number, delay_overflow);
	input wire delay_clk;
	input wire delay_enable;
	input wire delay_reset;
	output reg[3:0] delay_number;
	output reg delay_overflow;
	
	always @(posedge delay_clk or negedge delay_reset)
		begin
			if(~delay_reset)
				begin
					delay_number <= 4'd15;
					delay_overflow <= 1'b0;
				end
			else if(delay_enable)
				begin
					if(delay_number > 4'd0)
						begin
							delay_number <= delay_number - 4'd1;
							if(delay_number == 4'b1)
								delay_overflow <= 1'b1;
							else
								delay_overflow <= 1'b0;
						end
					else
						begin
							delay_overflow <= 1'b1;
						end
				end
		end

endmodule 