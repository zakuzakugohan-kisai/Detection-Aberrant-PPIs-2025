********************************************************************************************************************;
* Project: Model-based quantification of protein-protein interaction aberrations 
					for exploring dysregulated signalling pathways through pathway maps and gene expression levels
* Program: SIM_07_ForestPlotPM_24Feb2025_KKK.sas
* Objective: Creation of forest plots for performance measures
* Author: Kenta Kevee Kisai
* SAS version: 9.4
* Platform: Windows
* Made: 30 January 2025
* Update: 24 February 2025
* Note: 
********************************************************************************************************************;    
/* 3_LOG */
proc printto log = 'YOUR_PATH_TO_DIRECTORY\3_LOG\SIM_07_ForestPlotPM_24Feb2025_KKK.txt' new;
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
* Create a dataset for plotting
	* Input: None
	* Output: POS
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
data POS;
	input SCENARIO $ BIAS_Q1 BIAS_Q2 BIAS_Q3 DET NE X1 X2 X3 VHAT;
	datalines;
		1 -0.002 0.000 0.002 7.0 0.1 74.5 0.0 25.5 0.0
		2 -0.002 0.000 0.002 91.5 0.0 94.7 0.0 5.3 0.0
		3 -0.002 0.000 0.003 100.0 0.0 99.8 0.0 0.2 0.0
		4 -0.011 0.000 0.009 6.6 2.5 82.6 3.1 14.4 0.0
		5 -0.012 -0.003 0.009 10.5 2.6 84.2 2.9 12.9 0.0
		6 -0.013 -0.002 0.012 83.4 5.0 96.3 1.8 1.9 0.0
		7 -0.004 0.000 0.003 6.3 0.0 0.0 62.4 37.6 0.0
		8 -0.004 0.000 0.003 69.8 0.0 0.0 83.9 16.1 0.0
		9 -0.004 0.000 0.004 100.0 0.0 0.0 100.0 0.0 0.0
		10 -0.012 0.000 0.010 16.8 15.9 3.2 91.8 5.0 0.0
		11 -0.015 -0.002 0.009 18.6 16.8 2.0 92.1 5.9 0.0
		12 -0.031 -0.012 0.006 56.4 19.3 1.4 82.4 16.2 0.0
		13 -0.002 0.000 0.002 12.7 6.0 100.0 0.0 0.0 0.0
		14 -0.002 0.000 0.002 93.9 6.6 100.0 0.0 0.0 0.0
		15 -0.002 0.000 0.002 100.0 8.9 99.7 0.2 0.1 0.0
		16 -0.007 0.000 0.009 41.6 38.2 99.7 0.0 0.3 0.0
		17 -0.009 -0.001 0.008 44.9 38.4 99.2 0.2 0.6 0.0
		18 -0.015 -0.005 0.004 93.4 38.6 99.0 0.0 1.0 0.0
		19 -0.002 0.000 0.002 24.2 18.6 0.1 99.1 0.7 0.1
		20 -0.002 0.000 0.002 92.2 19.2 0.0 100.0 0.0 0.0
		21 -0.003 -0.001 0.002 100.0 20.9 0.0 100.0 0.0 0.0
		22 -0.009 0.000 0.008 17.8 12.8 1.0 97.9 1.0 0.9
		23 -0.010 -0.001 0.006 20.6 12.6 1.4 98.3 0.3 1.1
		24 -0.016 -0.006 0.004 91.9 12.5 0.9 99.1 0.0 0.6
		25 -0.001 0.000 0.001 5.0 0.0 64.8 0.0 35.2 0.0
		26 -0.001 0.000 0.001 100.0 0.0 92.8 0.0 7.2 0.0
		27 -0.001 0.000 0.001 100.0 0.0 100.0 0.0 0.0 0.0
		28 -0.003 0.002 0.006 5.2 0.6 75.2 0.1 24.7 0.0
		29 -0.021 -0.004 0.001 31.7 0.0 69.4 0.0 30.6 0.0
		30 -0.006 0.000 0.006 100.0 0.0 98.5 0.0 1.5 0.0
		31 -0.001 0.000 0.002 5.1 0.0 0.0 53.9 46.1 0.0
		32 -0.001 0.000 0.001 100.0 0.0 0.0 89.7 10.3 0.0
		33 -0.002 0.000 0.002 100.0 0.2 0.0 100.0 0.0 0.0
		34 -0.007 -0.001 0.006 5.9 2.4 0.1 97.1 2.8 0.0
		35 -0.006 -0.001 0.006 16.0 2.8 0.1 97.2 2.7 0.0
		36 -0.137 -0.009 0.002 99.9 2.9 0.5 70.8 28.7 0.0
		37 -0.001 0.000 0.001 5.5 0.0 100.0 0.0 0.0 0.0
		38 -0.001 0.000 0.001 100.0 0.0 100.0 0.0 0.0 0.0
		39 -0.001 0.000 0.001 100.0 0.3 100.0 0.0 0.0 0.0
		40 -0.004 0.000 0.004 27.6 24.0 100.0 0.0 0.0 0.0
		41 -0.004 0.000 0.004 50.0 24.2 100.0 0.0 0.0 0.0
		42 -0.007 -0.002 0.003 100.0 29.3 99.2 0.0 0.8 0.0
		43 -0.001 0.000 0.001 8.5 2.9 0.0 99.9 0.1 0.1
		44 -0.001 0.000 0.001 100.0 4.0 0.0 100.0 0.0 0.1
		45 -0.002 0.000 0.001 100.0 12.0 0.0 100.0 0.0 0.0
		46 -0.005 0.000 0.004 17.9 12.9 0.0 99.0 1.0 1.0
		47 -0.005 -0.001 0.004 37.1 11.7 0.2 99.3 0.5 0.6
		48 -0.007 -0.002 0.003 99.9 10.8 0.0 100.0 0.0 0.0
		;
