// Created : 9:31:38, Tue Jun 21, 2016 : Sanjay Rai

`timescale 1 ps / 1 ps
module GPIO_LED_MOD (
  input PL_CLK333,
  output [3:0] GPIO_LED
);

  wire PL_CLK333;
(*mark_debug = "true" *)  wire pl_reset_n;
(*mark_debug = "true" *)  reg [29:0] pl_counter = 30'd0;


always @(posedge PL_CLK333)
    pl_counter <= pl_counter + 16'd1;

assign GPIO_LED[3:0] = pl_counter[29:26];


endmodule
