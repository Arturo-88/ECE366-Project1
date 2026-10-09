
// Project 1
// Problem 2: Part (a)
// 32-bit Carry Lookahead Adder


// 1-bit Structural Full Adder
module one_bit_FA_Struct(A, B, Cin, S, Cout);

  input A, B, Cin;
  output S, Cout;

  wire temp1, temp2, temp3, temp4, temp5;

  xor XOR1(temp1, A, B);
  xor XOR2(S, temp1, Cin);

  and AND1(temp2, A, B);
  and AND2(temp3, B, Cin);
  and AND3(temp4, Cin, A);

  or OR1(temp5, temp2, temp3);
  or OR2(Cout, temp5, temp4);

endmodule


// 4-bit Ripple Carry Adder
module four_bit_RCA(A, B, Cin, S, Cout);

  input [3:0] A, B;
  input Cin;
  output [3:0] S;
  output Cout;

  wire C1, C2, C3;

  one_bit_FA_Struct FA0(A[0], B[0], Cin, S[0], C1);
  one_bit_FA_Struct FA1(A[1], B[1], C1, S[1], C2);
  one_bit_FA_Struct FA2(A[2], B[2], C2, S[2], C3);
  one_bit_FA_Struct FA3(A[3], B[3], C3, S[3], Cout);

endmodule


// 4-bit CLA Block
module four_bit_CLA(A, B, Cin, S, Cout);

  input [3:0] A, B;
  input Cin;
  output [3:0] S;
  output Cout;

  wire [3:0] P, G;
  wire p01, p23, Pblock;
  wire g10, g210, Gblock;
  wire t0, t1, t2, t3;
  wire RCA_Cout;

  // Calculate sum using 4-bit RCA
  four_bit_RCA RCA(A, B, Cin, S, RCA_Cout);

  // Carry propagate
  or (P[0], A[0], B[0]);
  or (P[1], A[1], B[1]);
  or (P[2], A[2], B[2]);
  or (P[3], A[3], B[3]);

  // Carry generate
  and (G[0], A[0], B[0]);
  and (G[1], A[1], B[1]);
  and (G[2], A[2], B[2]);
  and (G[3], A[3], B[3]);

  // Block propagate
  and (p01, P[0], P[1]);
  and (p23, P[2], P[3]);
  and (Pblock, p01, p23);

  // Block generate
  and (t0, P[1], G[0]);
  or (g10, G[1], t0);

  and (t1, P[2], g10);
  or (g210, G[2], t1);

  and (t2, P[3], g210);
  or (Gblock, G[3], t2);

  // Carry output
  and (t3, Pblock, Cin);
  or (Cout, Gblock, t3);

endmodule


// 32-bit Carry Lookahead Adder
module CLA(A, B, Cin, S, Cout);

  input [31:0] A, B;
  input Cin;
  output [31:0] S;
  output Cout;

  wire C4, C8, C12, C16;
  wire C20, C24, C28;

  // Eight 4-bit CLA Blocks

  four_bit_CLA CLA0(
    A[3:0], B[3:0], Cin, S[3:0], C4
  );

  four_bit_CLA CLA1(
    A[7:4], B[7:4], C4, S[7:4], C8
  );

  four_bit_CLA CLA2(
    A[11:8], B[11:8], C8, S[11:8], C12
  );

  four_bit_CLA CLA3(
    A[15:12], B[15:12], C12, S[15:12], C16
  );

  four_bit_CLA CLA4(
    A[19:16], B[19:16], C16, S[19:16], C20
  );

  four_bit_CLA CLA5(
    A[23:20], B[23:20], C20, S[23:20], C24
  );

  four_bit_CLA CLA6(
    A[27:24], B[27:24], C24, S[27:24], C28
  );

  four_bit_CLA CLA7(
    A[31:28], B[31:28], C28, S[31:28], Cout
  );

endmodule
