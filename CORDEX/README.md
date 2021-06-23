The script **CORDEX_remap.sh** was used to perform the interpolation of all CORDEX data used in ATLAS to the common 0.5 degree grid. 

To run the script:
 	
     source CORDEX.remap <CODEX domain name> <variable name>

**Data necessary** to run the interpolation of the CODEX data:
     <details><summary>CORDEX files
     <details><summary>Destination land-sea map to which the raw CORDEX files will be interpolated
     <details><summary>Information on the source grid (txt file that defines a grid of the CORDEX data)- optional
     <details><summary>Land-sea mask of the raw CODEX data - optional

The script has **4 steps**:
     <details><summary>Preparations for the remapping - collecting info on the destination grid and creating neccesary files
     <details><summary>Finding source.grid file – if not find, then the script creates it 
     <details><summary>Script looks for land-sea mask of the corresponding CORDEX model. If found, then land-sea correction will be applied. If not, then basic conservation remapping will be done. 
     <details><summary>Renaming files and moving them to the final output

**NOTE**: source.grid files for all the interpolated CORDEX grids interpoalted for ATLAS are available in the CORDEX_SOURCEGRIDS folder.
