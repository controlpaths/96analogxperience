#  dacx0004_driver_v2_0
 --- 
 **File:** ../../96analogxperience/src/dacx0004_driver_v2_0.v  
**Module name**\: dacx0004_driver_v2_0  
**Author**\: P Trujillo (pablo@controlpaths.com\)  
**Date**\: Dec 2019  
Description:  
Driver for DACx0004. 96AnalogXperience  
Revision:  
**1.0**\: Module created.  
**2.0**\: When CE is asserted, all channels are write.  
Input now are signed.  
### Parameter list  
|**Name**|**Default Value**|**Description**|  
|-|-|-|  
      
### Input list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|clk100mhz|[0:0]||  
|rstn|[0:0]||  
|ce|[0:0]||  
|is16_data_ch0|[15:0]||  
|is16_data_ch1|[15:0]||  
|is16_data_ch2|[15:0]||  
|is16_data_ch3|[15:0]||  
      
### Output list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|o_sdo|[0:0]||  
|or_sck|[0:0]||  
|or_cs|[0:0]||  
|or_nldac|[0:0]||  
      
### Wire list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|w_busy_spi|[0:0]||  
|w32x6_config_regs [0:5]|[31:0]||  
|w16_data_ch0|[15:0]||  
|w16_data_ch1|[15:0]||  
|w16_data_ch2|[15:0]||  
|w16_data_ch3|[15:0]||  
      
### Register list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|r4_dac_state|[3:0]||  
|r32_data_out|[31:0]||  
|r2_ch_select|[1:0]||  
|r_spi_start|[0:0]||  
|r4_spi_state|[3:0]||  
|r5_data_counter|[4:0]|SPI data counter (32 bits)|  
|r5_counter_sync|[4:0]||  
|r3_counter_nldac|[2:0]||  
|r3_index_config|[2:0]||  
      
### Instantiation example 
 ```verilog   
dacx0004_driver_v2_0 dacx0004_driver_v2_0_inst0(  
.clk100mhz(),  
.rstn(),  
.ce(),  
.is16_data_ch0(),  
.is16_data_ch1(),  
.is16_data_ch2(),  
.is16_data_ch3(),  
.o_sdo(),  
.or_sck(),  
.or_cs(),  
.or_nldac()   
);   
```