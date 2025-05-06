********************************************************************************************************************;
* Project: A mathematical model for detecting aberrant protein-protein interactions
* Program: SIM_06_DotPlotD_19Feb2025_KKK.sas
* Objective: Creation of a dot plot for ABS_D_HAT
* Author: Kenta Kevee Kisai
* SAS version: 9.4
* Platform: Windows
* Made: 2 September 2024
* Update: 19 February 2025
* Note: 
********************************************************************************************************************;    
/* 3_LOG */
proc printto log = 'YOUR_PATH_TO_DIRECTORY\3_LOG\SIM_06_DotPlotD_19Feb2025_KKK.txt' new;
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
	* Input: MAP
	* Output: None
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
data MAP;
	input ID:$10. VALUE:$8. MARKERCOLOR:$20. MARKERSYMBOL:$20. MARKERSIZE:8.;
	datalines;
		MONO NE black plus 8
		MONO X1 black circle 8
		MONO X2 black square 8
		MONO X3 black triangle 8
		COLO NE black plus 8
		COLO X1 darkred circle 8
		COLO X2 darkblue circle 8
		COLO X3 darkgreen circle 8
run;

* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
* Create a colour scale dot plot
	* Input: ADS.SIM_EOD_SNR_&NMB. 
	* Output: None
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
/* Scenario 1 */
data POD;
	set ADS.SIM_EOD_SNR_01;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 1';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 2 */
data POD;
	set ADS.SIM_EOD_SNR_02;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 2';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 3 */
data POD;
	set ADS.SIM_EOD_SNR_03;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 3';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 4 */
data POD;
	set ADS.SIM_EOD_SNR_04;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 4';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 5 */
data POD;
	set ADS.SIM_EOD_SNR_05;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 5';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 6 */
data POD;
	set ADS.SIM_EOD_SNR_06;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 6';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 7 */
data POD;
	set ADS.SIM_EOD_SNR_07;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 7';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 8 */
data POD;
	set ADS.SIM_EOD_SNR_08;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 8';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 9 */
data POD;
	set ADS.SIM_EOD_SNR_09;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 9';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 10 */
data POD;
	set ADS.SIM_EOD_SNR_10;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 10';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 11 */
data POD;
	set ADS.SIM_EOD_SNR_11;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 11';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 12 */
data POD;
	set ADS.SIM_EOD_SNR_12;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 12';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 13 */
data POD;
	set ADS.SIM_EOD_SNR_13;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 13';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 14 */
data POD;
	set ADS.SIM_EOD_SNR_14;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 14';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 15 */
data POD;
	set ADS.SIM_EOD_SNR_15;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 15';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 16 */
data POD;
	set ADS.SIM_EOD_SNR_16;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 16';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 17 */
data POD;
	set ADS.SIM_EOD_SNR_17;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 17';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 18 */
data POD;
	set ADS.SIM_EOD_SNR_18;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 18';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 19 */
data POD;
	set ADS.SIM_EOD_SNR_19;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 19';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 20 */
data POD;
	set ADS.SIM_EOD_SNR_20;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 20';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 21 */
data POD;
	set ADS.SIM_EOD_SNR_21;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 21';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 22 */
data POD;
	set ADS.SIM_EOD_SNR_22;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 22';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 23 */
data POD;
	set ADS.SIM_EOD_SNR_23;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;
	keylegend / title = 'Scenario 23';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 24 */
data POD;
	set ADS.SIM_EOD_SNR_24;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 24';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 25 */
data POD;
	set ADS.SIM_EOD_SNR_25;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 25';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 26 */
data POD;
	set ADS.SIM_EOD_SNR_26;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 26';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 27 */
data POD;
	set ADS.SIM_EOD_SNR_27;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 27';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 28 */
data POD;
	set ADS.SIM_EOD_SNR_28;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 28';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 29 */
data POD;
	set ADS.SIM_EOD_SNR_29;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;
	xaxis min = 0.0 max = 10.0;
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 29';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 30 */
data POD;
	set ADS.SIM_EOD_SNR_30;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 30';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 31 */
data POD;
	set ADS.SIM_EOD_SNR_31;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 31';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 32 */
data POD;
	set ADS.SIM_EOD_SNR_32;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 32';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 33 */
data POD;
	set ADS.SIM_EOD_SNR_33;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 33';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 34 */
data POD;
	set ADS.SIM_EOD_SNR_34;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 34';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 35 */
data POD;
	set ADS.SIM_EOD_SNR_35;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 35';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 36 */
data POD;
	set ADS.SIM_EOD_SNR_36;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 36';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 37 */
data POD;
	set ADS.SIM_EOD_SNR_37;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 37';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 38 */
data POD;
	set ADS.SIM_EOD_SNR_38;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 38';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 39 */
data POD;
	set ADS.SIM_EOD_SNR_39;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 39';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 40 */
data POD;
	set ADS.SIM_EOD_SNR_40;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 40';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 41 */
data POD;
	set ADS.SIM_EOD_SNR_41;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 41';
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 42 */
data POD;
	set ADS.SIM_EOD_SNR_42;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 42';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 43 */
data POD;
	set ADS.SIM_EOD_SNR_43;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 43';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 44 */
data POD;
	set ADS.SIM_EOD_SNR_44;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 44';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 45 */
data POD;
	set ADS.SIM_EOD_SNR_45;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 45';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 46 */
data POD;
	set ADS.SIM_EOD_SNR_46;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;	
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;	
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 46';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 47 */
data POD;
	set ADS.SIM_EOD_SNR_47;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;
	xaxis min = 0.0 max = 10.0;	
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 47';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;
/* Scenario 48 */
data POD;
	set ADS.SIM_EOD_SNR_48;
run;
proc sort data = POD;
	by MPE;
run;
proc sgplot data = POD dattrmap = MAP;
	scatter x = ABS_D_HAT y = GROUP_D / group = MPE attrid = COLO jitter;
	xaxis min = 0.0 max = 10.0;
	refline 2.0 / axis = x;	
	yaxis display = none;	
	keylegend / title = 'Scenario 48';	
	ods pdf file = 'YOUR_PATH_TO_DIRECTORY\5_TLF\SIM_06_DotPlotD_19Feb2025_KKK.pdf';
run;









