`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/01 13:33:26
// Design Name: 
// Module Name: testbench
// Project Name: shakehands
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


module testbench;
	reg clk;
	reg rst_n;
	reg en_i_r;
	parameter WIDTH = 32;
	reg [WIDTH-1:0] data_i_r;
	reg rdy_to_recieve;
	wire rdy_to_send;
	wire en_o;
	wire[WIDTH-1:0] data_o;
	wire[WIDTH-1:0] data_out;
	reg[WIDTH-1:0] new_num_r;
	wire flag;
	reg [WIDTH-1:0] new_num;
	assign flag = (new_num_r==new_num);
	assign data_out = (~flag)?data_o:{WIDTH{1'bx}};

	

   topm#(
    .WIDTH(WIDTH)
)    u_topm    
	(
    .clk(clk),
    .rst_n(rst_n),
    .en_i(en_i_r),
    .data_i(data_i_r),
    .rdy_to_recieve(rdy_to_recieve),
    .en_o(en_o),
    .data_out(data_o),
    .rdy_to_send(rdy_to_send)
    );
   
    always@(posedge clk)
        new_num <= (en_i_r&&rdy_to_send&&rdy_to_recieve)?(new_num+1):new_num;
    always@(posedge clk)
        new_num_r <= new_num;
    initial begin
  clk = 0;
  forever #5 clk = ~clk;
  end
    initial begin
			rst_n = 1'b0;
			en_i_r = 1'b0;
			data_i_r = 32'd0;
            rdy_to_recieve = 1'b1;
            new_num = 32'd8;
			

			repeat(10)@(posedge clk);
			rst_n = 1'b1;
			repeat(10) @(posedge clk);
			
			@(posedge clk)
			en_i_r <= 1'b1;
			data_i_r <= (en_i_r&&rdy_to_send&&rdy_to_recieve)?new_num:data_i_r;

			@(posedge clk);
			en_i_r <= 1'b1;
			
			data_i_r <= (en_i_r&&rdy_to_send&&rdy_to_recieve)?new_num:data_i_r;
			
			
			@(posedge clk);
			en_i_r <= 1'b1;
			data_i_r <= (en_i_r&&rdy_to_send&&rdy_to_recieve)?new_num:data_i_r;
			
			@(posedge clk);
			en_i_r <= 1'b1;
			data_i_r <= (en_i_r&&rdy_to_send&&rdy_to_recieve)?new_num:data_i_r;
            @(negedge clk);
            rdy_to_recieve = 1'b0;
            @(posedge clk);
            
			en_i_r <= 1'b1;
			data_i_r <= (en_i_r&&rdy_to_send&&rdy_to_recieve)?new_num:data_i_r;
			
			@(posedge clk);
			en_i_r <= 1'b1;
			data_i_r <= (en_i_r&&rdy_to_send&&rdy_to_recieve)?new_num:data_i_r;
			
		    @(posedge clk);
			en_i_r <= 1'b0;
			data_i_r <= (en_i_r&&rdy_to_send&&rdy_to_recieve)?new_num:data_i_r;
			repeat(10) @(posedge clk);
			@(posedge clk);
			en_i_r <= 1'b1;
			data_i_r <= (en_i_r&&rdy_to_send&&rdy_to_recieve)?new_num:data_i_r;
			@(posedge clk);
			en_i_r <= 1'b1;
			data_i_r <= (en_i_r&&rdy_to_send&&rdy_to_recieve)?new_num:data_i_r;
			@(posedge clk);
			en_i_r <= 1'b1;
			data_i_r <= (en_i_r&&rdy_to_send&&rdy_to_recieve)?new_num:data_i_r;
			@(negedge clk);
			rdy_to_recieve = 1'b1;
			@(posedge clk);
			en_i_r <= 1'b1;
			data_i_r <= (en_i_r&&rdy_to_send&&rdy_to_recieve)?new_num:data_i_r;
			@(posedge clk);
			en_i_r <= 1'b1;
			data_i_r <= (en_i_r&&rdy_to_send&&rdy_to_recieve)?new_num:data_i_r;
			@(posedge clk);
			en_i_r <= 1'b1;
			data_i_r <= (en_i_r&&rdy_to_send&&rdy_to_recieve)?new_num:data_i_r;
			@(posedge clk);
			en_i_r <= 1'b1;
			data_i_r <= (en_i_r&&rdy_to_send&&rdy_to_recieve)?new_num:data_i_r;
			@(posedge clk);
			en_i_r <= 1'b1;
			data_i_r <= (en_i_r&&rdy_to_send&&rdy_to_recieve)?new_num:data_i_r;
			@(posedge clk);
			en_i_r <= 1'b1;
			data_i_r <= (en_i_r&&rdy_to_send&&rdy_to_recieve)?new_num:data_i_r;
			@(posedge clk);
			en_i_r <= 1'b1;
			data_i_r <= (en_i_r&&rdy_to_send&&rdy_to_recieve)?new_num:data_i_r;
			@(posedge clk);
			en_i_r <= 1'b1;
			data_i_r <= (en_i_r&&rdy_to_send&&rdy_to_recieve)?new_num:data_i_r;
			@(posedge clk);
			en_i_r <= 1'b1;
			data_i_r <= (en_i_r&&rdy_to_send&&rdy_to_recieve)?new_num:data_i_r;
			@(posedge clk);
			en_i_r <= 1'b1;
			data_i_r <= (en_i_r&&rdy_to_send&&rdy_to_recieve)?new_num:data_i_r;
			@(negedge clk);
			en_i_r <= 1'b0;
			@(posedge clk);
			data_i_r <= (en_i_r&&rdy_to_send&&rdy_to_recieve)?new_num:data_i_r;
			@(posedge clk);
			data_i_r <= (en_i_r&&rdy_to_send&&rdy_to_recieve)?new_num:data_i_r;
			@(posedge clk);
			data_i_r <= (en_i_r&&rdy_to_send&&rdy_to_recieve)?new_num:data_i_r;
			@(posedge clk);
			data_i_r <= (en_i_r&&rdy_to_send&&rdy_to_recieve)?new_num:data_i_r;
			@(posedge clk);
			en_i_r <= 1'b1;
			data_i_r <= (en_i_r&&rdy_to_send&&rdy_to_recieve)?new_num:data_i_r;
			@(posedge clk);
			en_i_r <= 1'b1;
			data_i_r <= (en_i_r&&rdy_to_send&&rdy_to_recieve)?new_num:data_i_r;
			@(posedge clk);
			en_i_r <= 1'b1;
			data_i_r <= (en_i_r&&rdy_to_send&&rdy_to_recieve)?new_num:data_i_r;
			@(posedge clk);
			en_i_r <= 1'b1;
			data_i_r <= (en_i_r&&rdy_to_send&&rdy_to_recieve)?new_num:data_i_r;
			@(posedge clk);
			en_i_r <= 1'b1;
			data_i_r <= 32'd33;
			@(posedge clk);
			en_i_r <= 1'b1;
			data_i_r <= 32'd33;
			@(posedge clk);
			en_i_r <= 1'b1;
			data_i_r <= 32'd33;
			@(posedge clk);
			en_i_r <= 1'b1;
			data_i_r <= 32'd34;
			@(posedge clk);
			en_i_r <= 1'b1;
			data_i_r <= (en_i_r&&rdy_to_send&&rdy_to_recieve)?new_num:data_i_r;
			repeat(10) @(posedge clk);
			@(posedge clk);
			en_i_r <= 1'b0;
			repeat(10) @(posedge clk);
			$finish();
			
           end

endmodule