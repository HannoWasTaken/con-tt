module sqrt (
	clk_i,
	rst_i,
	start_i,
	a_i,
	valid_o,
	busy_o,
	result_o
);
	reg _sv2v_0;
	input wire clk_i;
	input wire rst_i;
	input wire start_i;
	input [31:0] a_i;
	output wire valid_o;
	output wire busy_o;
	output wire [31:0] result_o;
	reg [31:0] x_p;
	reg [31:0] x_n;
	reg [31:0] d_p;
	reg [31:0] d_n;
	reg [31:0] r_p;
	reg [31:0] r_n;
	reg valid_o_p;
	reg valid_o_n;
	reg busy_o_p;
	reg busy_o_n;
	reg [1:0] state_p;
	reg [1:0] state_n;
	always @(posedge clk_i or posedge rst_i)
		if (rst_i) begin
			state_p <= 2'd0;
			x_p <= 0;
			d_p <= 1073741824;
			r_p <= 0;
			valid_o_p <= 0;
			busy_o_p <= 0;
		end
		else begin
			x_p <= x_n;
			d_p <= d_n;
			r_p <= r_n;
			state_p <= state_n;
			valid_o_p <= valid_o_n;
			busy_o_p <= busy_o_n;
		end
	always @(*) begin
		if (_sv2v_0)
			;
		state_n = state_p;
		d_n = d_p;
		x_n = x_p;
		r_n = r_p;
		valid_o_n = valid_o_p;
		busy_o_n = busy_o_p;
		case (state_p)
			default: begin
				state_n = state_p;
				d_n = d_p;
				x_n = x_p;
				r_n = r_p;
				valid_o_n = valid_o_p;
				busy_o_n = busy_o_p;
			end
			2'd0: begin
				busy_o_n = 0;
				if (start_i && !busy_o_p) begin
					state_n = 2'd1;
					x_n = a_i;
					busy_o_n = 1;
					valid_o_n = 0;
					d_n = 1073741824;
					r_n = 0;
				end
			end
			2'd1: begin
				busy_o_n = 1;
				valid_o_n = 0;
				if (d_p > x_p)
					d_n = d_p >> 2;
				else
					state_n = 2'd2;
			end
			2'd2:
				if (d_p != 0) begin
					busy_o_n = 1;
					valid_o_n = 0;
					d_n = d_p >> 2;
					if (x_p >= (r_p + d_p)) begin
						x_n = x_p - (r_p + d_p);
						r_n = (r_p >> 1) + d_p;
					end
					else
						r_n = r_p >> 1;
				end
				else begin
					state_n = 2'd0;
					busy_o_n = 0;
					valid_o_n = 1;
				end
		endcase
	end
	assign busy_o = busy_o_p;
	assign valid_o = valid_o_p;
	assign result_o = r_p;
	initial _sv2v_0 = 0;
endmodule
