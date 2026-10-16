// ECE 366 - Debjit Pal
// Project 1 Part 2

module tb_CLA;
  
  // Inputs
  reg [31:0] A, B; 
  reg Cin; 
  
  // Outputs
  wire [31:0] S;
  wire Cout; 
  
  // Assign a port
  CLA U0(
    .A    (A),
    .B    (B),
    .Cin  (Cin),
    .S    (S),
    .Cout (Cout)
  );
  
  initial begin
    $dumpfile ("dumpfile.vcd"); // used for the file to note that the simulator will store the varform into here 
    $dumpvars;
    
    //  Test for carry propagation for CLA
    A = 32'b00000000000000001111111111111111;
    B = 32'b00000000000000000000000000000001;
    Cin = 0;

    #8;

    $display("testing for carry propagation across the blocks for CLA");
    $display("A = %b, B = %b", A, B);
    $display("S = %b, Cout = %b", S, Cout);
    
    $finish;
  end 
  
endmodule
