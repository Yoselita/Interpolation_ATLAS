# Interpolation_ATLAS
Scripts used for the conservative interpolation of the CORDEX files done for ATLAS

All the raw model outputs used in ATLAS from the CMIP5, CMIP6 and CODEX experiments have been interpolated to a common grid using the fist order conservative remapping with cdo (https://code.mpimet.mpg.de/projects/cdo/) .
CMIP5 data have been interpolated to the 2 degree common grid: https://github.com/IPCC-WG1/Atlas/blob/master/reference-grids/land_sea_mask_2degree_binary.nc4
CMIP6 data have been interpolated to the 1 degree common grid: https://github.com/IPCC-WG1/Atlas/blob/master/reference-grids/land_sea_mask_1degree_binary.nc4
CORDEX data have been interpolated to the 0.5 degree common grid: https://github.com/IPCC-WG1/Atlas/blob/master/reference-grids/land_sea_mask_05degree.nc4

The scripts used for interpolation of CMIP6 ocean (https://gitlab.com/Yoselita/interpolation/-/blob/master/CMIP6/CMIP6_Omon_remap.sh) and CODEX data (https://gitlab.com/Yoselita/interpolation/-/blob/master/CORDEX/CORDEX_remap.sh) follow guidelines for the interpolation coordinated within the CORDEX community.
Certain raw model grids were missing information on the coordinates of grid corners for each grid cell, necessary for the conservative interpolation ( e.g. ALADIN, ALARO, NCAR-WRF and RegCM4 ). In such cases a python script grid_bounds_calc.py, provided by Caillaud Cécile (cecile.caillaud@meteo.fr) and Samuel Somot (samuel.somot@meteo.fr) from Meteo France, were used to fill the info gap.
