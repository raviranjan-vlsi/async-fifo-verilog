

module sync_r2w #(parameter DEPTH = 8) (
    input wire w_clk,               
    input wire rst_n,               
    input wire [$clog2(DEPTH):0] rptr, 
    output reg [$clog2(DEPTH):0] wsync_ptr2 
);
reg [$clog2(DEPTH):0] wsync_ptr1;
always @(posedge w_clk or negedge rst_n) begin
    if (!rst_n) begin
        wsync_ptr1 <= 'd0;
        wsync_ptr2 <= 'd0;
    end else begin
        wsync_ptr1 <= rptr;
        wsync_ptr2 <= wsync_ptr1;
    end
end
endmodule