run;
data POS;
	set POS;
		_BIAS_Q1 = 'Q1';
		_BIAS_Q2 = 'Bias';
		_BIAS_Q3 = 'Q3';	
		_DET = 'Detection (%)';
		_NE = 'Non-estimation (%)';
		_X1 = 'Model X1 (%)';
		_X2 = 'Model X2 (%)';
		_X3 = 'Model X3 (%)';
		_VHAT = 'V^ = 0 (%)';
run;
 
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
* Create forest plots for performance measures
	* Input: POS
	* Output: None
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
/* Bias */
ods graphics / reset = index imagename = 'Bias_24Feb2025_KKK' outputfmt = png;
ods listing gpath = 'YOUR_PATH_TO_DIRECTORY\5_TLF';
	ods graphics / height = 10 in width = 10 in;
	proc sgplot data = POS noautolegend;
		format BIAS_Q1 BIAS_Q2 BIAS_Q3 6.3;
		scatter y = SCENARIO x = BIAS_Q2 / xerrorlower = BIAS_Q1 xerrorupper = BIAS_Q3 markerattrs = (symbol = squarefilled);
		scatter y = SCENARIO x = _BIAS_Q2 / markerchar = BIAS_Q2 x2axis;
		scatter y = SCENARIO x = _BIAS_Q1 / markerchar = BIAS_Q1 x2axis;
		scatter y = SCENARIO x = _BIAS_Q3 / markerchar = BIAS_Q3 x2axis;
		refline -0.02 0 0.02 / axis = x;
		refline -0.015 -0.010 -0.005 0.005 0.010 0.015 / axis = x lineattrs = (pattern = shortdash);
		xaxis offsetmin = 0.01 offsetmax = 0.35 min = -0.020 max = 0.020 display = (nolabel);
		x2axis offsetmin = 0.7 display = (noticks nolabel);
		yaxis offsetmin = 0.05 offsetmax = 0.05 display = (noticks nolabel) reverse;
	run;
ods listing close;
ods graphics / reset = all;

/* Detection proportion */
ods graphics / reset = index imagename = 'Detection_24Feb2025_KKK' outputfmt = png;
ods listing gpath = 'YOUR_PATH_TO_DIRECTORY\5_TLF';
	ods graphics / height = 10 in width = 10 in;
	proc sgplot data = POS noautolegend;
		format DET 6.1;
		scatter y = SCENARIO x = DET / markerattrs = (symbol = squarefilled);
		scatter y = SCENARIO x = _DET / markerchar = DET x2axis;
		refline 0 100 / axis = x;
		refline 20 40 60 80 / axis = x lineattrs = (pattern = shortdash);
		xaxis offsetmin = 0.01 offsetmax = 0.35 min = 0 max = 100 display = (nolabel);
		x2axis offsetmin = 0.7 display = (noticks nolabel);
		yaxis offsetmin = 0.05 offsetmax = 0.05 display = (noticks nolabel) reverse;
	run;
ods listing close;
ods graphics / reset = all;

