//testing for 1 unsigned addition, 1 unsigned subtraction
//testing for 1 signed addition involving a neg operand
//testing for 1 signed subtract involving a neg operand and one case that has Carry-out


module tb_four_bit_RCA_RCS;
  
  
  //inputs
  reg [3:0] A, B; 
  reg Cin; 
  
  //out puts the tb will read them
  wire [3:0] S; 
  wire Cout; 
  
  //connects the ports
  four_bit_RCA_RCS U0(
    .A    (A),
    .B    (B),
    .Cin  (Cin),
    .S    (S),
    .Cout (Cout)
  );
  
  initial begin
    $dumpfile ("counter.vcd"); //used for the file to note that the simulator will store the varform into here 
    $dumpvars;
  
    
    
    //testing for 1 unsigned addition
    
    A = 4'b0011;
    B = 4'b0101;
    Cin = 0; //addition
    
    #8;
    
    $display("I want to show that 3 + 5 is correct");
    $display("this gives us S = %b and Cout = %b", S, Cout);
    $display("S = 1000 is binary for 8 so it does work");
    
    
    
    //testing for 1 unsigned subtraction
    
    A = 4'b0111;
    B = 4'b0101;
    Cin = 1;//subtraction
    
    #8;
    
    $display("I want to show that 7 - 5 is correct");
    $display("this gives us S = %b and Cout = %b", S, Cout);
    $display("S = 0010 is binary for 2 so it does work");
    
    
    //testing for 1 signed addition involving a neg operand
    
    A = 4'b1001;
    B = 4'b0110;
    Cin = 0;
    
    #8;
    
    $display("I want to show that -7 + 6 is correct");
    $display("this gives us S = %b and Cout = %b", S, Cout);
    $display("S = 1111 is binary for -1 so it does work");
    
    
    
    //1 case that has Carry-out
    
    A = 4'b1100;
    B = 4'b0100;
    Cin = 0;
    
    #8;
    
    $display("testing 12 + 4 is Carry");
    $display("this gives us S = %b and Cout = %b", S, Cout);
    $display("S = 0000 and C out is 1 the full thing would have been 10000");
    
    
    
    
    
    //ending code
    $finish;
    
  end 
  
endmodule

