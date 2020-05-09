#  signal_generator_v1_0
 --- 
 **File:** ../../96analogxperience/src/signal_generator_v1_0.v  
**Module name**\: signal_generator_v1_0  
**Author**\: P Trujillo (pablo@controlpaths.com\)  
**Date**\: Mar20  
Description:  
Clock enable generation according prescaler input.  
Revision:  
**1.0**\: Module created.  
### Parameter list  
|**Name**|**Default Value**|**Description**|  
|-|-|-|  
      
### Input list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|clk|[0:0]||  
|rstn|[0:0]||  
|cen|[0:0]||  
      
### Output list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|ors16_signal|[15:0]||  
      
### Wire list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
      
### Register list  
|**Name**|**Width**|**Description**|  
|-|-|-|  
|m16_signal|[15:0][127:0]||  
|r7_data_index|[6:0]||  
      
### Instantiation example 
 ```verilog   
signal_generator_v1_0 signal_generator_v1_0_inst0(  
.clk(),  
.rstn(),  
.cen(),  
.ors16_signal()   
);   
```