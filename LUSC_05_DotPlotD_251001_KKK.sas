********************************************************************************************************************;
* Project: Model-based quantification of protein-protein interaction aberrations 
					for exploring dysregulated signalling pathways through pathway maps and gene expression levels
* Program: LUSC_05_DotPlotD_251001_KKK.sas
* Objective: Creation of dot plots for ABS_D_HAT
* Author: Kenta Kevee Kisai
* SAS version: 9.4
* Platform: Windows
* Made: 7 July 2024
* Update: 1 October 2025
* Note: 
********************************************************************************************************************;    
/* 3_LOG */
proc printto log = 'YOUR_PATH_TO_DIRECTORY\3_LOG\LUSC_05_DotPlotD_251001_KKK.txt' new;
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
* Create an attribute map
	* Input: None
	* Output: MAP
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
data MAP;
	input ID:$10. VALUE:$8. MARKERCOLOR:$20. MARKERSYMBOL:$20. MARKERSIZE:8.;
	datalines;
		MONO Dummy black circle 11
		COLO Dummy darkblue circle 11
run;

* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
* Create a greyscale dot plot
	* Input: MAP and TLF.LUSC_EOD
	* Output: None
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
data EOD;
	set TLF.LUSC_EOD;
  		GROUP = 'Dummy';
run;
proc sgplot data = EOD dattrmap = MAP;
	scatter x = ABS_D_HAT y = GROUP / group = GROUP attrid = MONO jitter;
	xaxis label = '|d^|';
	yaxis display = none;
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\LUSC_05_DotPlotD_251001_KKK.pdf';
run;

* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
* Create a colour scale dot plot
	* Input: MAP and TLF.LUSC_EOD
	* Output: None
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
data EOD;
	set TLF.LUSC_EOD;
  		GROUP = 'Dummy';
run;
proc sgplot data = EOD dattrmap = MAP;
	scatter x = ABS_D_HAT y = GROUP / group = GROUP attrid = COLO jitter;
	xaxis label = '|d^|';
	yaxis display = none;
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\LUSC_05_DotPlotD_251001_KKK.pdf';
run;





