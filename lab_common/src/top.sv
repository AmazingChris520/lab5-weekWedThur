module top (
    input  wire CLK,

    output wire LCD_CLK,
    output wire LCD_DEN,

    output wire [4:0] LCD_R,
    output wire [5:0] LCD_G,
    output wire [4:0] LCD_B
);

    localparam H_ACTIVE = 480;
    localparam H_TOTAL  = 525;

    localparam V_ACTIVE = 272;
    localparam V_TOTAL  = 285;

    reg [9:0] x = 10'd0;
    reg [8:0] y = 9'd0;

    assign LCD_CLK = CLK;

    always @(posedge CLK) begin
        if (x == H_TOTAL - 1) begin
            x <= 10'd0;

            if (y == V_TOTAL - 1)
                y <= 9'd0;
            else
                y <= y + 9'd1;

        end else begin
            x <= x + 10'd1;
        end
    end

    wire active;
    assign active = (x < H_ACTIVE) && (y < V_ACTIVE);

    assign LCD_DEN = active;

    assign LCD_R = active ? 5'b11111  : 5'b00000;
    assign LCD_G = active ? 6'b111111 : 6'b000000;
    assign LCD_B = active ? 5'b11111  : 5'b00000;

endmodule