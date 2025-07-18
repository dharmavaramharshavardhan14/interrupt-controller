
module interrupt_controller (
    input clk,
    input reset,
    input [3:0] irq,        // irq[0] = highest priority
    output reg [1:0] int_id,
    output reg int_valid
);

    always @(posedge clk) begin
        if (reset) begin
            int_id <= 2'b00;
            int_valid <= 0;
        end else begin
            casex (irq)
                4'b1xxx: begin int_id <= 2'b00; int_valid <= 1; end
                4'b01xx: begin int_id <= 2'b01; int_valid <= 1; end
                4'b001x: begin int_id <= 2'b10; int_valid <= 1; end
                4'b0001: begin int_id <= 2'b11; int_valid <= 1; end
                default: begin int_id <= 2'b00; int_valid <= 0; end
            endcase
        end
    end
endmodule
