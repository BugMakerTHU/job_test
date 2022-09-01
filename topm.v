`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/01 13:27:27
// Design Name: 
// Module Name: topm
// Project Name: handshake
// Target Devices: 
// Tool Versions: Vivado2018.3
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ns
module topm#(
    parameter WIDTH            = 32
)        
	(
    input                      clk,
    input                      rst_n,
    input                      en_i,
    input[WIDTH-1:0]           data_i,
    input                      rdy_to_recieve,
    output                     en_o,
    output reg[WIDTH-1:0]          data_out,
    output                     rdy_to_send
    );
    wire[WIDTH-1:0] data_o;
    reg[WIDTH-1:0] data_out1;
    reg[WIDTH-1:0] data_out2;
    wire M2S_val;
    wire S2M_rdy;
    wire flag;
    wire [WIDTH-1:0] M2S_data;
    always@(posedge clk)begin
        data_out1 <= data_o;
    end
    always@(posedge clk)begin
        
        data_out <= (en_o&&rdy_to_recieve)?data_o:{WIDTH{1'bx}};
    end
    func#(
    .WIDTH(WIDTH)
    )   U_master     
	(
    .clk(clk),
    .rst_n(rst_n),
    .VALID_UP(en_i),
    .READY_UP(rdy_to_send),
    .DATA_UP(data_i),
    .VALID_DOWN(M2S_val),
    .READY_DOWN(S2M_rdy),
    .DATA_DOWN(M2S_data)
    );

    func#(
    .WIDTH(WIDTH)
    )   U_slave     
	(
    .clk(clk),
    .rst_n(rst_n),
    .VALID_UP(M2S_val),
    .READY_UP(S2M_rdy),
    .DATA_UP(M2S_data),
    .VALID_DOWN(en_o),
    .READY_DOWN(rdy_to_recieve),
    .DATA_DOWN(data_o)
    );
endmodule
//---------------------------------------
module func#(
        parameter WIDTH            = 32
    )        
        (
        input                      clk,
        input                      rst_n,
        //Up stream
        input                      VALID_UP,
        output reg                 READY_UP,
        input  [WIDTH-1:0]         DATA_UP,
        //Down Stream
        output                     VALID_DOWN,
        input                      READY_DOWN,
        output [WIDTH-1:0]         DATA_DOWN,
        output vas
        );
    wire                       store_data;
    reg    [WIDTH-1:0]         buffered_data;
    reg                        buffer_valid;
    //---------------------------------------

    assign store_data = VALID_UP && READY_UP && ~READY_DOWN;
    assign vas = (~store_data);
    always @(posedge clk)
        if (!rst_n)  buffer_valid <= 1'b0;
        else        buffer_valid <= buffer_valid ? ~READY_DOWN: store_data;

    always @(posedge clk)
        if (!rst_n)  buffered_data <= {WIDTH{1'b0}};
        else        buffered_data <= store_data ? DATA_UP : buffered_data;

    always @(posedge clk) begin
        if (!rst_n)  READY_UP <= 1'b1; 
        else        READY_UP <= READY_DOWN || ((~buffer_valid) && (~store_data)); //Bubule clampping
        end

    assign VALID_DOWN = READY_UP? VALID_UP : buffer_valid;
    assign DATA_DOWN  = READY_UP? DATA_UP  : buffered_data;
endmodule
