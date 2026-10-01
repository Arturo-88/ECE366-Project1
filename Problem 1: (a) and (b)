// Project 1
// Problem 1: Part (a)

module one_bit_FA_Behav(A, B, Cin, S, Cout);
  // Declare Inputs
  input A;
  input B;
  input Cin;
  // Declare Outputs
  output S;
  output Cout;
  
  assign S = A || B || Cin;	// Logic for S-bit
  assign Cout = (A && B)||(B && Cin)||(Cin && A); // Logic for Cout-bit
  
endmodule

// Problem 1: Part (b)

module one_bit_FA_Struct(A, B, Cin, S, Cout);
  // Declare Inputs
  input A;
  input B;
  input Cin;
  // Declare Outputs
  output S;
  output Cout;
  // Declare temp variables
  wire temp1;
  wire temp2;
  wire temp3;
  wire temp4;
  
  xor XOR1(temp1, A, B);
  xor XOR2(S, temp1, Cin); // S = (A Xor B) Xor Cin
  
  and AND1(temp2, A, B);
  and AND2(temp3, B, Cin);
  and AND3(temp4, Cin, A);
  or OR1 (Cout, temp2, temp3, temp4); // S = (AB)+(BCin)+(ACin)
  
endmodule
