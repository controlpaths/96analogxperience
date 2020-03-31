/*
  Module name:  fir8_v1_0
  Author: P Trujillo (pablo@controlpaths.com)
  Date: Dec 2019
  Description:
          fir 8 filter module. 96AnalogXperience
  Revision:
          1.0: Module created.
*/

module fir8_v1_0 #(
  parameter
  pw_io_width = 12,
  pw_io_decimal = 11,
  pw_coeff_decimal = 31
  )(
  input clk,
  input rstn,
  input ce,

  input signed [31:0] isp_coeff_0,
  input signed [31:0] isp_coeff_1,
  input signed [31:0] isp_coeff_2,
  input signed [31:0] isp_coeff_3,
  input signed [31:0] isp_coeff_4,
  input signed [31:0] isp_coeff_5,
  input signed [31:0] isp_coeff_6,
  input signed [31:0] isp_coeff_7,
  input signed [31:0] isp_coeff_8,

  input signed [pw_io_width-1:0] isp_in,
  output signed [pw_io_width-1:0] osp_out
  );

  localparam lpw_coeff_width = 32; /* AXI width */
  localparam lpw_coeff_integer = lpw_coeff_width-pw_coeff_decimal; /* Compute integer width */
  localparam lpw_io_integer = pw_io_width-pw_io_decimal; /* Compute integer width */

  reg signed [lpw_coeff_width-1:0] rsp_pipe [8:0];
  reg signed [(lpw_coeff_width*2)-1:0] rsp_pipe_coeff [8:0];
  reg ce_mult;
  reg signed [(lpw_coeff_width*2)-1:0] rsp_pipe_coeff_sum;

  /*  Pipeline */
  always @(posedge clk)
    if (!rstn) begin
      rsp_pipe[0] <= {pw_io_width{1'b0}};
      rsp_pipe[1] <= {pw_io_width{1'b0}};
      rsp_pipe[2] <= {pw_io_width{1'b0}};
      rsp_pipe[3] <= {pw_io_width{1'b0}};
      rsp_pipe[4] <= {pw_io_width{1'b0}};
      rsp_pipe[5] <= {pw_io_width{1'b0}};
      rsp_pipe[6] <= {pw_io_width{1'b0}};
      rsp_pipe[7] <= {pw_io_width{1'b0}};
      rsp_pipe[8] <= {pw_io_width{1'b0}};
      ce_mult <= 1'b0;
    end
    else
      if (ce) begin
        rsp_pipe[0] <= {{(lpw_coeff_integer-lpw_io_integer){isp_in[pw_io_width-1]}}, isp_in, {(pw_coeff_decimal-pw_io_decimal){1'b0}}};
        rsp_pipe[1] <= rsp_pipe[0];
        rsp_pipe[2] <= rsp_pipe[1];
        rsp_pipe[3] <= rsp_pipe[2];
        rsp_pipe[4] <= rsp_pipe[3];
        rsp_pipe[5] <= rsp_pipe[4];
        rsp_pipe[6] <= rsp_pipe[5];
        rsp_pipe[7] <= rsp_pipe[6];
        rsp_pipe[8] <= rsp_pipe[7];
        ce_mult <= 1'b1;
      end
      else
        ce_mult <= 1'b0;

  /* Multipliers */
  always @(posedge clk)
    if (!rstn) begin
      rsp_pipe_coeff[0] <= {pw_io_width{1'b0}};
      rsp_pipe_coeff[1] <= {pw_io_width{1'b0}};
      rsp_pipe_coeff[2] <= {pw_io_width{1'b0}};
      rsp_pipe_coeff[3] <= {pw_io_width{1'b0}};
      rsp_pipe_coeff[4] <= {pw_io_width{1'b0}};
      rsp_pipe_coeff[5] <= {pw_io_width{1'b0}};
      rsp_pipe_coeff[6] <= {pw_io_width{1'b0}};
      rsp_pipe_coeff[7] <= {pw_io_width{1'b0}};
      rsp_pipe_coeff[8] <= {pw_io_width{1'b0}};
    end
    else begin
      if (ce_mult) begin
        rsp_pipe_coeff[0] <= rsp_pipe[0]*isp_coeff_0;
        rsp_pipe_coeff[1] <= rsp_pipe[1]*isp_coeff_1;
        rsp_pipe_coeff[2] <= rsp_pipe[2]*isp_coeff_2;
        rsp_pipe_coeff[3] <= rsp_pipe[3]*isp_coeff_3;
        rsp_pipe_coeff[4] <= rsp_pipe[4]*isp_coeff_4;
        rsp_pipe_coeff[5] <= rsp_pipe[5]*isp_coeff_5;
        rsp_pipe_coeff[6] <= rsp_pipe[6]*isp_coeff_6;
        rsp_pipe_coeff[7] <= rsp_pipe[7]*isp_coeff_7;
        rsp_pipe_coeff[8] <= rsp_pipe[8]*isp_coeff_8;
      end
      else
        rsp_pipe_coeff_sum <= rsp_pipe_coeff[0]+rsp_pipe_coeff[1]+rsp_pipe_coeff[2]+rsp_pipe_coeff[3]+
                              rsp_pipe_coeff[4]+rsp_pipe_coeff[5]+rsp_pipe_coeff[6]+rsp_pipe_coeff[7]+
                              rsp_pipe_coeff[8];
    end
  assign osp_out = (rsp_pipe_coeff_sum>>>(pw_coeff_decimal*2-pw_io_decimal));

endmodule
