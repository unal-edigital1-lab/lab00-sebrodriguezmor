`timescale 1ns / 1ps

module sum4b_TB;

  // Inputs
  reg [3:0] A;
  reg [3:0] B;

  // Outputs
  wire co;
  wire [3:0] S;

  // Instantiate the Unit Under Test (UUT)
  sum4b uut (
    .xi(A), 
    .yi(B), 
    .co(co), 
    .zi(S)
  );

  
  initial begin
  

  // Initialize Inputs
    A=0;
	 for (B = 0; B < 16; B = B + 1) begin
      if (B==0)
        A=A+1;
      #2 ;
		$display("El valor de %d + %d = %d",A, B,S) ;
    end
	
  end      

  initial begin: TEST_CASE
     $dumpfile("sum4b_TB.vcd");
     $dumpvars(-1, uut);
     #(200) $finish;
   end


endmodule

