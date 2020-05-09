/**
  Module name:  signal_generator_v1_0
  Author: P Trujillo (pablo@controlpaths.com)
  Date: Mar20
  Description:
          Clock enable generation according prescaler input.
  Revision:
          1.0: Module created.
**/

module signal_generator_v1_0 (
  input clk,
  input rstn,
  input cen,

  output reg signed [15:0] ors16_signal
  );

/* Signal memory read */
reg signed [15:0] m16_signal [127:0];
reg [6:0] r7_data_index;
initial $readmemh("signal3.mem", m16_signal);

always @(posedge clk)
  if (!rstn) begin
    r7_data_index <= 7'd0;
    ors16_signal <= 16'd0;
  end
  else
    if (cen) begin
      r7_data_index <= r7_data_index+7'd1;
      ors16_signal <= m16_signal[r7_data_index];
    end

endmodule
