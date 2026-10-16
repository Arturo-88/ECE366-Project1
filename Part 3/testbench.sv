// ECE 366 - Debjit Pal
// Project 1 Part 3

  module tb_PPA;
    
  	reg[15:0] A, B; 
  	reg Cin;
  
    wire[15:0] S; 
  	wire Cout;
  
    PPA U2(
      .A    (A),
      .B    (B),
      .Cin  (Cin),
      .S    (S),
      .Cout (Cout)
    );

    initial begin
      $dumpfile ("project1part3.vcd"); // used for the file to note that the simulator will store the varform into here 
      $dumpvars;

      A_PPA = 16'b0000000000000111;
      B_PPA = 16'b0000000000001000;
      Cin_PPA = 0;

      #8; 

      $display("PPA: Testing 7 + 8");
      $display("A = %b, B = %b, Cin = %b", A, B, Cin);
      $display("S = %b, Cout = %b", S, Cout);
      $display("Expected S = 0000000000001111, Cout = 0");
      //it works


      // Test 2 for PPA carry propagation through all 16 bits

      A_PPA = 16'b1111111111111111;
      B_PPA = 16'b0000000000000001;
      Cin_PPA = 0;

      #8; 

      $display("PPA Testing: 65535 + 1");
      $display("A = %b, B = %b, Cin = %b", A, B, Cin);
      $display("S = %b, Cout = %b", S, Count);
      $display("Expected S = 0000000000000000, Cout = 1");

      //TEST 3 for PPA addition with carry in

      A_PPA = 16'b0000000000000011;
      B_PPA = 16'b0000000000000101;
      Cin_PPA = 1;

      #8;

      $display("PPA Testing: 3 + 5 + 1");
      $display("A = %b, B = %b, Cin = %b", A, B, Cin);
      $display("S = %b, Cout = %b", S, Cout);
      $display("Expected S = 0000000000001001, Cout = 0");

      // TEST 4 for PPA carry in propagates through all 16 bits

      A_PPA = 16'b1111111111111111;
      B_PPA = 16'b0000000000000000;
      Cin_PPA = 1;

      #8; 

      $display("PPA Testing: 65535 + 0 + 1");
      $display("A = %b, B = %b, Cin = %b", A, B, Cin);
      $display("S = %b, Cout = %b", S_PPA, Cout_PPA);
      $display("Expected S = 0000000000000000, Cout = 1");

      // Test 5 Unsigned subtraction 20 - 7 = 13

      A = 16'b0000000000010100;
      B = ~16'b0000000000000111;
      Cin = 1;

      #8; 

      $display("PPA Testing: 20 - 7 = 13");
      $display("A = %b, B = %b, Cin = %b", A, B, Cin);
      $display("S = %b, Cout = %b", S, Cout);
      $display("Expected S = 0000000000001101, Cout = 1");




      // Test 6 signed addition 10 + -2 = 8 
      A_PPA = 16'b0000000000001010;
      B_PPA = 16'b1111111111111110;
      Cin_PPA = 0;

      #8;

      $display("PPA Testing: 10 + -2 = 8 ");
      $display("A = %b, B = %b, Cin = %b", A, B, Cin);
      $display("S = %b, Cout = %b", S, Cout);
      $display("Expected S = 0000000000001000, Cout = 1");

      $finish;
      
    end
    
 endmodule