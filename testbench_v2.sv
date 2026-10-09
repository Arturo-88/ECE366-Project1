//testing for 1 unsigned addition, 1 unsigned subtraction
//testing for 1 signed addition involving a neg operand
//testing for 1 signed subtract involving a neg operand and one case that has Carry-out


module tb_four_bit_RCA_RCS_plus_CLA;
  
  //inputs
  reg [3:0] A_RCA, B_RCA; 
  reg Cin_RCA;
  
  reg [31:0] A_CLA, B_CLA; 
  reg Cin_CLA; 
  
  //out puts the tb will read them
  wire [3:0] S_RCA; 
  wire Cout_RCA; 
  
  wire [31:0] S_CLA; 
  wire Cout_CLA; 
  
  //connects the ports
  four_bit_RCA_RCS U0(
    .A    (A_RCA),
    .B    (B_RCA),
    .Cin  (Cin_RCA),
    .S    (S_RCA),
    .Cout (Cout_RCA)
  );
  
  CLA U1(
    .A		(A_CLA),
    .B		(B_CLA),
    .Cin	(Cin_CLA),
    .S		(S_CLA),
    .Cout	(Cout_CLA)
  );
  
  initial begin
    $dumpfile ("project1.vcd"); // used for the file to note that the simulator will store the varform into here 
    $dumpvars;
    
    //testing for 1 unsigned addition
    
    A_RCA = 4'b0011;
    B_RCA = 4'b0101;
    Cin_RCA = 0; //addition
    
    #8;
    
    $display("I want to show that 3 + 5 is correct");
    $display("this gives us S = %b and Cout = %b", S_RCA, Cout_RCA);
    $display("S = 1000 is binary for 8 so it does work");
    
    
    
    //testing for 1 unsigned subtraction
    
    A_RCA = 4'b0111;
    B_RCA = 4'b0101;
    Cin_RCA = 1;//subtraction
    
    #8;
    
    $display("I want to show that 7 - 5 is correct");
    $display("this gives us S = %b and Cout = %b", S_RCA, Cout_RCA);
    $display("S = 0010 is binary for 2 so it does work");
    
    
    //testing for 1 signed addition involving a neg operand
    
    A_RCA = 4'b1001;
    B_RCA = 4'b0110;
    Cin_RCA = 0;
    
    #8;
    
    $display("I want to show that -7 + 6 is correct");
    $display("this gives us S = %b and Cout = %b", S_RCA, Cout_RCA);
    $display("S = 1111 is binary for -1 so it does work");
    
    
    
    //1 case that has Carry-out
    
    A_RCA = 4'b1100;
    B_RCA = 4'b0100;
    Cin_RCA = 0;
    
    #8;
    
    $display("testing 12 + 4 is Carry");
    $display("this gives us S = %b and Cout = %b", S_RCA, Cout_RCA);
    $display("S = 0000 and C out is 1 the full thing would have been 10000");
    
    
    //  test for carry propagation for CLA
    A_CLA = 32'b00000000000000001111111111111111;
    B_CLA = 32'b00000000000000000000000000000001;
    Cin_CLA = 0;

    #8;

    $display("testing for carry propagation across the blocks for CLA");
    $display("A = %b, B = %b", A_CLA, B_CLA);
    $display("S = %b, Cout = %b", S_CLA, Cout_CLA);
    
    //ending code
    $finish;
    
  end 
  
endmodule