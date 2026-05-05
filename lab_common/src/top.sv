module top
(
    input  CLK,            // 25 MHz from P6
    output LCD_CLK,        
    output LCD_DEN,        
    output [4:0] LCD_R,
    output [5:0] LCD_G,
    output [4:0] LCD_B
);

    assign LCD_CLK = CLK;

    // timing
    localparam H_ACTIVE = 10'd480;
    localparam H_TOTAL  = 10'd525;
    localparam V_ACTIVE = 10'd272;
    localparam V_TOTAL  = 10'd285;

    
    reg [9:0] x = 0; // 0-524
    reg [9:0] y = 0;// 0-284

    always @(posedge CLK) begin
        if (x == H_TOTAL - 1) begin
            x <= 0;
            y <= (y == V_TOTAL - 1) ? 10'd0 : y + 1'b1;
        end else begin
            x <= x + 1'b1;
        end
    end


    wire active = (x < H_ACTIVE) && (y < V_ACTIVE);
    assign LCD_DEN = active;


    reg [4:0] r;
    reg [5:0] g;
    reg [4:0] b;

    always @(*) begin
        r = 5'd0;
        g = 6'd0;
        b = 5'd0;
        if (active) begin
            if (x < 10'd160) r = 5'd31;   
            else if (x < 10'd320) g = 6'd63;  
            else b = 5'd31;  
        end
    end
    assign LCD_R = r;
    assign LCD_G = g;
    assign LCD_B = b;
endmodule