
`timescale 1 ns / 1 ps

	module axi_fir8_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line
		parameter param_io_width = 12,
		parameter param_io_decimal = 11,
		parameter param_coeff_decimal = 11,

		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 6
	)
	(
		// Users to add ports here
		input [param_io_width-1:0] in_data,
		output [param_io_width-1:0] out_data,
		input cen,
		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXI
		input wire  s00_axi_aclk,
		input wire  s00_axi_aresetn,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
		input wire [2 : 0] s00_axi_awprot,
		input wire  s00_axi_awvalid,
		output wire  s00_axi_awready,
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
		input wire  s00_axi_wvalid,
		output wire  s00_axi_wready,
		output wire [1 : 0] s00_axi_bresp,
		output wire  s00_axi_bvalid,
		input wire  s00_axi_bready,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
		input wire [2 : 0] s00_axi_arprot,
		input wire  s00_axi_arvalid,
		output wire  s00_axi_arready,
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
		output wire [1 : 0] s00_axi_rresp,
		output wire  s00_axi_rvalid,
		input wire  s00_axi_rready
	);

	/* Coeff wires */
	wire signed [31:0] coeff0, coeff1, coeff2, coeff3, coeff4, coeff5, coeff6, coeff7, coeff8;

	// Instantiation of Axi Bus Interface S00_AXI
	axi_fir8_v1_0_S00_AXI # (
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	) axi_fir8_v1_0_S00_AXI_inst (
		.slv_reg0(coeff0),
		.slv_reg1(coeff1),
		.slv_reg2(coeff2),
		.slv_reg3(coeff3),
		.slv_reg4(coeff4),
		.slv_reg5(coeff5),
		.slv_reg6(coeff6),
		.slv_reg7(coeff7),
		.slv_reg8(coeff8),
		.S_AXI_ACLK(s00_axi_aclk),
		.S_AXI_ARESETN(s00_axi_aresetn),
		.S_AXI_AWADDR(s00_axi_awaddr),
		.S_AXI_AWPROT(s00_axi_awprot),
		.S_AXI_AWVALID(s00_axi_awvalid),
		.S_AXI_AWREADY(s00_axi_awready),
		.S_AXI_WDATA(s00_axi_wdata),
		.S_AXI_WSTRB(s00_axi_wstrb),
		.S_AXI_WVALID(s00_axi_wvalid),
		.S_AXI_WREADY(s00_axi_wready),
		.S_AXI_BRESP(s00_axi_bresp),
		.S_AXI_BVALID(s00_axi_bvalid),
		.S_AXI_BREADY(s00_axi_bready),
		.S_AXI_ARADDR(s00_axi_araddr),
		.S_AXI_ARPROT(s00_axi_arprot),
		.S_AXI_ARVALID(s00_axi_arvalid),
		.S_AXI_ARREADY(s00_axi_arready),
		.S_AXI_RDATA(s00_axi_rdata),
		.S_AXI_RRESP(s00_axi_rresp),
		.S_AXI_RVALID(s00_axi_rvalid),
		.S_AXI_RREADY(s00_axi_rready)
	);

	// Add user logic here

	fir8_v1_0 #(
  .pw_io_width(param_io_width),
  .pw_io_decimal(param_io_decimal),
  .pw_coeff_decimal(param_coeff_decimal)
  ) FIR8 (
  .clk(s00_axi_aclk),
  .rstn(s00_axi_aresetn),
  .ce(cen),
  .isp_coeff_0(coeff0),
  .isp_coeff_1(coeff1),
  .isp_coeff_2(coeff2),
  .isp_coeff_3(coeff3),
  .isp_coeff_4(coeff4),
  .isp_coeff_5(coeff5),
  .isp_coeff_6(coeff6),
  .isp_coeff_7(coeff7),
  .isp_coeff_8(coeff8),
  .isp_in(in_data),
  .osp_out(out_data)
  );

	// User logic ends

	endmodule
