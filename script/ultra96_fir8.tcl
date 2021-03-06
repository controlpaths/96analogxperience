## Shared memory between microblaze and hdl for share parameters.
## Digital tav

set projectDir ../project
set projectName ultra96_fir8
set bdName ultra96_fir8
set bdNameWrapper ultra96_fir8_wrapper

## Delete log and journal
file delete {*}[glob vivado*.backup.jou]
file delete {*}[glob vivado*.backup.log]
file delete -force .Xil/

## Create project in ../project
create_project -force $projectDir/$projectName.xpr

## Set verilog as default language
set_property target_language Verilog [current_project]

## Adding verilog files
add_file [glob ../src/*.v]

## Add memory files
add_file ../memory_content/signal3.mem

## Adding constraints files
read_xdc ../xdc/96analogXperience_constraints.xdc

## Set current board. Minzed
set_property BOARD_PART em.avnet.com:ultra96v2:part0:1.0 [current_project]

## Create block design
create_bd_design $bdName

## Add ip repo
set_property ip_repo_paths {../ip_repo} [current_project]
update_ip_catalog

## Configure block design through external file
source ./bd/ultra96_fir8_bd.tcl

## Regenerate block design layout
regenerate_bd_layout

## Validate block design design
validate_bd_design

## Generate and add wrapper file for synthesis
make_wrapper -files [get_files $projectDir/$projectName.srcs/sources_1/bd/$bdName/$bdName.bd] -top
add_files -norecurse $projectDir/$projectName.srcs/sources_1/bd/$bdName/hdl/$bdNameWrapper.v

## Open vivado for verify
start_gui
