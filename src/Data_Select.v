/**
 * @Description 数据选择模块：选择是投币值还是倒计时的数据
 * @input select_control 选择控制位
 * @input select_a 数据a
 * @input select_b 数据b
 * @output select_out 选择输出
 */
module Data_Select(select_control, select_a, select_b, select_out);
    input wire select_control;
    input wire[3:0] select_a;
    input wire[3:0] select_b;
    output wire[3:0] select_out;

    assign select_out = select_control ? select_b : select_a;

endmodule 