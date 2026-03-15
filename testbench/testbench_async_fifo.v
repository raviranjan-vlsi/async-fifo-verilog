

`timescale 1ns/1ps

module testbench();

    parameter WIDTH = 4, DEPTH = 8;
    localparam AW = $clog2(DEPTH);

    // ------------------------------------
    // DUT Signals
    // ------------------------------------
    reg clk_in;
    reg rst_n;
    reg wr_rq, rd_rq;
    reg [WIDTH-1:0] wdata;

    wire [WIDTH-1:0] rdata;
    wire full, empty;
    wire almost_full, almost_empty;

    // Internal tracking FIFO for validation
    reg [WIDTH-1:0] ref_fifo [0:DEPTH-1];
    integer ref_wptr = 0;
    integer ref_rptr = 0;

    // Clock outputs from DUT
    wire w_clk, r_clk;

    integer seed = 7;

    // ------------------------------------
    // Instantiate DUT
    // ------------------------------------
    Aynchrnous_FIFO_with_Almost_Empty_Full_flag #(
        .WIDTH(WIDTH),
        .DEPTH(DEPTH),
        .ALMOST_FULL_MARGIN(2),
        .ALMOST_EMPTY_MARGIN(2)
    ) DUT (
        .clk_in(clk_in),
        .rst_n(rst_n),
        .wr_rq(wr_rq),
        .rd_rq(rd_rq),
        .wdata(wdata),

        .full(full),
        .empty(empty),
        .almost_full(almost_full),
        .almost_empty(almost_empty),
        .rdata(rdata)
    );

    // ------------------------------------
    // Clock Divider Instance
    // ------------------------------------
    clock_divider div_inst (
        .clk_in(clk_in),
        .reset(~rst_n),
        .w_clk(w_clk),
        .r_clk(r_clk)
    );

    // ------------------------------------
    // Generate Main Input Clock
    // ------------------------------------
    initial begin
        clk_in = 0;
        forever #5 clk_in = ~clk_in;  // 100MHz
    end

    // ------------------------------------
    // Reset + Stimulus
    // ------------------------------------
    initial begin
        rst_n = 1; wr_rq = 0; rd_rq = 0; wdata = 0;

        #10 rst_n = 0;
        #15 rst_n = 1;

        #20 wr_rq = 1;
        #20 rd_rq = 1;

        fork
            // ------------------------------
            // WRITE Thread
            // ------------------------------
            begin
                repeat (200) begin
                    @(posedge w_clk);

                    if (!full) begin
                        wdata = $random(seed);
                        ref_fifo[ref_wptr] = wdata;
                        ref_wptr = (ref_wptr + 1) % DEPTH;
                    end

                    $display("WRITE @%t | wdata=%0d | full=%b almost_full=%b",
                             $time, wdata, full, almost_full);

                    #2;
                end
            end

            // ------------------------------
            // READ Thread
            // ------------------------------
            begin
                forever begin
                    @(posedge r_clk);

                    if (!empty) begin
                        ref_rptr = (ref_rptr + 1) % DEPTH;
                    end

                    $display("READ  @%t | rdata=%0d | empty=%b almost_empty=%b",
                              $time, rdata, empty, almost_empty);

                    #2;
                end
            end

        join
    end

    // ------------------------------------
    // Overflow/Underflow Detection
    // ------------------------------------
    always @(posedge w_clk)
        if (wr_rq && full)
            $display("ERROR: Overflow attempt at %t", $time);

    always @(posedge r_clk)
        if (rd_rq && empty)
            $display("ERROR: Underflow attempt at %t", $time);

    // ------------------------------------
    // Monitor Signals in Compact Form
    // ------------------------------------
    initial begin
        $monitor("t=%0t | F=%b AF=%b | E=%b AE=%b | W=%0d R=%0d",
                 $time, full, almost_full, empty, almost_empty, wdata, rdata);
    end

endmodule
