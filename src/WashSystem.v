/**
 * @Description 顶层文件
 */
module WashSystem(clk, reset, key, duan, wei, led, other);
	input wire clk;
	input wire reset;
	input wire key;
	output wire[7:0] duan;
	output wire[7:0] wei;
	output wire led;
	output wire[6:0] other;
	
	/* 按键消抖模块 */
	wire share_key;
	wire share_reset;
	Shake_Remove key_remove(clk, key, share_key);
	Shake_Remove reset_remove(clk, reset, share_reset);
	
	/* 分频器:分频到10khz */
	wire clk_10khz;
	Frequency_10khz frequency_10khz(clk, clk_10khz);
	
	/* 分频器:分频到1hz */
	wire clk_1hz;
	Frequency_1hz frequency_1hz(clk_10khz, clk_1hz);
	
	/* 按键计数器 */
	wire[3:0] key_count;
	wire key_overflow;
	Keystroke_Count keystroke_count(share_key, led, share_reset, key_count, key_overflow);
	
	/* 数据筛选模块 */
	wire delay_enable;
	Data_Screening(key_count, delay_enable);
	
	/* 延时5s */
	wire select_control;
	Delay_5s delay_5s(clk_1hz, delay_enable, share_key, select_control);
	
	/* 延时15s */
	wire[3:0] delay_number;
	wire delay_overflow;
	Delay_15s delay_15s(clk_1hz, select_control, share_key, delay_number, delay_overflow);
	
	/* 数据选择模块 */
	wire[3:0] select_out;
	Data_Select data_select(select_control, key_count, delay_number, select_out);
	
	/* 数码管动态显示模块 */
	Dynamic_Display dynamic_display(clk_10khz, select_out, wei, duan);
	
	/* 信号溢出事件 */
	nor nor_inst(led, key_overflow, delay_overflow);
	
	/* 其他的LED默认关闭 */
	assign other = 7'h7f;

endmodule
	