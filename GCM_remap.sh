# This script has been used to interpolate CMPI5 and CMIP6 monthly output from the atmopsheric models.
# To run the script: 
# source GCM_remap.sh <file_to_interpolate> <name_of_the_output> <destination_mask> <source_mask>

#! /bin/bash

datanc=$1
outfile=$2
maskdestnc=$3
masknc=$4

function usage(){
	echo
  	echo "Usage: $(basename $0) data_file.nc outfilename destination_mask.nc data_file_mask.nc"
  	echo
  	echo "Conservative remapping for land and sea points"
  	echo
}

if test ${#} -lt 3; then
	usage
	exit
fi

# Define wheather to use land-sea correction or not. If yes - $masknc needs to be provided
if [ -z "$4" ]; then
	LSMASK=0
else
	LSMASK=1
fi

# If SHARP_CHANGE=1, the treshold land fraction is 0.5 for changing between land and sea, otherwise is 0.999
SHARP_CHANGE=0

# If LSMASK=1, then GAP_FILL needs to be defined. If =1, then nearest neigbours interpolation for gap filling will be applied, 
# othewise by default unconstrained remapping will be applied.
# GAP_FILL=0 

# Global destination grid map - creating weights
cdo -P 4 gencon,${maskdestnc} -seltimestep,1 ${datanc} weights.nc

# Make input landmask binary if $4 has been given
if test "${LSMASK}" -eq 1; then
	if test "${SHARP_CHANGE}" -eq 1; then
		# Change at 0.5 land fraction
		cdo -setrtoc,-1,0.5,0 -setrtoc,0.5,2,1 ${masknc} maskland.nc
		cdo mulc,0.5 -setmisstoc,1 -setrtoc,-0.5,0.5,2 maskland.nc masksea.nc
	else
		# Change at 0.999 land fraction
		cdo -setrtoc,-1,0.999,0 -setrtoc,0.999,2,1 ${masknc} maskland.nc
		cdo mulc,-1 -setrtoc,0.001,2,0 -setrtoc,-1,0.001,-1 ${masknc} masksea.nc
	fi
fi

if test "${LSMASK}" -eq 1; then
  	cdo div ${datanc} -setctomiss,0 maskland.nc land.nc  
  	cdo div ${datanc} -setctomiss,0 masksea.nc sea.nc 
  	cdo -P 4 gencon,${maskdestnc} land.nc weight_land.nc
  	cdo -P 4 gencon,${maskdestnc} sea.nc  weight_sea.nc
  	cdo remap,${maskdestnc},weight_land.nc land.nc landr.nc
  	cdo remap,${maskdestnc},weight_sea.nc sea.nc sear.nc
  	cdo ifthenelse -setmisstoc,0 ${maskdestnc} landr.nc sear.nc merged.nc
	if test "${GAP_FILL}" -eq 1; then
  	# Fill the gaps between land and sea by nearest neigbours
		cdo setmisstonn landr.nc landrfilled.nc
		cdo setmisstonn sear.nc searfilled.nc
		cdo ifthenelse -setmisstoc,0 ${maskdestnc} landrfilled.nc searfilled.nc ${outfile}
	else
  	# Fill the gaps between land and sea with unconstrained remapping (doremap preferred option)
  	cdo setmisstoc,1 -setrtoc,-9999999,9999999,0 merged.nc gaps.nc
  	cdo remap,${maskdestnc},weights.nc ${datanc} unconstrained.nc
  	cdo ifthenelse gaps.nc unconstrained.nc merged.nc ${outfile}
	fi
else
  cdo remap,${maskdestnc},weights.nc ${datanc} ${outfile}
fi
