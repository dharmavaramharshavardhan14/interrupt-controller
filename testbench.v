
module testbench;
    reg clk, reset;
    reg [3:0] irq;
    wire [1:0] int_id;
    wire int_valid;

    interrupt_controller uut (
        .clk(clk),
        .reset(reset),
        .irq(irq),
        .int_id(int_id),
        .int_valid(int_valid)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);

        clk = 0; reset = 1; irq = 4'b0000;
        #10 reset = 0;

        #10 irq = 4'b0001; // IRQ3
        #10 irq = 4'b0010; // IRQ2
        #10 irq = 4'b0100; // IRQ1
        #10 irq = 4'b1000; // IRQ0 (highest)
        #10 irq = 4'b1100; // IRQ0 and IRQ1 → IRQ0 wins
        #10 irq = 4'b0000;

        #20 $finish;
    end
endmodule
