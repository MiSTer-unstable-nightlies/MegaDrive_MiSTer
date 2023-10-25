//
// Copyright (c) 2019-2023 Alexey Melnikov
//
// All rights reserved
//
// Redistribution and use in source and synthezised forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// Redistributions of source code must retain the above copyright notice,
// this list of conditions and the following disclaimer.
//
// Redistributions in synthesized form must reproduce the above copyright
// notice, this list of conditions and the following disclaimer in the
// documentation and/or other materials provided with the distribution.
//
// Neither the name of the author nor the names of other contributors may
// be used to endorse or promote products derived from this software without
// specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
// THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
// PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.
//
// Please report bugs to the author, but before you do so, please
// make sure that this is not a derivative work and that
// you have the latest version of this file.

module fourway
(
   input clk,
   input reset,
   
   input MODE,
   
   input P1_UP,
   input P1_DOWN,
   input P1_LEFT,
   input P1_RIGHT,
   input P1_A,
   input P1_B,
   input P1_C,
   input P1_START,
   input P1_MODE,
   input P1_X,
   input P1_Y,
   input P1_Z,
   
   input P2_UP,
   input P2_DOWN,
   input P2_LEFT,
   input P2_RIGHT,
   input P2_A,
   input P2_B,
   input P2_C,
   input P2_START,
   input P2_MODE,
   input P2_X,
   input P2_Y,
   input P2_Z,

   input P3_UP,
   input P3_DOWN,
   input P3_LEFT,
   input P3_RIGHT,
   input P3_A,
   input P3_B,
   input P3_C,
   input P3_START,
   input P3_MODE,
   input P3_X,
   input P3_Y,
   input P3_Z,

   input P4_UP,
   input P4_DOWN,
   input P4_LEFT,
   input P4_RIGHT,
   input P4_A,
   input P4_B,
   input P4_C,
   input P4_START,
   input P4_MODE,
   input P4_X,
   input P4_Y,
   input P4_Z,

	output [6:0] port1_out,
	input  [6:0] port1_in,
	input  [6:0] port1_dir,

	output [6:0] port2_out,
	input  [6:0] port2_in,
	input  [6:0] port2_dir
);

wire [6:0] player_out[4];
reg  [6:0] player_dir[4];

pad_io pad1
(
	.clk(clk),
	.reset(reset),

	.MODE(MODE),

	.P_UP(P1_UP),
	.P_DOWN(P1_DOWN),
	.P_LEFT(P1_LEFT),
	.P_RIGHT(P1_RIGHT),
	.P_A(P1_A),
	.P_B(P1_B),
	.P_C(P1_C),
	.P_START(P1_START),
	.P_MODE(P1_MODE),
	.P_X(P1_X),
	.P_Y(P1_Y),
	.P_Z(P1_Z),

	.port_out(player_out[0]),
	.port_in(port1_in),
	.port_dir(player_dir[0])
);

pad_io pad2
(
	.clk(clk),
	.reset(reset),

	.MODE(MODE),

	.P_UP(P2_UP),
	.P_DOWN(P2_DOWN),
	.P_LEFT(P2_LEFT),
	.P_RIGHT(P2_RIGHT),
	.P_A(P2_A),
	.P_B(P2_B),
	.P_C(P2_C),
	.P_START(P2_START),
	.P_MODE(P2_MODE),
	.P_X(P2_X),
	.P_Y(P2_Y),
	.P_Z(P2_Z),

	.port_out(player_out[1]),
	.port_in(port1_in),
	.port_dir(player_dir[1])
);

pad_io pad3
(
	.clk(clk),
	.reset(reset),

	.MODE(MODE),

	.P_UP(P3_UP),
	.P_DOWN(P3_DOWN),
	.P_LEFT(P3_LEFT),
	.P_RIGHT(P3_RIGHT),
	.P_A(P3_A),
	.P_B(P3_B),
	.P_C(P3_C),
	.P_START(P3_START),
	.P_MODE(P3_MODE),
	.P_X(P3_X),
	.P_Y(P3_Y),
	.P_Z(P3_Z),

	.port_out(player_out[2]),
	.port_in(port1_in),
	.port_dir(player_dir[2])
);

pad_io pad4
(
	.clk(clk),
	.reset(reset),

	.MODE(MODE),

	.P_UP(P4_UP),
	.P_DOWN(P4_DOWN),
	.P_LEFT(P4_LEFT),
	.P_RIGHT(P4_RIGHT),
	.P_A(P4_A),
	.P_B(P4_B),
	.P_C(P4_C),
	.P_START(P4_START),
	.P_MODE(P4_MODE),
	.P_X(P4_X),
	.P_Y(P4_Y),
	.P_Z(P4_Z),

	.port_out(player_out[3]),
	.port_in(port1_in),
	.port_dir(player_dir[3])
);

assign port2_out = port2_dir | port2_in;
assign port1_out = n[2] ? 7'h7C : player_out[n[1:0]];

reg [2:0] n;
always @(posedge clk) if(!port2_out[1:0]) n <= port2_out[6:4];

always_comb begin
	player_dir = '{7'h7F, 7'h7F, 7'h7F, 7'h7F};
	if(!n[2]) player_dir[n[1:0]] = port1_dir;
end

endmodule
