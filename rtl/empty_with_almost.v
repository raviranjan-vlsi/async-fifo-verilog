
module empty_with_almost
#(
    parameter DEPTH = 8,
    parameter ALMOST_EMPTY_MARGIN = 2
)
(
    input wire r_clk,
    input wire rst_n,
    input wire rd_rq,
    input wire [$clog2(DEPTH):0] rsync_ptr2,

    output reg [$clog2(DEPTH)-1:0] raddr,
    output reg [$clog2(DEPTH):0] rptr,
    output reg empty,
    output reg almost_empty
);

    localparam AW = $clog2(DEPTH);
    localparam PW = AW + 1;

    reg [PW-1:0] bin, binnext, graynext;
    reg emptyn;

    function [PW-1:0] gray2bin(input [PW-1:0] g);
        integer i;
        begin
            gray2bin[PW-1] = g[PW-1];
            for (i = PW-2; i >= 0; i=i-1)
                gray2bin[i] = gray2bin[i+1] ^ g[i];
        end
    endfunction

    reg [PW-1:0] wbin;
    reg [PW-1:0] used;
    reg almost_emptyn;

    always @(posedge r_clk or negedge rst_n) begin
        if (!rst_n) begin
            rptr <= 0;
            bin  <= 0;
            empty <= 1;
            almost_empty <= 1;
        end else begin
            rptr <= graynext;
            bin  <= binnext;
            empty <= emptyn;
            almost_empty <= almost_emptyn;
        end
    end

    always @(*) begin
        raddr = bin[AW-1:0];

        binnext = bin + (~empty & rd_rq);
        graynext = (binnext >> 1) ^ binnext;

        emptyn = (graynext == rsync_ptr2);

        // ---- ALMOST EMPTY LOGIC ----
        wbin = gray2bin(rsync_ptr2);
        used = wbin - bin;
        almost_emptyn = (used <= ALMOST_EMPTY_MARGIN);
    end

endmodule
