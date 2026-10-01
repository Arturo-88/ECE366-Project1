// Project 1
// Problem 1: Part (c) and (d)

module four_bit_RCA_RCS(A, B, Cin, S, Cout);
  // Declare Inputs
  input [3:0] A, B;
  input Cin;
  // Declare Outputs
  output [3:0] S;
  output Cout;
  // Declare temp variables
  wire C1, C2, C3;
  wire [3:0] Btemp;
  
  // If we are subtracting, all the values of B should be inverted
  // If Cin is 1, we invert B, but if not, we don't change B
  genvar i;
  for (i = 0; i < 4; i = i + 1) begin
    assign Btemp[i] = B[i] ^ Cin;	// This automatically masks the bit off or on
  end
  // If Cin was 0, we are adding, and Btemp is the same as B
  // If Cin was 1, we are subtracting, and Btemp is NOT(B)
  
  // Use same logic from 1Bit Adder to add bit-by-bit
  assign S[0] = A[0] || Btemp[0] || Cin;	// Cin is either 1 or 0
  assign C1 = (A[0] && Btemp[0])||(Btemp[0] && Cin)||(Cin && A[0]);
  
  assign S[1] = A[1] || Btemp[1] || C1;
  assign C2 = (A[1] && Btemp[1])||(Btemp[1] && C1)||(C1 && A[1]);
  
  assign S[2] = A[2] || Btemp[2] || C2;
  assign C3 = (A[2] && Btemp[2])||(Btemp[2] && C2)||(C2 && A[2]);
  
  assign S[3] = A[3] || Btemp[3] || C3;
  assign Cout = (A[3] && Btemp[3])||(Btemp[3] && C3)||(C3 && A[3]);
  
endmodule
