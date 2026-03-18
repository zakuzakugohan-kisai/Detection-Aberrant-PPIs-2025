********************************************************************************************************************;
* Project: Model-based quantification of protein-protein interaction aberrations 
					for exploring dysregulated signalling pathways through pathway maps and gene expression levels
* Program: SIM_04_CalculationPM_250219_KKK.sas
* Objective: Calculation of performance measures
* Author: Kenta Kevee Kisai
* SAS version: 9.4
* Platform: Windows
* Made: 3 September 2024
* Update: 19 February 2025
* Note: 
********************************************************************************************************************;
/* 3_LOG */
proc printto log = 'YOUR_PATH_TO_DIRECTORY\3_LOG\SIM_04_CalculationPM_250219_KKK.txt' new;
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

%macro CPM (NMB);

* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
* Scenarios where the true value of DLT is 0.00
	* Input: ADS.SIM_EOD_SNR_&NMB.
	* Output: SIM_CPM_SNR_&NMB. 
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
/* Scenario number */
data SNR;
	length SCENARIO $8.; 
	SCENARIO = "&NMB.";
run;
	/* Bias */
	proc means data = ADS.SIM_EOD_SNR_&NMB. q1 median q3;
		var DLT_HAT;
		output out = BOP q1 = Q1_DLT_HAT median = Q2_DLT_HAT q3 = Q3_DLT_HAT;
	run;
	data BOP;
		set BOP;
			BIAS_Q1 = Q1_DLT_HAT - 0.00;
			BIAS_Q2 = Q2_DLT_HAT - 0.00;
			BIAS_Q3 = Q3_DLT_HAT - 0.00;
		keep BIAS_Q1 BIAS_Q2 BIAS_Q3;
	run;
	/* Detection proportion */
	data POD;
		set ADS.SIM_EOD_SNR_&NMB.;
			if ABS_D_HAT > 2.0 then DET = 100;
				else DET = 0;
	run;
	proc means data = POD mean;
		var DET;
		output out = POD mean =;
	run;
	data POD;
		set POD;
		keep DET;
	run;
	/* Failed estimation */
	proc freq data = ADS.SIM_EOD_SNR_&NMB.;
		tables MPE / out = PON;
	run;
	proc transpose data = PON out = PON;
		id MPE;
		var PERCENT;
	run;
	data PON;
		set PON;
		keep FE;
	run;
	/* Model X1, X2, or X3 */
	data POX;
		set ADS.SIM_EOD_SNR_&NMB.;
			where MPE in ('X1', 'X2', 'X3');
	run;
	proc freq data = POX;
		tables MPE / out = POX;
	run;
	proc transpose data = POX out = POX;
		id MPE;
		var PERCENT;
	run;
	data POX;
		set POX;
		keep X1 X2 X3;
	run;
	/* V_HAT = 0 */
	data POV;
		set ADS.SIM_EOD_SNR_&NMB.;
			where MPE in ('X1', 'X2', 'X3');
	run;
	proc freq data = POV;
		tables ABS_D / missing out = POV;
	run;
	proc transpose data = POV out = POV;
		id ABS_D;
		var PERCENT;
	run;
	data POV;
		set POV;
		keep VHAT;
	run;
	/* Integration */
	data SIM_CPM_SNR_&NMB.;
		merge SNR BOP POD PON POX POV;
	run;

%mend CPM;

%CPM (NMB = 01);
%CPM (NMB = 04);
%CPM (NMB = 07);
%CPM (NMB = 10);
%CPM (NMB = 13);
%CPM (NMB = 16);
%CPM (NMB = 19);
%CPM (NMB = 22);
%CPM (NMB = 25);
%CPM (NMB = 28);
%CPM (NMB = 31);
%CPM (NMB = 34);
%CPM (NMB = 37);
%CPM (NMB = 40);
%CPM (NMB = 43);
%CPM (NMB = 46);

%macro CPM (NMB);

* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
* Scenarios where the true value of DLT is 0.01
	* Input: ADS.SIM_EOD_SNR_&NMB. 
	* Output: SIM_CPM_SNR_&NMB. 
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
/* Scenario number */
data SNR;
	length SCENARIO $8.; 
	SCENARIO = "&NMB.";
run;
	/* Bias */
	proc means data = ADS.SIM_EOD_SNR_&NMB. q1 median q3;
		var DLT_HAT;
		output out = BOP q1 = Q1_DLT_HAT median = Q2_DLT_HAT q3 = Q3_DLT_HAT;
	run;
	data BOP;
		set BOP;
			BIAS_Q1 = Q1_DLT_HAT - 0.01;
			BIAS_Q2 = Q2_DLT_HAT - 0.01;
			BIAS_Q3 = Q3_DLT_HAT - 0.01;
		keep BIAS_Q1 BIAS_Q2 BIAS_Q3;
	run;
	/* Detection proportion */
	data POD;
		set ADS.SIM_EOD_SNR_&NMB.;
			if ABS_D_HAT > 2.0 then DET = 100;
				else DET = 0;
	run;
	proc means data = POD mean;
		var DET;
		output out = POD mean =;
	run;
	data POD;
		set POD;
		keep DET;
	run;
	/* Failed estimation */
	proc freq data = ADS.SIM_EOD_SNR_&NMB.;
		tables MPE / out = PON;
	run;
	proc transpose data = PON out = PON;
		id MPE;
		var PERCENT;
	run;
	data PON;
		set PON;
		keep FE;
	run;
	/* Model X1, X2, or X3 */
	data POX;
		set ADS.SIM_EOD_SNR_&NMB.;
			where MPE in ('X1', 'X2', 'X3');
	run;
	proc freq data = POX;
		tables MPE / out = POX;
	run;
	proc transpose data = POX out = POX;
		id MPE;
		var PERCENT;
	run;
	data POX;
		set POX;
		keep X1 X2 X3;
	run;
	/* V_HAT = 0 */
	data POV;
		set ADS.SIM_EOD_SNR_&NMB.;
			where MPE in ('X1', 'X2', 'X3');
	run;
	proc freq data = POV;
		tables ABS_D / missing out = POV;
	run;
	proc transpose data = POV out = POV;
		id ABS_D;
		var PERCENT;
	run;
	data POV;
		set POV;
		keep VHAT;
	run;
	/* Integration */
	data SIM_CPM_SNR_&NMB.;
		merge SNR BOP POD PON POX POV;
	run;

%mend CPM;

%CPM (NMB = 02);
%CPM (NMB = 05);
%CPM (NMB = 08);
%CPM (NMB = 11);
%CPM (NMB = 14);
%CPM (NMB = 17);
%CPM (NMB = 20);
%CPM (NMB = 23);
%CPM (NMB = 26);
%CPM (NMB = 29);
%CPM (NMB = 32);
%CPM (NMB = 35);
%CPM (NMB = 38);
%CPM (NMB = 41);
%CPM (NMB = 44);
%CPM (NMB = 47);

%macro CPM (NMB);

* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
* Scenarios where the true value of DLT is 0.05
	* Input: ADS.SIM_EOD_SNR_&NMB.
	* Output: SIM_CPM_SNR_&NMB. 
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
/* Scenario number */
data SNR;
	length SCENARIO $8.; 
	SCENARIO = "&NMB.";
