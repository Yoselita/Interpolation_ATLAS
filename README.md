# Interpolation ATLAS
Scripts used for the conservative interpolation of the CORDEX files done for ATLAS

All the raw model outputs used in ATLAS from the CMIP5, CMIP6 and CODEX experiments have been interpolated to a common grid using the fist order conservative remapping with [cdo](https://code.mpimet.mpg.de/projects/cdo/)

CMIP5 data have been interpolated to the 2 degree common grid: [land_sea_mask_2degree_binary.nc4](https://github.com/IPCC-WG1/Atlas/blob/master/reference-grids/land_sea_mask_2degree_binary.nc4) with [GCM_remap.sh](https://github.com/Yoselita/Interpolation_ATLAS/blob/master/GCM_remap.sh).

CMIP6 data have been interpolated to the 1 degree common grid: [land_sea_mask_1degree_binary.nc4](https://github.com/IPCC-WG1/Atlas/blob/master/reference-grids/land_sea_mask_1degree_binary.nc4), atmospheric data with [GCM_remap.sh](https://github.com/Yoselita/Interpolation_ATLAS/blob/master/GCM_remap.sh) and the outputs from the ocean models [CMIP6_Omon_remap.sh](https://github.com/Yoselita/Interpolation_ATLAS/blob/master/CMIP6_Omon/CMIP6_Omon_remap.sh).

CORDEX data have been interpolated to the 0.5 degree common grid: [land_sea_mask_05degree.nc](https://github.com/IPCC-WG1/Atlas/blob/master/reference-grids/land_sea_mask_05degree.nc4) with [CORDEX_remap.sh](https://github.com/Yoselita/Interpolation_ATLAS/blob/master/CORDEX/CORDEX_remap.sh).

All the scripts used for the interpolation follow guidelines for the interpolation coordinated within the CORDEX community.

Certain raw model grids from the CORDEX experiment were missing information on the coordinates of the grid corners for each grid cell - necessary for the conservative interpolation (e.g. ALADIN, ALARO, NCAR-WRF and RegCM4). In such cases a python script grid_bounds_calc.py, based on the script provided by Caillaud Cécile (cecile.caillaud@meteo.fr) and Samuel Somot (samuel.somot@meteo.fr) from Meteo France, were used to fill the info gap.
