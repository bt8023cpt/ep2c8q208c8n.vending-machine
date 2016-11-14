/**
 * @Description 数码管动态显示模块
 * @input display_clk 数码管扫描时钟
 * @input display_num 数码要显示的数据值
 * @output display_wei 数码管位选
 * @output display_duan 数码管段选
 */
module Dynamic_Display(display_clk, display_num, display_wei, display_duan);
	input wire display_clk;
	input wire[3:0] display_num;
	output reg[7:0] display_wei;
	output reg[7:0] display_duan;
	
	/*译码函数:将数值转化为对应的段选值*/
	function[7:0] code; 
		input[3:0] num;
		case(num)
			4'h0: code = 8'hc0; // 显示"0"
			4'h1: code = 8'hf9; // 显示"1"
			4'h2: code = 8'ha4; // 显示"2"
			4'h3: code = 8'hb0; // 显示"3"
			4'h4: code = 8'h99; // 显示"4"
			4'h5: code = 8'h92; // 显示"5"
			4'h6: code = 8'h82; // 显示"6"
			4'h7: code = 8'hf8; // 显示"7"
			4'h8: code = 8'h80; // 显示"8"
			4'h9: code = 8'h90; // 显示"9"
			4'hf: code = 8'hff; // 显示" "
			default: code = 8'h40; // 显示"-"
		endcase
	endfunction
	
	reg wei_count;
	
	always @(posedge display_clk)
		begin 
			wei_count <= wei_count + 1'b1;
			case(wei_count)
				1'b0: begin display_wei = 8'b11111110; display_duan = code(display_num % 10); end
				1'b1: begin display_wei = 8'b11111101; display_duan = code(display_num / 10); end
			endcase
		end

endmodule 