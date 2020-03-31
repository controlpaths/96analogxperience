# Repository for 96AnalogXperience
Repository for mezzanine board 96AnalogXperience from controlpaths. The project is shared on hackster.io

## Board file
Board file for EclypseZ7 can be found at Avnet's repository. (https://github.com/Avnet/bdf/tree/master/ultra96v2/1.0).

## Automatic project creation.
Each project has a script associated to him. For create the project, init Vivado in tcl mode, and the execute the selected script.

```
cd scrips/
vivado -mode tcl -source ./eclypsez7_adc_dac_run.tcl
```
## Hardware configuration
Projects in this repository are designed to run in Ultra96 and 96AnalogXperience board.

## Python Script
This repository include several python script:  
 **mem_generator:** for generate .mem files. Files generated by script are saved in */memory_content* directory. This script run in a Jupyter Notebook.
 **axi_fir8_coeff:** This script is designed for run in Pynq for project  ultra96_fir8.

 ## List of projects
 - **96analogxperience.tcl**  
 Basic project for manage the 96AnalogXperience from Pynq.
 - **ultra96_fir8**  
 This project uses the IP axi_fir8_1.0. This IP implements a FIR filter where the 8 coefficients are configured through AXI interface.

## IP Repository   
 This repository includes a ip_repo folder with all the IP needed for re-make projects.
