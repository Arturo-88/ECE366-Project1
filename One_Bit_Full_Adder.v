//****************
//Arturo made this
//****************

module one_bit_full_adder(A, B, Cin, S, Cout);

input A, B, Cin;
output S, Cout;

//s = A ^ B; 

//s = s ^ c;
  
//Cout = A && B + A && Cin + B && Cin

assign S = A ^ B ^ Cin;
assign Cout = (A & B) | (A & Cin) | (B & Cin);

endmodule
