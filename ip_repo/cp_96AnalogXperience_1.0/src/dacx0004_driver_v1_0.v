/*
  Module name:  max5134_driver
  Author: P Trujillo
  Date: Dec 2019
  Description:
          Driver for DAC DACx0004. 96AnalogXperience
  Revision:
          1.0: Module created.
*/

module dacx0004_driver_v1_0 (
  input clk100mhz,
  input rst,
  input ce,

  input [15:0] i_data_ch0,
  input [15:0] i_data_ch1,
  input [15:0] i_data_ch2,
  input [15:0] i_data_ch3,

  output o_sdo,
  output reg or_sck,
  output reg or_cs,
  output reg or_nldac
  );

  localparam IDLE = 0, WRITE_CONFIG_REG = 1, WAIT_CONFIG_REG = 2, WRITE_CHX = 3, WAIT_CHX = 4, WAIT_SYNC_HIGH_1 = 5, LDAC_UPDATE = 6, WRITE_POWER_ON = 7, WAIT_POWER_ON = 8, WAIT_SYNC_HIGH_2 = 9;

  reg [3:0] r4_dac_state;
  reg [31:0] r32_data_out;
  reg [1:0] r2_ch_select;
  reg r_spi_start;
  reg [3:0] r4_spi_state;
  reg [4:0] r5_data_counter; // spi data counter (32 bits)
  wire w_busy_spi;
  reg [4:0] r5_counter_sync;
  reg [2:0] r3_counter_nldac;
  reg [2:0] r3_index_config;
  wire [31:0] w32x6_config_regs [0:5];

  assign w32x6_config_regs[0] = 32'h0800000F; /* Disable SDO register */
  assign w32x6_config_regs[1] = 32'h04F0000F;
  assign w32x6_config_regs[2] = 32'h06F0000F;
  assign w32x6_config_regs[3] = 32'h1d000000;
  assign w32x6_config_regs[4] = 32'h1e000000;
  assign w32x6_config_regs[5] = 32'h05000002;

  assign w_busy_spi = !((r_spi_start == 1'b0) && (r4_spi_state == 4'd0));

  /* DAC controller */
  always @( posedge clk100mhz)
    if( rst) begin
      r4_dac_state <= IDLE;
      r32_data_out <= 32'd0;
      r_spi_start <= 1'b0;
      r5_counter_sync <= 2'b00;
      r2_ch_select <= 2'b11;
      or_nldac <= 1'b1;
      r3_index_config <= 3'd0;
    end
    else
      case (r4_dac_state)
        IDLE: begin
          if (ce) r4_dac_state <= WRITE_CONFIG_REG;
          else r4_dac_state <= IDLE;

        end
        WRITE_CONFIG_REG: begin
          r4_dac_state <= WAIT_CONFIG_REG;

          r32_data_out <= w32x6_config_regs[r3_index_config];
          r_spi_start <= 1'b1;
          r3_index_config <= r3_index_config+1;
        end
        WAIT_CONFIG_REG: begin
          if (!w_busy_spi) r4_dac_state <= WAIT_SYNC_HIGH_1;
          else r4_dac_state <= WAIT_CONFIG_REG;

          r_spi_start <= 1'b0;
        end
        WAIT_SYNC_HIGH_1: begin
          if (&r5_counter_sync && (r3_index_config == 6)) r4_dac_state <= WRITE_CHX;
          else if (&r5_counter_sync && (r3_index_config < 6)) r4_dac_state <= WRITE_CONFIG_REG;
          else r4_dac_state <= WAIT_SYNC_HIGH_1;

          r5_counter_sync <= r5_counter_sync+1;
          or_nldac <= 1'b1;
        end
        WRITE_CHX: begin
          r4_dac_state <= WAIT_CHX;

          if (r2_ch_select == 2'b00)
            r32_data_out <= {4'b0000, 4'b0011, 4'b0000, i_data_ch0, 4'b0000};
          else if (r2_ch_select == 2'b01)
            r32_data_out <= {4'b0000, 4'b0011, 4'b0001, i_data_ch1, 4'b0000};
          else if (r2_ch_select == 2'b10)
            r32_data_out <= {4'b0000, 4'b0011, 4'b0010, i_data_ch2, 4'b0000};
          else if (r2_ch_select == 2'b11)
            r32_data_out <= {4'b0000, 4'b0011, 4'b0011, i_data_ch3, 4'b0000};
          else
            r32_data_out <= {4'b0000, 4'b0010, 4'b0000, i_data_ch0, 4'b0000};

          r2_ch_select <= r2_ch_select+1;
          r_spi_start <= 1'b1;
        end
        WAIT_CHX: begin
          if (!w_busy_spi) r4_dac_state <= WAIT_SYNC_HIGH_1;//LDAC_UPDATE;
          else r4_dac_state <= WAIT_CHX;

          r_spi_start <= 1'b0;
        end
        LDAC_UPDATE: begin
          if (&r3_counter_nldac) r4_dac_state <=  WAIT_SYNC_HIGH_1;
          else r4_dac_state <= LDAC_UPDATE;

          r3_counter_nldac <= r3_counter_nldac+1;
          or_nldac <= 1'b0;
        end
        default: begin
          r4_dac_state <= IDLE;

        end
      endcase

  /* SPI controller */
  always @(posedge clk100mhz)
    if (rst) begin
      r4_spi_state <= 3'd0;
      or_sck <= 1'b1;
      or_cs <= 1'b1;
      r5_data_counter <= 5'd31;
    end
    else
      case (r4_spi_state)
        3'd0: begin
          if (r_spi_start) r4_spi_state <= 3'd1;
          else r4_spi_state <= 3'd0;

          or_sck <= 1'b1;
          or_cs <= 1'b1;
          r5_data_counter <= 5'd31;
        end
        3'd1: begin
          r4_spi_state <= 3'd2;

          or_sck <= 1'b1;
          or_cs <= 1'b0;
        end
        3'd2: begin
          r4_spi_state <= 3'd3;

          or_sck <= 1'b1;
          or_cs <= 1'b0;
        end
        3'd3: begin
          r4_spi_state <= 3'd4;

          or_sck <= 1'b0;
          or_cs <= 1'b0;
        end
        3'd4: begin
          r4_spi_state <= 3'd5;

          or_sck <= 1'b0;
          or_cs <= 1'b0;
        end
        3'd5: begin
          r4_spi_state <= 3'd6;

          or_sck <= 1'b1;
          or_cs <= 1'b0;
        end
        3'd6: begin
          if (r5_data_counter == 0) r4_spi_state <= 3'd0;
          else r4_spi_state <= 3'd3;

          or_sck <= 1'b1;
          or_cs <= 1'b0;
          r5_data_counter <= (r5_data_counter>0)? r5_data_counter-5'd1: 0;
        end
      endcase

  assign o_sdo = r32_data_out[r5_data_counter];

endmodule
