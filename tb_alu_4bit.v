module tb_alu_4bit;

    reg  [3:0] A;
    reg  [3:0] B;
    reg  [2:0] sel;

    wire [3:0] Y;
    wire carry;
    wire zero;

    // DUT connection
    alu_4bit dut(
        .A(A),
        .B(B),
        .sel(sel),
        .Y(Y),
        .carry(carry),
        .zero(zero)
    );

    // task to print values in simple table format
    task show;
        begin
            $display("A=%b B=%b sel=%b | Y=%b carry=%b zero=%b", A, B, sel, Y, carry, zero);
        end
    endtask

    initial begin

        // waveform file for gtkwave
        $dumpfile("alu_4bit.vcd");
        $dumpvars(0, tb_alu_4bit);

        // values
        A = 4'b0101;  // 5
        B = 4'b0011;  // 3

        $display("4-bit ALU Output");
        $display("--------------------------");

        // ADD
        sel = 3'b000; #10; show();

        // SUB
        sel = 3'b001; #10; show();

        // AND
        sel = 3'b010; #10; show();

        // OR
        sel = 3'b011; #10; show();

        // XOR
        sel = 3'b100; #10; show();

        // NOT A
        sel = 3'b101; #10; show();

        // LEFT SHIFT
        sel = 3'b110; #10; show();

        // RIGHT SHIFT
        sel = 3'b111; #10; show();

        // change inputs and test again
        A = 4'b0000;
        B = 4'b0000;

        sel = 3'b000; #10; show();  // should give zero flag = 1

        #10;
        $finish;

    end

endmodule
