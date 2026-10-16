
module KS_black(P_high, G_high, P_low, G_low, P_out, G_out);
  input P_high, G_high, P_low, G_low;
  output P_out, G_out;
  wire temp;
  and (P_out, P_high, P_low);
  and (temp, P_high, G_low);
  or  (G_out, G_high, temp);
endmodule

module KS_gray(P_high, G_high, G_low, G_out);
  input P_high, G_high, G_low;
  output G_out;
  wire temp;
  and (temp, P_high, G_low);
  or  (G_out, G_high, temp);
endmodule

module KS(A, B, Cin, S, Cout);
  input [15:0] A, B;
  input Cin;
  output [15:0] S;
  output Cout;

  wire [15:0] p, g, C;
  wire [15:0] p0, g0;
  wire [15:0] p1, g1;
  wire [15:0] p2, g2;
  wire [15:0] p3, g3;
  wire [15:0] p4, g4;
  wire final_temp;

  // Bit-level pre-computation (XOR propagate for Kogge-Stone).
  assign p = A ^ B;
  assign g = A & B;

  // Index 0 is the special -1 input: P(-1) = 0, G(-1) = Cin.
  // Indices 1..15 correspond to operand bits 0..14.
  assign p0[0] = 1'b0;
  assign g0[0] = Cin;
  assign p0[15:1] = p[14:0];
  assign g0[15:1] = g[14:0];

  // Prefix stage 1: combine positions 1 apart.
  assign p1[0:0] = p0[0:0];
  assign g1[0:0] = g0[0:0];
  KS_gray GR1_1(p0[1], g0[1], g0[0], g1[1]);
  assign p1[1] = 1'b0;
  KS_black BL1_2(p0[2], g0[2], p0[1], g0[1], p1[2], g1[2]);
  KS_black BL1_3(p0[3], g0[3], p0[2], g0[2], p1[3], g1[3]);
  KS_black BL1_4(p0[4], g0[4], p0[3], g0[3], p1[4], g1[4]);
  KS_black BL1_5(p0[5], g0[5], p0[4], g0[4], p1[5], g1[5]);
  KS_black BL1_6(p0[6], g0[6], p0[5], g0[5], p1[6], g1[6]);
  KS_black BL1_7(p0[7], g0[7], p0[6], g0[6], p1[7], g1[7]);
  KS_black BL1_8(p0[8], g0[8], p0[7], g0[7], p1[8], g1[8]);
  KS_black BL1_9(p0[9], g0[9], p0[8], g0[8], p1[9], g1[9]);
  KS_black BL1_10(p0[10], g0[10], p0[9], g0[9], p1[10], g1[10]);
  KS_black BL1_11(p0[11], g0[11], p0[10], g0[10], p1[11], g1[11]);
  KS_black BL1_12(p0[12], g0[12], p0[11], g0[11], p1[12], g1[12]);
  KS_black BL1_13(p0[13], g0[13], p0[12], g0[12], p1[13], g1[13]);
  KS_black BL1_14(p0[14], g0[14], p0[13], g0[13], p1[14], g1[14]);
  KS_black BL1_15(p0[15], g0[15], p0[14], g0[14], p1[15], g1[15]);

  // Prefix stage 2: combine positions 2 apart.
  assign p2[1:0] = p1[1:0];
  assign g2[1:0] = g1[1:0];
  KS_gray GR2_2(p1[2], g1[2], g1[0], g2[2]);
  assign p2[2] = 1'b0;
  KS_gray GR2_3(p1[3], g1[3], g1[1], g2[3]);
  assign p2[3] = 1'b0;
  KS_black BL2_4(p1[4], g1[4], p1[2], g1[2], p2[4], g2[4]);
  KS_black BL2_5(p1[5], g1[5], p1[3], g1[3], p2[5], g2[5]);
  KS_black BL2_6(p1[6], g1[6], p1[4], g1[4], p2[6], g2[6]);
  KS_black BL2_7(p1[7], g1[7], p1[5], g1[5], p2[7], g2[7]);
  KS_black BL2_8(p1[8], g1[8], p1[6], g1[6], p2[8], g2[8]);
  KS_black BL2_9(p1[9], g1[9], p1[7], g1[7], p2[9], g2[9]);
  KS_black BL2_10(p1[10], g1[10], p1[8], g1[8], p2[10], g2[10]);
  KS_black BL2_11(p1[11], g1[11], p1[9], g1[9], p2[11], g2[11]);
  KS_black BL2_12(p1[12], g1[12], p1[10], g1[10], p2[12], g2[12]);
  KS_black BL2_13(p1[13], g1[13], p1[11], g1[11], p2[13], g2[13]);
  KS_black BL2_14(p1[14], g1[14], p1[12], g1[12], p2[14], g2[14]);
  KS_black BL2_15(p1[15], g1[15], p1[13], g1[13], p2[15], g2[15]);

  // Prefix stage 3: combine positions 4 apart.
  assign p3[3:0] = p2[3:0];
  assign g3[3:0] = g2[3:0];
  KS_gray GR3_4(p2[4], g2[4], g2[0], g3[4]);
  assign p3[4] = 1'b0;
  KS_gray GR3_5(p2[5], g2[5], g2[1], g3[5]);
  assign p3[5] = 1'b0;
  KS_gray GR3_6(p2[6], g2[6], g2[2], g3[6]);
  assign p3[6] = 1'b0;
  KS_gray GR3_7(p2[7], g2[7], g2[3], g3[7]);
  assign p3[7] = 1'b0;
  KS_black BL3_8(p2[8], g2[8], p2[4], g2[4], p3[8], g3[8]);
  KS_black BL3_9(p2[9], g2[9], p2[5], g2[5], p3[9], g3[9]);
  KS_black BL3_10(p2[10], g2[10], p2[6], g2[6], p3[10], g3[10]);
  KS_black BL3_11(p2[11], g2[11], p2[7], g2[7], p3[11], g3[11]);
  KS_black BL3_12(p2[12], g2[12], p2[8], g2[8], p3[12], g3[12]);
  KS_black BL3_13(p2[13], g2[13], p2[9], g2[9], p3[13], g3[13]);
  KS_black BL3_14(p2[14], g2[14], p2[10], g2[10], p3[14], g3[14]);
  KS_black BL3_15(p2[15], g2[15], p2[11], g2[11], p3[15], g3[15]);

  // Prefix stage 4: combine positions 8 apart.
  assign p4[7:0] = p3[7:0];
  assign g4[7:0] = g3[7:0];
  KS_gray GR4_8(p3[8], g3[8], g3[0], g4[8]);
  assign p4[8] = 1'b0;
  KS_gray GR4_9(p3[9], g3[9], g3[1], g4[9]);
  assign p4[9] = 1'b0;
  KS_gray GR4_10(p3[10], g3[10], g3[2], g4[10]);
  assign p4[10] = 1'b0;
  KS_gray GR4_11(p3[11], g3[11], g3[3], g4[11]);
  assign p4[11] = 1'b0;
  KS_gray GR4_12(p3[12], g3[12], g3[4], g4[12]);
  assign p4[12] = 1'b0;
  KS_gray GR4_13(p3[13], g3[13], g3[5], g4[13]);
  assign p4[13] = 1'b0;
  KS_gray GR4_14(p3[14], g3[14], g3[6], g4[14]);
  assign p4[14] = 1'b0;
  KS_gray GR4_15(p3[15], g3[15], g3[7], g4[15]);
  assign p4[15] = 1'b0;

  // Sum bit i uses the carry produced by bits 0 through i-1.
  assign C[0] = Cin;
  assign C[15:1] = g4[15:1];
  assign S = p ^ C;

  // One more 2-input carry step for the most significant bit.
  and (final_temp, p[15], C[15]);
  or  (Cout, g[15], final_temp);
endmodule