/* Non-estimation */
ods graphics / reset = index imagename = 'Non-estimation_24Feb2025_KKK' outputfmt = png;
ods listing gpath = 'YOUR_PATH_TO_DIRECTORY\5_TLF';
	ods graphics / height = 10 in width = 10 in;
	proc sgplot data = POS noautolegend;
		format NE 6.1;
		scatter y = SCENARIO x = NE / markerattrs = (symbol = squarefilled);
		scatter y = SCENARIO x = _NE / markerchar = NE x2axis;
		refline 0 100 / axis = x;
		refline 20 40 60 80 / axis = x lineattrs = (pattern = shortdash);
		xaxis offsetmin = 0.01 offsetmax = 0.35 min = 0 max = 100 display = (nolabel);
		x2axis offsetmin = 0.7 display = (noticks nolabel);
		yaxis offsetmin = 0.05 offsetmax = 0.05 display = (noticks nolabel) reverse;
	run;
ods listing close;
ods graphics / reset = all;

/* Model X1 */
ods graphics / reset = index imagename = 'ModelX1_24Feb2025_KKK' outputfmt = png;
ods listing gpath = 'YOUR_PATH_TO_DIRECTORY\5_TLF';
	ods graphics / height = 10 in width = 10 in;
	proc sgplot data = POS noautolegend;
		format X1 6.1;
		scatter y = SCENARIO x = X1 / markerattrs = (symbol = squarefilled);
		scatter y = SCENARIO x = _X1 / markerchar = X1 x2axis;
		refline 0 100 / axis = x;
		refline 20 40 60 80 / axis = x lineattrs = (pattern = shortdash);
		xaxis offsetmin = 0.01 offsetmax = 0.35 min = 0 max = 100 display = (nolabel);
		x2axis offsetmin = 0.7 display = (noticks nolabel);
		yaxis offsetmin = 0.05 offsetmax = 0.05 display = (noticks nolabel) reverse;
	run;
ods listing close;
ods graphics / reset = all;

/* Model X2 */
ods graphics / reset = index imagename = 'ModelX2_24Feb2025_KKK' outputfmt = png;
ods listing gpath = 'YOUR_PATH_TO_DIRECTORY\5_TLF';
	ods graphics / height = 10 in width = 10 in;
	proc sgplot data = POS noautolegend;
		format X2 6.1;
		scatter y = SCENARIO x = X2 / markerattrs = (symbol = squarefilled);
		scatter y = SCENARIO x = _X2 / markerchar = X2 x2axis;
		refline 0 100 / axis = x;
		refline 20 40 60 80 / axis = x lineattrs = (pattern = shortdash);
		xaxis offsetmin = 0.01 offsetmax = 0.35 min = 0 max = 100 display = (nolabel);
		x2axis offsetmin = 0.7 display = (noticks nolabel);
		yaxis offsetmin = 0.05 offsetmax = 0.05 display = (noticks nolabel) reverse;
	run;
ods listing close;
ods graphics / reset = all;

/* Model X3 */
ods graphics / reset = index imagename = 'ModelX3_24Feb2025_KKK' outputfmt = png;
ods listing gpath = 'YOUR_PATH_TO_DIRECTORY\5_TLF';
	ods graphics / height = 10 in width = 10 in;
	proc sgplot data = POS noautolegend;
		format X3 6.1;
		scatter y = SCENARIO x = X3 / markerattrs = (symbol = squarefilled);
		scatter y = SCENARIO x = _X3 / markerchar = X3 x2axis;
		refline 0 100 / axis = x;
		refline 20 40 60 80 / axis = x lineattrs = (pattern = shortdash);
		xaxis offsetmin = 0.01 offsetmax = 0.35 min = 0 max = 100 display = (nolabel);
		x2axis offsetmin = 0.7 display = (noticks nolabel);
		yaxis offsetmin = 0.05 offsetmax = 0.05 display = (noticks nolabel) reverse;
	run;
ods listing close;
ods graphics / reset = all;

/* V_HAT */
ods graphics / reset = index imagename = 'VHAT_24Feb2025_KKK' outputfmt = png;
ods listing gpath = 'YOUR_PATH_TO_DIRECTORY\5_TLF';
	ods graphics / height = 10 in width = 10 in;
	proc sgplot data = POS noautolegend;
		format VHAT 6.1;
		scatter y = SCENARIO x = VHAT / markerattrs = (symbol = squarefilled);
		scatter y = SCENARIO x = _VHAT / markerchar = VHAT x2axis;
		refline 0 100 / axis = x;
		refline 20 40 60 80 / axis = x lineattrs = (pattern = shortdash);
		xaxis offsetmin = 0.01 offsetmax = 0.35 min = 0 max = 100 display = (nolabel);
		x2axis offsetmin = 0.7 display = (noticks nolabel);
		yaxis offsetmin = 0.05 offsetmax = 0.05 display = (noticks nolabel) reverse;
	run;
ods listing close;
ods graphics / reset = all;