run;
	/* Bias */
	proc means data = ADS.SIM_EOD_SNR_&NMB. q1 median q3;
		var DLT_HAT;
		output out = BOP q1 = Q1_DLT_HAT median = Q2_DLT_HAT q3 = Q3_DLT_HAT;
	run;
	data BOP;
		set BOP;
			BIAS_Q1 = Q1_DLT_HAT - 0.05;
			BIAS_Q2 = Q2_DLT_HAT - 0.05;
			BIAS_Q3 = Q3_DLT_HAT - 0.05;
		keep BIAS_Q1 BIAS_Q2 BIAS_Q3;
	run;
	/* Detection proportion */
	data POD;
		set ADS.SIM_EOD_SNR_&NMB.;
			if ABS_D_HAT > 2.0 then DET = 100;
				else DET = 0;
	run;
	proc means data = POD mean;
		var DET;
		output out = POD mean =;
	run;
	data POD;
		set POD;
		keep DET;
	run;
	/* Failed estimation */
	proc freq data = ADS.SIM_EOD_SNR_&NMB.;
		tables MPE / out = PON;
	run;
	proc transpose data = PON out = PON;
		id MPE;
		var PERCENT;
	run;
	data PON;
		set PON;
		keep FE;
	run;
	/* Model X1, X2, or X3 */
	data POX;
		set ADS.SIM_EOD_SNR_&NMB.;
			where MPE in ('X1', 'X2', 'X3');
	run;
	proc freq data = POX;
		tables MPE / out = POX;
	run;
	proc transpose data = POX out = POX;
		id MPE;
		var PERCENT;
	run;
	data POX;
		set POX;
		keep X1 X2 X3;
	run;
	/* V_HAT = 0 */
	data POV;
		set ADS.SIM_EOD_SNR_&NMB.;
			where MPE in ('X1', 'X2', 'X3');
	run;
	proc freq data = POV;
		tables ABS_D / missing out = POV;
	run;
	proc transpose data = POV out = POV;
		id ABS_D;
		var PERCENT;
	run;
	data POV;
		set POV;
		keep VHAT;
	run;
	/* Integration */
	data SIM_CPM_SNR_&NMB.;
		merge SNR BOP POD PON POX POV;
	run;

%mend CPM;

%CPM (NMB = 03);
%CPM (NMB = 06);
%CPM (NMB = 09);
%CPM (NMB = 12);
%CPM (NMB = 15);
%CPM (NMB = 18);
%CPM (NMB = 21);
%CPM (NMB = 24);
%CPM (NMB = 27);
%CPM (NMB = 30);
%CPM (NMB = 33);
%CPM (NMB = 36);
%CPM (NMB = 39);
%CPM (NMB = 42);
%CPM (NMB = 45);
%CPM (NMB = 48);

* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
* Integrate the results from each scenario
	* Input: SIM_CPM_SNR_&NMB. 
	* Output: TLF.SIM_CPM
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
data TLF.SIM_CPM;
	set SIM_CPM_SNR_01
			SIM_CPM_SNR_02
			SIM_CPM_SNR_03
			SIM_CPM_SNR_04
			SIM_CPM_SNR_05
			SIM_CPM_SNR_06
			SIM_CPM_SNR_07
			SIM_CPM_SNR_08
			SIM_CPM_SNR_09
			SIM_CPM_SNR_10
			SIM_CPM_SNR_11
			SIM_CPM_SNR_12
			SIM_CPM_SNR_13
			SIM_CPM_SNR_14
			SIM_CPM_SNR_15
			SIM_CPM_SNR_16
			SIM_CPM_SNR_17
			SIM_CPM_SNR_18
			SIM_CPM_SNR_19
			SIM_CPM_SNR_20
			SIM_CPM_SNR_21
			SIM_CPM_SNR_22
			SIM_CPM_SNR_23
			SIM_CPM_SNR_24
			SIM_CPM_SNR_25
			SIM_CPM_SNR_26
			SIM_CPM_SNR_27
			SIM_CPM_SNR_28
			SIM_CPM_SNR_29
			SIM_CPM_SNR_30
			SIM_CPM_SNR_31
			SIM_CPM_SNR_32
			SIM_CPM_SNR_33
			SIM_CPM_SNR_34
			SIM_CPM_SNR_35
			SIM_CPM_SNR_36
			SIM_CPM_SNR_37
			SIM_CPM_SNR_38
			SIM_CPM_SNR_39
			SIM_CPM_SNR_40
			SIM_CPM_SNR_41
			SIM_CPM_SNR_42
			SIM_CPM_SNR_43
			SIM_CPM_SNR_44
			SIM_CPM_SNR_45
			SIM_CPM_SNR_46
			SIM_CPM_SNR_47
			SIM_CPM_SNR_48;
run;











