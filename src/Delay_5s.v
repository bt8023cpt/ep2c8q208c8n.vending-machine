/**
 * @Description 延时5s模块：投币后会有5秒显示当前投币值
 * @input delay_clk 1Hz时钟
 * @input delay_enable 使能信号
 * @input delay_key 按键触发信号
 * @output delay_control 数据选择信号
 */
module Delay_5s(delay_clk, delay_enable, delay_key, delay_control);
	input wire delay_clk;
	input wire delay_enable;
	input wire delay_key;
	output reg delay_control;
	
	reg[2:0] delay_count;
	
	always @(posedge delay_clk or negedge delay_key)
		begin
			if(~delay_key)
				begin
					delay_control <= 1'b0;
					delay_count <= 3'd0;
				end
			else if(delay_enable)
				begin
					if(delay_count <= 3'd4)
						begin
							delay_count <= delay_count + 3'd1;
							delay_control <= 1'b0;
						end
					else
						begin
							delay_control <= 1'b1;
						end
				end
		end
		
endmodule 