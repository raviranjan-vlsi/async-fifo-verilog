

module Aynchrnous_FIFO_with_Almost_Empty_Full_flag    
    #(
    parameter WIDTH = 4, 
    parameter DEPTH = 8,
    parameter ALMOST_FULL_MARGIN  = 2,
    parameter ALMOST_EMPTY_MARGIN = 2
)
(
    input wire clk_in,          
    input wire rst_n,           
    input wire wr_rq,           
    input wire rd_rq,           
    input wire [WIDTH-1:0] wdata, 
    
    output wire full,           
    output wire empty,          
    output wire almost_full,     
    output wire almost_empty,    
    output wire [WIDTH-1:0] rdata 
);

    wire w_clk; 
    wire r_clk;

    wire [$clog2(DEPTH)-1:0] waddr;  
    wire [$clog2(DEPTH)-1:0] raddr;  
    wire [$clog2(DEPTH):0] wptr;     
    wire [$clog2(DEPTH):0] rptr;     
    wire [$clog2(DEPTH):0] wsync_ptr2;
    wire [$clog2(DEPTH):0] rsync_ptr2;

    // Clock divider
    clock_divider clk_div_inst (
        .clk_in(clk_in),
        .reset(~rst_n),
        .w_clk(w_clk),
        .r_clk(r_clk)
    );

    // Synchronizers
    sync_r2w #(.DEPTH(DEPTH)) sync_r2w_inst (
        .rptr(rptr),
        .w_clk(w_clk),
        .rst_n(rst_n),
        .wsync_ptr2(wsync_ptr2)
    );

    sync_w2r #(.DEPTH(DEPTH)) sync_w2r_inst (
        .wptr(wptr),
        .r_clk(r_clk),
        .rst_n(rst_n),
        .rsync_ptr2(rsync_ptr2)
    );

    // FIFO memory
    fifo_mem #(.WIDTH(WIDTH), .DEPTH(DEPTH)) fifomem_inst (
        .w_clk(w_clk),
        .r_clk(r_clk),
        .wr_rq(wr_rq),
        .rd_rq(rd_rq),
        .full(full),
        .empty(empty),
        .waddr(waddr),
        .raddr(raddr),
        .wdata(wdata),
        .rdata(rdata)
    );

    // FULL + ALMOST FULL
    full_with_almost #(
        .DEPTH(DEPTH),
        .ALMOST_FULL_MARGIN(ALMOST_FULL_MARGIN)
    ) full_inst (
        .w_clk(w_clk),
        .rst_n(rst_n),
        .wr_rq(wr_rq),
        .wsync_ptr2(wsync_ptr2),
        .waddr(waddr),
        .wptr(wptr),
        .full(full),
        .almost_full(almost_full)
    );

    // EMPTY + ALMOST EMPTY
    empty_with_almost #(
        .DEPTH(DEPTH),
        .ALMOST_EMPTY_MARGIN(ALMOST_EMPTY_MARGIN)
    ) empty_inst (
        .r_clk(r_clk),
        .rst_n(rst_n),
        .rd_rq(rd_rq),
        .rsync_ptr2(rsync_ptr2),
        .raddr(raddr),
        .rptr(rptr),
        .empty(empty),
        .almost_empty(almost_empty)
    );

endmodule

