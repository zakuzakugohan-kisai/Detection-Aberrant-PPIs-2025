********************************************************************************************************************;
* Project: A mathematical model for detecting aberrant protein-protein interactions
* Program: SIM_03_EstimationD_19Feb2025_KKK.sas
* Objective: Estimation of D
* Author: Kenta Kevee Kisai
* SAS version: 9.4
* Platform: Windows
* Made: 2 September 2024
* Update: 19 February 2025
* Note: 
********************************************************************************************************************;
/* 3_LOG */
proc printto log = 'YOUR_PATH_TO_DIRECTORY\3_LOG\SIM_03_EstimationD_19Feb2025_KKK.txt' new;
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

%macro EOD (NMB);

* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
* Estimate d
	* Input: ADS.SIM_MPE_SNR_&NMB. 
	* Output: ADS.SIM_EOD_SNR_&NMB. 
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
data ADS.SIM_EOD_SNR_&NMB.;
	set ADS.SIM_MPE_SNR_&NMB.;
		/* Non-estimation */
		if MPE = 'NE' then do;
			DLT_HAT = .;
			ABS_D_HAT = 10.0;
			GROUP_P = 'ƒÂ^';
			GROUP_D = '|d^|';
		end;
		/* Model X1 */
		else if MPE = 'X1' then do;
			DLT_HAT = DLT_MDLX1_HAT;
			ABS_D_HAT = abs (DLT_MDLX1_HAT/V_MDLX1_HAT);
			if ABS_D_HAT > 8.0 then do;
				ABS_D_HAT = 8.0;
				ABS_D = 'OVER';
			end;
			else if ABS_D_HAT = . then do;
				ABS_D_HAT = 9.0;
				ABS_D = 'VHAT';
			end;
			GROUP_P = 'ƒÂ^';
			GROUP_D = '|d^|';
		end;
		/* Model X2 */
		else if MPE = 'X2' then do;
			DLT_HAT = DLT_MDLX2_HAT;
			ABS_D_HAT = abs (DLT_MDLX2_HAT/V_MDLX2_HAT);
			if ABS_D_HAT > 8.0 then do;
				ABS_D_HAT = 8.0;
				ABS_D = 'OVER';
			end;
			else if ABS_D_HAT = . then do;
				ABS_D_HAT = 9.0;
				ABS_D = 'VHAT';
			end;
			GROUP_P = 'ƒÂ^';
			GROUP_D = '|d^|';
		end;
		/* Model X3 */
		else if MPE = 'X3' then do;
			DLT_HAT = (LH_MDLX1/(LH_MDLX1+LH_MDLX2))*DLT_MDLX1_HAT
									+ (LH_MDLX2/(LH_MDLX1+LH_MDLX2))*DLT_MDLX2_HAT;
			ABS_D_MDLX1_HAT = abs (DLT_MDLX1_HAT/V_MDLX1_HAT);
			ABS_D_MDLX2_HAT = abs (DLT_MDLX2_HAT/V_MDLX2_HAT);
			ABS_D_HAT = (LH_MDLX1/(LH_MDLX1+LH_MDLX2))*ABS_D_MDLX1_HAT
										+ (LH_MDLX2/(LH_MDLX1+LH_MDLX2))*ABS_D_MDLX2_HAT;
			if ABS_D_HAT > 8.0 then do;
				ABS_D_HAT = 8.0;
				ABS_D = 'OVER';
			end;
			else if ABS_D_HAT = . then do;
				ABS_D_HAT = 9.0;
				ABS_D = 'VHAT';
			end;
			GROUP_P = 'ƒÂ^';
			GROUP_D = '|d^|';
		end;
	keep MPE DLT_HAT ABS_D_HAT ABS_D GROUP_P GROUP_D;
run;

%mend EOD;

%EOD (NMB = 01);
%EOD (NMB = 02);
%EOD (NMB = 03);
%EOD (NMB = 04);
%EOD (NMB = 05);
%EOD (NMB = 06);
%EOD (NMB = 07);
%EOD (NMB = 08);
%EOD (NMB = 09);
%EOD (NMB = 10);
%EOD (NMB = 11);
%EOD (NMB = 12);
%EOD (NMB = 13);
%EOD (NMB = 14);
%EOD (NMB = 15);
%EOD (NMB = 16);
%EOD (NMB = 17);
%EOD (NMB = 18);
%EOD (NMB = 19);
%EOD (NMB = 20);
%EOD (NMB = 21);
%EOD (NMB = 22);
%EOD (NMB = 23);
%EOD (NMB = 24);
%EOD (NMB = 25);
%EOD (NMB = 26);
%EOD (NMB = 27);
%EOD (NMB = 28);
%EOD (NMB = 29);
%EOD (NMB = 30);
%EOD (NMB = 31);
%EOD (NMB = 32);
%EOD (NMB = 33);
%EOD (NMB = 34);
%EOD (NMB = 35);
%EOD (NMB = 36);
%EOD (NMB = 37);
%EOD (NMB = 38);
%EOD (NMB = 39);
%EOD (NMB = 40);
%EOD (NMB = 41);
%EOD (NMB = 42);
%EOD (NMB = 43);
%EOD (NMB = 44);
%EOD (NMB = 45);
%EOD (NMB = 46);
%EOD (NMB = 47);
%EOD (NMB = 48);











