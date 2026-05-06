module top (
    input   CLK,
    output  LCD_CLK,
    output  LCD_DEN,
    output  [4:0] LCD_R,
    output  [5:0] LCD_G,
    output  [4:0] LCD_B
);
    localparam H_ACTIVE = 480;
    localparam H_TOTAL  = 525;
    localparam V_ACTIVE = 272;
    localparam V_TOTAL  = 285;

    reg [9:0] x = 0;
    reg [8:0] y = 0;

    assign LCD_CLK = CLK;

    always @(posedge CLK) begin
        if (x < H_TOTAL - 1) begin
            x <= x +1;
        end else begin
            x <=0;
            if (y < V_TOTAL -1 ) begin
            y<= y+1;
            end else begin 
            y<=0;
            end
        end
    end

    
    assign LCD_DEN = (x < H_ACTIVE) && (y < V_ACTIVE);
    always@(*) begin
        if (LCD_DEN) begin
            if (x<160) begin
                LCD_R = 5'd31;
                LCD_G = 6'd0;
                LCD_B = 6'd0;
            end else if (x<320) begin 
                LCD_R = 5'd0;
                LCD_G = 6'd62;
                LCD_B = 6'd0;
            end else begin 
                LCD_R = 5'd0;
                LCD_G = 6'd0;
                LCD_B = 6'd31;
            end
        end else begin 
            LCD_R = 5'd0;
            LCD_G = 6'd0;
            LCD_B = 6'd0;
        end
    end
              
endmodule