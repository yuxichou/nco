/* $Header: /data/zender/nco_20150216/nco/src/nco/nco_cnv_arm.h,v 1.11 2006-01-31 06:42:11 zender Exp $ */

/* Purpose: ARM conventions */

/* Copyright (C) 1995--2006 Charlie Zender
   This software may be modified and/or re-distributed under the terms of the GNU General Public License (GPL) Version 2
   See http://www.gnu.ai.mit.edu/copyleft/gpl.html for full license text */

/* Usage:
   #include "nco_cnv_arm.h" *//* ARM conventions */

#ifndef NCO_CNV_ARM_H
#define NCO_CNV_ARM_H

/* Standard header files */
#include <stdio.h> /* stderr, FILE, NULL, printf */
#include <string.h> /* strcmp. . . */

/* 3rd party vendors */
#include <netcdf.h> /* netCDF definitions and C library */
#include "nco_netcdf.h" /* NCO wrappers for netCDF C library */

/* Personal headers */
#include "nco.h" /* netCDF Operator (NCO) definitions */
#include "nco_att_utl.h" /* Attribute utilities */
#include "nco_mmr.h" /* Memory management */

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

bool /* O [flg] File obeys ARM conventions */
arm_inq /* O [fnc] Check if file obeys ARM conventions */
(const int nc_id); /* I [id] netCDF file ID */

double /* O [s] base_time + current time_offset */ 
arm_time_mk /* [fnc] Return time corresponding to current time offset */
(const int nc_id, /* I [id] netCDF file ID */
 const double time_offset); /* I [s] Current time offset */

void
nco_arm_time_install /* [fnc] Add time variable to concatenated ARM files */
(const int nc_id, /* I [id] netCDF file ID */
 const nco_int base_time_srt); /* I [s] base_time of first input file */

nco_int /* O [s] Value of base_time variable */
arm_base_time_get /* [fnc] Get base_time variable from ARM file */
(const int nc_id); /* I [id] netCDF file ID */

#ifdef __cplusplus
} /* end extern "C" */
#endif /* __cplusplus */

#endif /* NCO_CNV_ARM_H */
