module tb_KS;
  reg [15:0] A, B;
  reg Cin;
  wire [15:0] S;
  wire Cout;

  KS U0(A, B, Cin, S, Cout);

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_KS);

    A = 16'h0003; B = 16'h0005; Cin = 0;
    #8;
    $display("Test 1: S=%h Cout=%b (expected 0008 0)", S, Cout);

    A = 16'h00FF; B = 16'h0001; Cin = 0;
    #8;
    $display("Test 2: S=%h Cout=%b (expected 0100 0)", S, Cout);

    A = 16'hFFFF; B = 16'h0001; Cin = 0;
    #8;
    $display("Test 3: S=%h Cout=%b (expected 0000 1)", S, Cout);

    A = 16'h0001; B = 16'h0001; Cin = 1;
    #8;
    $display("Test 4: S=%h Cout=%b (expected 0003 0)", S, Cout);

    $finish;
  end
endmodule
