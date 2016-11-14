/**
 * @Description 数据筛选模块：选择进入15秒倒计时的投币值
 * @input data 数据值
 * @input enable_out 可以通过的计数值
 */
module Data_Screening(data, enable_out);
	input wire[3:0] data;
	output wire enable_out;
	
	assign enable_out = data[3:0] >= 4'd1 && data[3:0] <= 4'd3 ? 1 : 0;

endmodule 