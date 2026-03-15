

module sync_w2r #(parameter DEPTH = 8) (
    input wire r_clk,               
    input wire rst_n,              
    input wire [$clog2(DEPTH):0] wptr,  
    output reg [$clog2(DEPTH):0] rsync_ptr2 
);
reg [$clog2(DEPTH):0] rsync_ptr1;
always @(posedge r_clk or negedge rst_n) begin
        if (!rst_n) begin
            rsync_ptr1 <= 'd0;
            rsync_ptr2 <= 'd0;
        end else begin
            rsync_ptr1 <= wptr;
            rsync_ptr2 <= rsync_ptr1;
        end
end
endmodule
