#!/bin/bash

##===========================================================================
## After one-ensemble-one-file.sh
## Example: Long-term average of each model globally
##
## Input files like:
## /data/cmip5/snc_LImon_bcc-csm1-1_historical_r1i1p1_185001-200512.nc
## 
## Output files like:
## /data/cmip5/output/snc/snc_LImon_all-mdl_historical_all-nsm_clm.nc
##
## Online: http://nco.sourceforge.net/nco.html#Global-Distribution-of-Long_002dterm-Average
##
## Execute this script: bash global_avg.sh
##===========================================================================

##---------------------------------------------------------------------------
## parameters
drc_in='/home/wenshanw/data/cmip5/'		## directory of input files
drc_out='/home/wenshanw/data/cmip5/output/'	## directory of output files

var=( 'snc' 'snd' )		## variables
rlm='LImon'			## realm
xpt=( 'historical' )		## experiment ( could be more )

fld_out=( 'snc/' 'snd/' )		## folders of output files
##---------------------------------------------------------------------------

for var_id in {0..1}; do	## loop over two variables
	## names of all models (ls [get file names]; cut [get the part for model names]; sort; uniq [remove duplicates]; awk [print])
  mdl_set=$( ls ${drc_in}${var[var_id]}_${rlm}_*_${xpt[0]}_*.nc | cut -d '_' -f 3 | sort | uniq -c | awk '{print $2}' )
  mdl_num=$( echo ${mdl_set} | wc -w )		## number of models (echo [print contents]; wc [count])
  
  for mdl in ${mdl_set}; do				## loop over models
  	## average all the ensemble members of each model
  	ncea -O -4 -d time,"1956-01-01 00:00:0.0","2005-12-31 23:59:9.9" ${drc_in}${var[var_id]}_${rlm}_${mdl}_${xpt[0]}_*.nc ${drc_out}${fld_out[var_id]}${var[var_id]}_${rlm}_${mdl}_${xpt[0]}_all-nsm_195601-200512.nc
  	
  	## average along time
  	ncra -O ${drc_out}${fld_out[var_id]}${var[var_id]}_${rlm}_${mdl}_${xpt[0]}_all-nsm_195601-200512.nc ${drc_out}${fld_out[var_id]}${var[var_id]}_${mdl}.nc
  
  	echo Model ${mdl} done!
  done

	## Remove temporary files to avoid file name confliction
	rm ${drc_out}${fld_out[var_id]}${var[var_id]}*historical*.nc
  
  ## Store models as groups in the output file
  ncecat -O --gag ${drc_out}${fld_out[var_id]}${var[var_id]}_*.nc ${drc_out}${fld_out[var_id]}${var[var_id]}_${rlm}_all-mdl_${xpt[0]}_all-nsm_clm.nc

	echo Var ${var[var_id]} done!
done
