The script **CMIP6_remap.sh** was used to perform the interpolation of all montlhy CMIP6 ocean monthly data (variables siconc, ph, and tos) data used in ATLAS to the common grid at 1 degree resolution.

**To run the script:**
	 
	 source CMIP6_Omon_remap.sh <variable_name>

**Conservative interpolation for CMIP6 ocean model outputs:**
 The data are interpolated on 1 degree regular grid, using 1st order conservative remapping. 
 The Climate Data Operator (CDO) software is used for the inteprolation.
 The procedure:
 2 files used for this step:
 <details><summary>1. destination_mask - for CMIP6_Omon data land_sea_mask_1degree.nc4 was used
 <details><summary>2. source_file - a CMPI6_Omon netcdf file to be interpolated

	Basic interpolation procedure:
		cdo griddes [destination_mask] > destination.grid
		cdo cdo gencon,destination.grid [source_file] weights.nc
		cdo remap,destination.grid,weights.nc -selname,[variable_name] [source_file] file_interpolated.nc

**********************************************************************************************************************************

**Alternative procedure for interpolating CMIP6 ocean model outputs:**
This procedure was applied to interpolate the CMIP6 outputs from the ocean models that have irregular grids which crashed due to lack of informations when using the basic conservative interpolation described above.
The data for the crashed models were interpolated on the finer grid (0.5 degree - 360x720) using distance-weighted average remapping (remapdis) in order to get the data on the regular grid. The finer grid was chosen in order to 
lose as less information as possible.
Files used for this step:
<details><summary>1. destination_mask_05 - land_sea_mask_05degree.nc4
<details><summary>2. destination_mask_1  - land_sea_mask_1degree.nc4
<details><summary>3. source_file - a CMPI6_Omon netcdf file to be interpolated

	Interpolation procedure:
		cdo griddes [destination_mask_05] > destination_05degree.grid
		cdo griddes [destination_mask_1] > destination_1degree.grid
		cdo remapdis,destination_05degree.grid [source_file] intermediate_file.nc
		cdo gencon,destination_1degress.grid intermediate_file.nc weights.nc
		cdo remap,destination_1degress.grid,weights.nc -selname,tos intermediate_file.nc file_interpolated.nc

**********************************************************************************************************************************

**NOTE:**
The script also performs final masking of all the interpolated data to a common land-sea mask if wanted.
In that case, additional information on the full path to the common land-sea mask needs to be provided by a user. 
For ATLAS land_sea_mask_1degree.nc4 was use for the final masking.
