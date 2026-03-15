

module full_with_almost
#(
    parameter DEPTH = 8,
    parameter ALMOST_FULL_MARGIN = 2
)
(
    input wire w_clk,
    input wire rst_n,
    input wire wr_rq,
    input wire [$clog2(DEPTH):0] wsync_ptr2,

    output reg [$clog2(DEPTH)-1:0] waddr,
    output reg [$clog2(DEPTH):0] wptr,
    output reg full,
    output reg almost_full
   
);


    localparam AW = $clog2(DEPTH);  // AW = Address width 
    localparam PW = AW + 1;         // PW  = Pointer width 

    reg [PW-1:0] bin, binnext, graynext;
    reg fulln;

    // Gray → Binary converter
    function [PW-1:0] gray2bin(input [PW-1:0] g);
        integer i;
        begin
            gray2bin[PW-1] = g[PW-1];
            for (i = PW-2; i >= 0; i=i-1)
                gray2bin[i] = gray2bin[i+1] ^ g[i];
        end
    endfunction

    reg [PW-1:0] rbin;
    reg [PW-1:0] used;
    reg almost_fulln;

    always @(posedge w_clk or negedge rst_n) begin
        if (!rst_n) begin
            wptr <= 0;
            bin  <= 0;
            full <= 0;
            almost_full <= 0;
        end else begin
            wptr <= graynext;
            bin  <= binnext;
            full <= fulln;
            almost_full <= almost_fulln;
        end
    end

    always @(*) begin
        waddr   = bin[AW-1:0];
        binnext = bin + (~full & wr_rq);
        graynext = (binnext >> 1) ^ binnext;

        // full detection (MSB inversion method)
        fulln = (graynext ==
                 {~wsync_ptr2[PW-1:PW-2], wsync_ptr2[PW-3:0]});

        // ---- ALMOST FULL LOGIC ----
        rbin = gray2bin(wsync_ptr2);

        used = bin - rbin;  // entries in FIFO

        almost_fulln = (used >= (DEPTH - ALMOST_FULL_MARGIN));
    end

endmodule


