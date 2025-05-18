********************************************************************************************************************;
* Project: Model-based detection of aberrant protein-protein interactions 
					for exploration of aberrant signalling pathways 
					through pathway maps and gene expression levels
* Program: LUSC_05_DotPlotD_4May2025_KKK.sas
* Objective: Creation of a dot plot for ABS_D_HAT
* Author: Kenta Kevee Kisai
* SAS version: 9.4
* Platform: Windows
* Made: 7 July 2024
* Update: 4 May 2025
* Note: 
********************************************************************************************************************;    
/* 3_LOG */
proc printto log = 'YOUR_PATH_TO_DIRECTORY\3_LOG\LUSC_05_DotPlotD_4May2025_KKK.txt' new;
run;
/* 4_ADS */
libname ADS 'YOUR_PATH_TO_DIRECTORY\4_ADS';
/* 5_TLF */
libname TLF 'YOUR_PATH_TO_DIRECTORY\5_TLF';
/* Execution time */
data _null_;
	option timezone = 'asia/tokyo';
	datetime = datetime ();
	put datetime nldatm.; 
run;

* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
* Create an attribute map dataset
	* Input: None
	* Output: MAP
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
data MAP;
	input ID:$10. VALUE:$8. MARKERCOLOR:$20. MARKERSYMBOL:$20. MARKERSIZE:8.;
	datalines;
		MONO Aberrant black circle 11
		MONO Normal black circle 11
		COLO Aberrant darkred circle 11
		COLO Normal darkblue circle 11
run;

* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
* Create a greyscale dot plot
	* Input: MAP, TLF.LUSC_EOD
	* Output: None
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
proc sgplot data = TLF.LUSC_EOD dattrmap = MAP;
	scatter x = ABS_D_HAT y = AON / group = AON attrid = MONO jitter;
	xaxis label = '|d^|';
	yaxis display = none;
	keylegend / title = 'Distinction between aberrant and normal interactions';
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\LUSC_05_DotPlotD_4May2025_KKK.pdf';
run;

* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
* Create a colour scale dot plot
	* Input: MAP, TLF.LUSC_EOD
	* Output: None
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
proc sgplot data = TLF.LUSC_EOD dattrmap = MAP;
	scatter x = ABS_D_HAT y = AON / group = AON attrid = COLO jitter;
	xaxis label = '|d^|';
	yaxis display = none;
	keylegend / title = 'Distinction between aberrant and normal interactions';
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\LUSC_05_DotPlotD_4May2025_KKK.pdf';
run;





