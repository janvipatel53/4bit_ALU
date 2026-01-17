module alu_4bit(
    input  [3:0] A,          // first input
    input  [3:0] B,          // second input
    input  [2:0] sel,        // select line for operation
    output reg [3:0] Y,      // alu output
    output reg carry,        // carry / borrow output
    output reg zero          // zero flag
);

    reg [4:0] temp;          // 5 bit temp to store carry also

    always @(*) begin
        // default values
        Y = 4'b0000;
        carry = 1'b0;
        temp = 5'b00000;

        case(sel)

            3'b000: begin
                // ADD
                temp = A + B;
                Y = temp[3:0];
                carry = temp[4];
            end

            3'b001: begin
                // SUBTRACT (A - B)
                temp = A - B;
                Y = temp[3:0];
                carry = temp[4]; // acts like borrow indicator
            end

            3'b010: begin
                // AND
                Y = A & B;
            end

            3'b011: begin
                // OR
                Y = A | B;
            end

            3'b100: begin
                // XOR
                Y = A ^ B;
            end

            3'b101: begin
                // NOT A
                Y = ~A;
            end

            3'b110: begin
                // LEFT SHIFT A by 1
                Y = A << 1;
            end

            3'b111: begin
                // RIGHT SHIFT A by 1
                Y = A >> 1;
            end

            default: begin
                Y = 4'b0000;
                carry = 1'b0;
            end

        endcase

        // zero flag check
        if(Y == 4'b0000)
            zero = 1'b1;
        else
            zero = 1'b0;

    end

endmodule
