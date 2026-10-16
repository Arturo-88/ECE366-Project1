// Project 1
// Problem 3: Part (a)
// 16-bit Parallel Prefix Adder

// Prefix computation block
module prefix_block(P_high, G_high, P_low, G_low, P_out, G_out);

  input P_high, G_high, P_low, G_low;
  output P_out, G_out;

  wire temp;

  and (P_out, P_high, P_low);
  and (temp, P_high, G_low);
  or (G_out, G_high, temp);

endmodule


// 16-bit Parallel Prefix Adder
module PPA(A, B, Cin, S, Cout);

  input [15:0] A, B;
  input Cin;
  output [15:0] S;
  output Cout;

  wire [15:0] p, g, C;
  wire P_m1, G_m1;
  wire temp_cout;

  // Pre-computation: propagate and generate
  assign p = A | B;
  assign g = A & B;

  // Initial values from Figure 3
  assign P_m1 = 1'b0;
  assign G_m1 = Cin;


  // Prefix Level 1
  wire P_14_13, P_12_11, P_10_9, P_8_7;
  wire P_6_5, P_4_3, P_2_1, P_0_m1;
  wire G_14_13, G_12_11, G_10_9, G_8_7;
  wire G_6_5, G_4_3, G_2_1, G_0_m1;

  prefix_block PB0(p[14], g[14], p[13], g[13], P_14_13, G_14_13);
  prefix_block PB1(p[12], g[12], p[11], g[11], P_12_11, G_12_11);
  prefix_block PB2(p[10], g[10], p[9], g[9], P_10_9, G_10_9);
  prefix_block PB3(p[8], g[8], p[7], g[7], P_8_7, G_8_7);
  prefix_block PB4(p[6], g[6], p[5], g[5], P_6_5, G_6_5);
  prefix_block PB5(p[4], g[4], p[3], g[3], P_4_3, G_4_3);
  prefix_block PB6(p[2], g[2], p[1], g[1], P_2_1, G_2_1);
  prefix_block PB7(p[0], g[0], P_m1, G_m1, P_0_m1, G_0_m1);


  // Prefix Level 2
  wire P_14_11, P_13_11, P_10_7, P_9_7;
  wire P_6_3, P_5_3, P_2_m1, P_1_m1;
  wire G_14_11, G_13_11, G_10_7, G_9_7;
  wire G_6_3, G_5_3, G_2_m1, G_1_m1;

  prefix_block PB8(P_14_13, G_14_13, P_12_11, G_12_11, P_14_11, G_14_11);
  prefix_block PB9(p[13], g[13], P_12_11, G_12_11, P_13_11, G_13_11);
  prefix_block PB10(P_10_9, G_10_9, P_8_7, G_8_7, P_10_7, G_10_7);
  prefix_block PB11(p[9], g[9], P_8_7, G_8_7, P_9_7, G_9_7);
  prefix_block PB12(P_6_5, G_6_5, P_4_3, G_4_3, P_6_3, G_6_3);
  prefix_block PB13(p[5], g[5], P_4_3, G_4_3, P_5_3, G_5_3);
  prefix_block PB14(P_2_1, G_2_1, P_0_m1, G_0_m1, P_2_m1, G_2_m1);
  prefix_block PB15(p[1], g[1], P_0_m1, G_0_m1, P_1_m1, G_1_m1);


  // Prefix Level 3
  wire P_14_7, P_13_7, P_12_7, P_11_7;
  wire P_6_m1, P_5_m1, P_4_m1, P_3_m1;
  wire G_14_7, G_13_7, G_12_7, G_11_7;
  wire G_6_m1, G_5_m1, G_4_m1, G_3_m1;

  prefix_block PB16(P_14_11, G_14_11, P_10_7, G_10_7, P_14_7, G_14_7);
  prefix_block PB17(P_13_11, G_13_11, P_10_7, G_10_7, P_13_7, G_13_7);
  prefix_block PB18(P_12_11, G_12_11, P_10_7, G_10_7, P_12_7, G_12_7);
  prefix_block PB19(p[11], g[11], P_10_7, G_10_7, P_11_7, G_11_7);
  prefix_block PB20(P_6_3, G_6_3, P_2_m1, G_2_m1, P_6_m1, G_6_m1);
  prefix_block PB21(P_5_3, G_5_3, P_2_m1, G_2_m1, P_5_m1, G_5_m1);
  prefix_block PB22(P_4_3, G_4_3, P_2_m1, G_2_m1, P_4_m1, G_4_m1);
  prefix_block PB23(p[3], g[3], P_2_m1, G_2_m1, P_3_m1, G_3_m1);


  // Prefix Level 4
  wire P_14_m1, P_13_m1, P_12_m1, P_11_m1;
  wire P_10_m1, P_9_m1, P_8_m1, P_7_m1;
  wire G_14_m1, G_13_m1, G_12_m1, G_11_m1;
  wire G_10_m1, G_9_m1, G_8_m1, G_7_m1;

  prefix_block PB24(P_14_7, G_14_7, P_6_m1, G_6_m1, P_14_m1, G_14_m1);
  prefix_block PB25(P_13_7, G_13_7, P_6_m1, G_6_m1, P_13_m1, G_13_m1);
  prefix_block PB26(P_12_7, G_12_7, P_6_m1, G_6_m1, P_12_m1, G_12_m1);
  prefix_block PB27(P_11_7, G_11_7, P_6_m1, G_6_m1, P_11_m1, G_11_m1);
  prefix_block PB28(P_10_7, G_10_7, P_6_m1, G_6_m1, P_10_m1, G_10_m1);
  prefix_block PB29(P_9_7, G_9_7, P_6_m1, G_6_m1, P_9_m1, G_9_m1);
  prefix_block PB30(P_8_7, G_8_7, P_6_m1, G_6_m1, P_8_m1, G_8_m1);
  prefix_block PB31(p[7], g[7], P_6_m1, G_6_m1, P_7_m1, G_7_m1);


  // Post-computation: carry inputs
  assign C[0] = Cin;
  assign C[1] = G_0_m1;
  assign C[2] = G_1_m1;
  assign C[3] = G_2_m1;
  assign C[4] = G_3_m1;
  assign C[5] = G_4_m1;
  assign C[6] = G_5_m1;
  assign C[7] = G_6_m1;
  assign C[8] = G_7_m1;
  assign C[9] = G_8_m1;
  assign C[10] = G_9_m1;
  assign C[11] = G_10_m1;
  assign C[12] = G_11_m1;
  assign C[13] = G_12_m1;
  assign C[14] = G_13_m1;
  assign C[15] = G_14_m1;

  // Calculate sum
  assign S = A ^ B ^ C;

  // Final carry-out
  and (temp_cout, p[15], G_14_m1);
  or (Cout, g[15], temp_cout);

endmodule
