********************************************************************************************************************;
* Project: Model-based detection of aberrant protein-protein interactions 
					for explorating aberrant signalling pathways 
					through pathway maps and gene expression levels
* Program: ccRCC_03_EstimationDelta_4May2025_KKK.sas
* Objective: Estimation of DLT
* Author: Kenta Kevee Kisai
* SAS version: 9.4
* Platform: Windows
* Made: 7 June 2024
* Update: 4 May 2025
* Note: 
********************************************************************************************************************;
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

%macro MPE (PPI);

/* 3_LOG */
proc printto log = 'YOUR_PATH_TO_DIRECTORY\3_LOG\LUSC_03_EstimationDelta_OUT_4May2025_KKK.txt' new;
run;

* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
* Model X1
	* Input: ADS.LUSC_ADX_&PPI., ADS.LUSC_ADQ_&PPI., ADS.LUSC_MOX_&PPI.
	* Output: MDLX1
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
/* Least squares estimation for initial values of parameters */

/* Case */
data ADX;
	set ADS.LUSC_ADX_&PPI.;
run;
proc reg data = ADX;
	where J = 1;
		model X_2 = X_1;
		ods output parameterestimates = CAS;
run;
proc transpose data = CAS out = CAS;
run;
data CAS;
	set CAS;
		where _NAME_ = 'Estimate';
			ALP_1_MDLX1_TIL = COL1;
			BET_1_MDLX1_TIL = COL2;
	keep ALP_1_MDLX1_TIL BET_1_MDLX1_TIL;
run;
data CAS;
	merge CAS ADS.LUSC_ADQ_&PPI.;
run;
data CAS;
	set CAS;
		P_1_MDLX1_TIL = BET_1_MDLX1_TIL/Q_1_HAT;
			if P_1_MDLX1_TIL <= 0 or P_1_MDLX1_TIL >= 1 or P_1_MDLX1_TIL = . then P_1_MDLX1_TIL = 0.5;
		K_1_MDLX1_TIL = P_1_MDLX1_TIL/(ALP_1_MDLX1_TIL*(1-P_1_MDLX1_TIL));
			if K_1_MDLX1_TIL <= 0 or K_1_MDLX1_TIL = . then K_1_MDLX1_TIL = 1;
	keep Q_1_HAT K_1_MDLX1_TIL P_1_MDLX1_TIL;
run;
/* Control */
data ADX;
	set ADS.LUSC_ADX_&PPI.;
run;
proc reg data = ADX;
	where J = 0;
		model X_2 = X_1;
		ods output parameterestimates = CTL;
run;
proc transpose data = CTL out = CTL;
run;
data CTL;
	set CTL;
		where _NAME_ = 'Estimate';
			ALP_0_MDLX1_TIL = COL1;
			BET_0_MDLX1_TIL = COL2;
	keep ALP_0_MDLX1_TIL BET_0_MDLX1_TIL;
run;
data CTL;
	merge CTL ADS.LUSC_ADQ_&PPI.;
run;
data CTL;
	set CTL;
		P_0_MDLX1_TIL = BET_0_MDLX1_TIL/Q_0_HAT;
			if P_0_MDLX1_TIL <= 0 or P_0_MDLX1_TIL >= 1 or P_0_MDLX1_TIL = . then P_0_MDLX1_TIL = 0.5;
		K_0_MDLX1_TIL = P_0_MDLX1_TIL/(ALP_0_MDLX1_TIL*(1-P_0_MDLX1_TIL));
			if K_0_MDLX1_TIL <= 0 or K_0_MDLX1_TIL = . then K_0_MDLX1_TIL = 1;
	keep Q_0_HAT K_0_MDLX1_TIL P_0_MDLX1_TIL;
run;
/* Integration */
data MDLX1;
	merge CAS CTL ADS.LUSC_MOX_&PPI.;
		DLT_MDLX1_TIL = P_1_MDLX1_TIL - P_0_MDLX1_TIL; 
run;

/* Maximum likelihood estimation */

data _null_;
	set MDLX1;
		call symputx ('Q_1_HAT', Q_1_HAT);
		call symputx ('K_1_MDLX1_TIL', K_1_MDLX1_TIL);
		call symputx ('DLT_MDLX1_TIL', DLT_MDLX1_TIL);
		call symputx ('Q_0_HAT', Q_0_HAT);
		call symputx ('K_0_MDLX1_TIL', K_0_MDLX1_TIL);
		call symputx ('P_0_MDLX1_TIL', P_0_MDLX1_TIL);
run;

/* 3_LOG */
proc printto log = 'YOUR_PATH_TO_DIRECTORY\3_LOG\LUSC_03_EstimationDelta_WNG_4May2025_KKK.txt' new;
run;

	proc nlmixed data = ADX technique = quanew method = gauss maxiter = 200;
		parms K_MDLX1_HAT = 1, &K_1_MDLX1_TIL., &K_0_MDLX1_TIL.
						DLT_MDLX1_HAT = &DLT_MDLX1_TIL., 0
						P_0_MDLX1_HAT = 0.5, &P_0_MDLX1_TIL.
						SGM_GAM_MDLX1_HAT = 0.0001, 0.001, 0.01, 0.1, 1, 10, 100, 1000, 10000 /* Variance */
						SGM_EPS_MDLX1_HAT = 0.0001, 0.001, 0.01, 0.1, 1, 10, 100, 1000, 10000 /* Variance */;
		bounds -1 < DLT_MDLX1_HAT < 1, SGM_GAM_MDLX1_HAT > 0, SGM_EPS_MDLX1_HAT > 0;
		model X_2 ~ normal (J*(((DLT_MDLX1_HAT+P_0_MDLX1_HAT)/(K_MDLX1_HAT*(1-(DLT_MDLX1_HAT+P_0_MDLX1_HAT))))+(DLT_MDLX1_HAT+P_0_MDLX1_HAT)*&Q_1_HAT.*X_1)
											+ (1-J)*((P_0_MDLX1_HAT/(K_MDLX1_HAT*(1-P_0_MDLX1_HAT)))+P_0_MDLX1_HAT*&Q_0_HAT.*X_1) + GAM_MDLX1_HAT, SGM_EPS_MDLX1_HAT);
		random GAM_MDLX1_HAT ~ normal (0, SGM_GAM_MDLX1_HAT) subject = ID;
		ods output ParameterEstimates = PES FitStatistics = FST ConvergenceStatus = CGS;
	run;

/* 3_LOG */
proc printto log = 'YOUR_PATH_TO_DIRECTORY\3_LOG\LUSC_03_EstimationDelta_OUT_4May2025_KKK.txt' new;
run;

/* Final estimates and their standard errors */
proc transpose data = PES out = PES;
	id PARAMETER;
	var ESTIMATE STANDARDERROR;
run;
data EST;
	set PES;
		if _n_ = 1 then output;
	keep K_MDLX1_HAT DLT_MDLX1_HAT P_0_MDLX1_HAT SGM_GAM_MDLX1_HAT SGM_EPS_MDLX1_HAT;
run;
data SER;
	set PES;
		V_MDLX1_HAT = DLT_MDLX1_HAT;
		if _n_ = 2 then output;
	keep V_MDLX1_HAT;
run;
/* Log-likelihood of the final estimates */
data FST;
	set FST;
		LLH_MDLX1 = -(1/2)*VALUE;
		if _n_ = 1 then output;
	keep LLH_MDLX1;
run;
/* Convergence status */
data CGS;
	set CGS;
		STT_MDLX1 = STATUS;
		RSN_MDLX1 = REASON;
	keep STT_MDLX1 RSN_MDLX1;
run;
/* Output of log warnings to the dataset  */
data WNG;
	/* 3_LOG */
	infile 'YOUR_PATH_TO_DIRECTORY\3_LOG\LUSC_03_EstimationDelta_WNG_4May2025_KKK.txt' truncover;
	input MSG_MDLX1 $200.;
	retain WFG_MDLX1 0;
		if index (MSG_MDLX1, 'WARNING') > 0 then WFG_MDLX1 = 1;
		if index (MSG_MDLX1, 'NOTE') > 0 then WFG_MDLX1 = 0;  
		if WFG_MDLX1 = 1 then output;
	keep MSG_MDLX1;
run;
proc transpose data = WNG out = WNG;
	var MSG_MDLX1;
run;
data WGF;
	set WNG;
		if missing (COL1) then WNF_MDLX1 = 0;
			else WNF_MDLX1 = 1;
	keep WNF_MDLX1;
run;
data WGM;
	set WNG;
		length WGM1_MDLX1 $200. WGM2_MDLX1 $200. WGM3_MDLX1 $200. WGM4_MDLX1 $200.;
			WGM1_MDLX1 = COL1;
			WGM2_MDLX1 = COL2;
			WGM3_MDLX1 = COL3;
			WGM4_MDLX1 = COL4;
	keep WGM1_MDLX1 WGM2_MDLX1 WGM3_MDLX1 WGM4_MDLX1;
run;
/* Integration of the estimation results */
data MDLX1;
	merge EST SER FST CGS WGF WGM;
run;

* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
* Model X2
	* Input: ADS.LUSC_ADX_&PPI., ADS.LUSC_ADQ_&PPI., ADS.LUSC_MOX_&PPI.
	* Output: MDLX2
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
/* Least squares estimation for initial values of parameters */

/* Case */
data ADX;
	set ADS.LUSC_ADX_&PPI.;
run;
proc reg data = ADX;
	where J = 1;
		model X_2 = X_1;
		ods output parameterestimates = CAS;
run;
proc transpose data = CAS out = CAS;
run;
data CAS;
	set CAS;
		where _NAME_ = 'Estimate';
			ALP_1_MDLX2_TIL = COL1;
			BET_1_MDLX2_TIL = COL2;
	keep ALP_1_MDLX2_TIL BET_1_MDLX2_TIL;
run;
data CAS;
	merge CAS ADS.LUSC_ADQ_&PPI.;
run;
data CAS;
	set CAS;
		P_1_MDLX2_TIL = Q_1_HAT/BET_1_MDLX2_TIL;
			if P_1_MDLX2_TIL <= 0 or P_1_MDLX2_TIL >= 1 or P_1_MDLX2_TIL = . then P_1_MDLX2_TIL = 0.5;
		K_1_MDLX2_TIL = 1/(ALP_1_MDLX2_TIL*(P_1_MDLX2_TIL-1));
			if K_1_MDLX2_TIL <= 0 or K_1_MDLX2_TIL = . then K_1_MDLX2_TIL = 1;
	keep Q_1_HAT K_1_MDLX2_TIL P_1_MDLX2_TIL;
run;
/* Control */
data ADX;
	set ADS.LUSC_ADX_&PPI.;
run;
proc reg data = ADX;
	where J = 0;
		model X_2 = X_1;
		ods output parameterestimates = CTL;
run;
proc transpose data = CTL out = CTL;
run;
data CTL;
	set CTL;
		where _NAME_ = 'Estimate';
			ALP_0_MDLX2_TIL = COL1;
			BET_0_MDLX2_TIL = COL2;
	keep ALP_0_MDLX2_TIL BET_0_MDLX2_TIL;
run;
data CTL;
	merge CTL ADS.LUSC_ADQ_&PPI.;
run;
data CTL;
	set CTL;
		P_0_MDLX2_TIL = Q_0_HAT/BET_0_MDLX2_TIL;
			if P_0_MDLX2_TIL <= 0 or P_0_MDLX2_TIL >= 1 or P_0_MDLX2_TIL = . then P_0_MDLX2_TIL = 0.5;
		K_0_MDLX2_TIL = 1/(ALP_0_MDLX2_TIL*(P_0_MDLX2_TIL-1));
			if K_0_MDLX2_TIL <= 0 or K_0_MDLX2_TIL = . then K_0_MDLX2_TIL = 1;
	keep Q_0_HAT K_0_MDLX2_TIL P_0_MDLX2_TIL;
run;
/* Integration */
data MDLX2;
	merge CAS CTL ADS.LUSC_MOX_&PPI.;
		DLT_MDLX2_TIL = P_1_MDLX2_TIL - P_0_MDLX2_TIL;
run;

/* Maximum likelihood estimation */

data _null_;
	set MDLX2;
		call symputx ('Q_1_HAT', Q_1_HAT);
		call symputx ('K_1_MDLX2_TIL', K_1_MDLX2_TIL);
		call symputx ('DLT_MDLX2_TIL', DLT_MDLX2_TIL);
		call symputx ('Q_0_HAT', Q_0_HAT);
		call symputx ('K_0_MDLX2_TIL', K_0_MDLX2_TIL);
		call symputx ('P_0_MDLX2_TIL', P_0_MDLX2_TIL);
run;

/* 3_LOG */
proc printto log = 'YOUR_PATH_TO_DIRECTORY\3_LOG\LUSC_03_EstimationDelta_WNG_4May2025_KKK.txt' new;
run;

	proc nlmixed data = ADX technique = quanew method = gauss maxiter = 200;
		parms K_MDLX2_HAT = 1, &K_1_MDLX2_TIL., &K_0_MDLX2_TIL.
						DLT_MDLX2_HAT = &DLT_MDLX2_TIL., 0
						P_0_MDLX2_HAT = 0.5, &P_0_MDLX2_TIL.
						SGM_GAM_MDLX2_HAT = 0.0001, 0.001, 0.01, 0.1, 1, 10, 100, 1000, 10000 /* Variance */
						SGM_EPS_MDLX2_HAT = 0.0001, 0.001, 0.01, 0.1, 1, 10, 100, 1000, 10000 /* Variance */;
		bounds -1 < DLT_MDLX2_HAT < 1, SGM_GAM_MDLX2_HAT > 0, SGM_EPS_MDLX2_HAT > 0;
		model X_2 ~ normal (J*((1/(K_MDLX2_HAT*(DLT_MDLX2_HAT+P_0_MDLX2_HAT-1)))+(&Q_1_HAT./(DLT_MDLX2_HAT+P_0_MDLX2_HAT))*X_1)
											+ (1-J)*((1/(K_MDLX2_HAT*(P_0_MDLX2_HAT-1)))+(&Q_0_HAT./P_0_MDLX2_HAT)*X_1) + GAM_MDLX2_HAT, SGM_EPS_MDLX2_HAT);
		random GAM_MDLX2_HAT ~ normal (0, SGM_GAM_MDLX2_HAT) subject = ID;
		ods output ParameterEstimates = PES FitStatistics = FST ConvergenceStatus = CGS;
	run;

/* 3_LOG */
proc printto log = 'YOUR_PATH_TO_DIRECTORY\3_LOG\LUSC_03_EstimationDelta_OUT_4May2025_KKK.txt' new;
run;

/* Final estimates and their standard errors */
proc transpose data = PES out = PES;
	id PARAMETER;
	var ESTIMATE STANDARDERROR;
run;
data EST;
	set PES;
		if _n_ = 1 then output;
	keep K_MDLX2_HAT DLT_MDLX2_HAT P_0_MDLX2_HAT SGM_GAM_MDLX2_HAT SGM_EPS_MDLX2_HAT;
run;
data SER;
	set PES;
		V_MDLX2_HAT = DLT_MDLX2_HAT;
		if _n_ = 2 then output;
	keep V_MDLX2_HAT;
run;
/* Log-likelihood of the final estimates */
data FST;
	set FST;
		LLH_MDLX2 = -(1/2)*VALUE;
		if _n_ = 1 then output;
	keep LLH_MDLX2;
run;
/* Convergence status */
data CGS;
	set CGS;
		STT_MDLX2 = STATUS;
		RSN_MDLX2 = REASON;
	keep STT_MDLX2 RSN_MDLX2;
run;
/* Output of log warnings to the dataset */
data WNG;
	/* 3_LOG */
	infile 'YOUR_PATH_TO_DIRECTORY\3_LOG\LUSC_03_EstimationDelta_WNG_4May2025_KKK.txt' truncover;
	input MSG_MDLX2 $200.;
	retain WFG_MDLX2 0;
		if index (MSG_MDLX2, 'WARNING') > 0 then WFG_MDLX2 = 1;
		if index (MSG_MDLX2, 'NOTE') > 0 then WFG_MDLX2 = 0;  
		if WFG_MDLX2 = 1 then output;
	keep MSG_MDLX2;
run;
proc transpose data = WNG out = WNG;
	var MSG_MDLX2;
run;
data WGF;
	set WNG;
		if missing (COL1) then WNF_MDLX2 = 0;
			else WNF_MDLX2 = 1;
	keep WNF_MDLX2;
run;
data WGM;
	set WNG;
		length WGM1_MDLX2 $200. WGM2_MDLX2 $200. WGM3_MDLX2 $200. WGM4_MDLX2 $200.;
			WGM1_MDLX2 = COL1;
			WGM2_MDLX2 = COL2;
			WGM3_MDLX2 = COL3;
			WGM4_MDLX2 = COL4;
	keep WGM1_MDLX2 WGM2_MDLX2 WGM3_MDLX2 WGM4_MDLX2;
run;
/* Integration of the estimation results */
data MDLX2;
	merge EST SER FST CGS WGF WGM;
run;

* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
* Integrate Model X1 and X2
	* Input: ADS.LUSC_MOX_&PPI., ADS.LUSC_ADQ_&PPI., MDLX1, MDLX2
	* Output: ADS.LUSC_MPE_&PPI.
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
/* Integration of Model X1 and X2 */
data MPE;
	merge ADS.LUSC_MOX_&PPI. ADS.LUSC_ADQ_&PPI. MDLX1 MDLX2;
	LLR = LLH_MDLX1 - LLH_MDLX2;
run;
data ADS.LUSC_MPE_&PPI.;
	set MPE;
		/* ZERO */
		if ((MEAN_CAS_X1 = 0 or MEAN_CAS_X2 = 0) and (MEAN_CTL_X1 = 0 or MEAN_CTL_X2 = 0)) or (Q_1_HAT = 0 and Q_0_HAT = 0) then do;
			K_MDLX1_HAT = .;
			K_MDLX2_HAT = .;
			DLT_MDLX1_HAT = .;
			DLT_MDLX2_HAT = .;
			P_0_MDLX1_HAT = .;
			P_0_MDLX2_HAT = .;
			SGM_GAM_MDLX1_HAT = .;
			SGM_GAM_MDLX2_HAT = .;
			SGM_EPS_MDLX1_HAT = .;
			SGM_EPS_MDLX2_HAT = .;
			V_MDLX1_HAT = .;
			V_MDLX2_HAT = .;
			LH_MDLX1 = .;
			LH_MDLX2 = .;
			LLR = .;
			MPE = 'ZERO';
		end;
		/* Non-estimation */
		else if (STT_MDLX1 ^= 0 or WNF_MDLX1 = 1) and (STT_MDLX2 ^= 0 or WNF_MDLX2 = 1) then do;
			K_MDLX1_HAT = .;
			K_MDLX2_HAT = .;
			DLT_MDLX1_HAT = .;
			DLT_MDLX2_HAT = .;
			P_0_MDLX1_HAT = .;
			P_0_MDLX2_HAT = .;
			SGM_GAM_MDLX1_HAT = .;
			SGM_GAM_MDLX2_HAT = .;
			SGM_EPS_MDLX1_HAT = .;
			SGM_EPS_MDLX2_HAT = .;
			V_MDLX1_HAT = .;
			V_MDLX2_HAT = .;
			LH_MDLX1 = .;
			LH_MDLX2 = .;
			LLR = .;
			MPE = 'NE';
		end;
		/* Model X1 */
		else if (STT_MDLX1 = 0 and WNF_MDLX1 = 0) and (STT_MDLX2 ^= 0 or WNF_MDLX2 = 1) then do;
			K_MDLX1_HAT = K_MDLX1_HAT;
			K_MDLX2_HAT = .;
			DLT_MDLX1_HAT = DLT_MDLX1_HAT;
			DLT_MDLX2_HAT = .;
			P_0_MDLX1_HAT = P_0_MDLX1_HAT;
			P_0_MDLX2_HAT = .;
			SGM_GAM_MDLX1_HAT = SGM_GAM_MDLX1_HAT;
			SGM_GAM_MDLX2_HAT = .;
			SGM_EPS_MDLX1_HAT = SGM_EPS_MDLX1_HAT;
			SGM_EPS_MDLX2_HAT = .;
			V_MDLX1_HAT = V_MDLX1_HAT;
			V_MDLX2_HAT = .;
			LH_MDLX1 = exp (LLH_MDLX1);
			LH_MDLX2 = .;
			LLR = .;
			MPE = 'X1';
		end;
		/* Model X2 */
		else if (STT_MDLX1 ^= 0 or WNF_MDLX1 = 1) and (STT_MDLX2 = 0 and WNF_MDLX2 = 0) then do;
			K_MDLX1_HAT = .;
			K_MDLX2_HAT = K_MDLX2_HAT;
			DLT_MDLX1_HAT = .;
			DLT_MDLX2_HAT = DLT_MDLX2_HAT;
			P_0_MDLX1_HAT = .;
			P_0_MDLX2_HAT = P_0_MDLX2_HAT;
			SGM_GAM_MDLX1_HAT = .;
			SGM_GAM_MDLX2_HAT = SGM_GAM_MDLX2_HAT;
			SGM_EPS_MDLX1_HAT = .;
			SGM_EPS_MDLX2_HAT = SGM_EPS_MDLX2_HAT;
			V_MDLX1_HAT = .;
			V_MDLX2_HAT = V_MDLX2_HAT;
			LH_MDLX1 = .;
			LH_MDLX2 = exp (LLH_MDLX2);
			LLR = .;
			MPE = 'X2';
		end;
		/* Model selection */
		else if (STT_MDLX1 = 0 and WNF_MDLX1 = 0) and (STT_MDLX2 = 0 and WNF_MDLX2 = 0) then do;
			/* Model X1 */
			if LLR > 1 then do;
				K_MDLX1_HAT = K_MDLX1_HAT;
				K_MDLX2_HAT = K_MDLX2_HAT;
				DLT_MDLX1_HAT = DLT_MDLX1_HAT;
				DLT_MDLX2_HAT = DLT_MDLX2_HAT;
				P_0_MDLX1_HAT = P_0_MDLX1_HAT;
				P_0_MDLX2_HAT = P_0_MDLX2_HAT;
				SGM_GAM_MDLX1_HAT = SGM_GAM_MDLX1_HAT;
				SGM_GAM_MDLX2_HAT = SGM_GAM_MDLX2_HAT;
				SGM_EPS_MDLX1_HAT = SGM_EPS_MDLX1_HAT;
				SGM_EPS_MDLX2_HAT = SGM_EPS_MDLX2_HAT;
				V_MDLX1_HAT = V_MDLX1_HAT;
				V_MDLX2_HAT = V_MDLX2_HAT;
				LH_MDLX1 = exp (LLH_MDLX1);
				LH_MDLX2 = exp (LLH_MDLX2);
				LLR = LLR;
				MPE = 'X1';
			end;
			/* Model X2 */
			else if LLR < -1 then do;
				K_MDLX1_HAT = K_MDLX1_HAT;
				K_MDLX2_HAT = K_MDLX2_HAT;
				DLT_MDLX1_HAT = DLT_MDLX1_HAT;
				DLT_MDLX2_HAT = DLT_MDLX2_HAT;
				P_0_MDLX1_HAT = P_0_MDLX1_HAT;
				P_0_MDLX2_HAT = P_0_MDLX2_HAT;
				SGM_GAM_MDLX1_HAT = SGM_GAM_MDLX1_HAT;
				SGM_GAM_MDLX2_HAT = SGM_GAM_MDLX2_HAT;
				SGM_EPS_MDLX1_HAT = SGM_EPS_MDLX1_HAT;
				SGM_EPS_MDLX2_HAT = SGM_EPS_MDLX2_HAT;
				V_MDLX1_HAT = V_MDLX1_HAT;
				V_MDLX2_HAT = V_MDLX2_HAT;
				LH_MDLX1 = exp (LLH_MDLX1);
				LH_MDLX2 = exp (LLH_MDLX2);
				LLR = LLR;
				MPE = 'X2';
			end;
			/* Model X3 */
			else if -1 <= LLR <= 1 then do;
				K_MDLX1_HAT = K_MDLX1_HAT;
				K_MDLX2_HAT = K_MDLX2_HAT;
				DLT_MDLX1_HAT = DLT_MDLX1_HAT;
				DLT_MDLX2_HAT = DLT_MDLX2_HAT;
				P_0_MDLX1_HAT = P_0_MDLX1_HAT;
				P_0_MDLX2_HAT = P_0_MDLX2_HAT;
				SGM_GAM_MDLX1_HAT = SGM_GAM_MDLX1_HAT;
				SGM_GAM_MDLX2_HAT = SGM_GAM_MDLX2_HAT;
				SGM_EPS_MDLX1_HAT = SGM_EPS_MDLX1_HAT;
				SGM_EPS_MDLX2_HAT = SGM_EPS_MDLX2_HAT;
				V_MDLX1_HAT = V_MDLX1_HAT;
				V_MDLX2_HAT = V_MDLX2_HAT;
				LH_MDLX1 = exp (LLH_MDLX1);
				LH_MDLX2 = exp (LLH_MDLX2);
				LLR = LLR;
				MPE = 'X3';
			end;
		end;
		length PPI $200.; PPI = "&PPI.";
	keep Q_1_HAT Q_0_HAT 
				RSN_MDLX1 RSN_MDLX2 
				WGM1_MDLX1 WGM2_MDLX1 WGM3_MDLX1 WGM4_MDLX1 
				WGM1_MDLX2 WGM2_MDLX2 WGM3_MDLX2 WGM4_MDLX2
				K_MDLX1_HAT K_MDLX2_HAT
				DLT_MDLX1_HAT DLT_MDLX2_HAT
				P_0_MDLX1_HAT P_0_MDLX2_HAT
				SGM_GAM_MDLX1_HAT SGM_GAM_MDLX2_HAT 
				SGM_EPS_MDLX1_HAT SGM_EPS_MDLX2_HAT 
				V_MDLX1_HAT V_MDLX2_HAT
				LH_MDLX1 LH_MDLX2 LLR MPE PPI;
run;

* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
* Deletion of the datasets in WORK
	* Input: None
	* Output: None
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
proc datasets lib = WORK kill nolist; 
run;

%mend MPE;

%MPE (PPI = Grb10_R);
%MPE (PPI = R_IRS1);
%MPE (PPI = S6K_IRS1);
%MPE (PPI = IRS1_PI3K);
%MPE (PPI = PI3K_mTORC2);
%MPE (PPI = PDK1_Akt);
%MPE (PPI = Akt_IKKA);
%MPE (PPI = IKKA_mTORC2);
%MPE (PPI = mTORC2_Rho);
%MPE (PPI = mTORC2_PKC);
%MPE (PPI = mTORC2_SGK1);
%MPE (PPI = R_Grb2);
%MPE (PPI = Grb2_SOS);
%MPE (PPI = SOS_Ras);
%MPE (PPI = Ras_Raf);
%MPE (PPI = Raf_MEK);
%MPE (PPI = MEK_ERK1);
%MPE (PPI = ERK1_RSK);
%MPE (PPI = TNFR_IKKB);
%MPE (PPI = Frizzled_Dvl);
%MPE (PPI = Dvl_GSK3B);
%MPE (PPI = STRAD_AMPK);
%MPE (PPI = ERK1_TSC1);
%MPE (PPI = RSK_TSC1);
%MPE (PPI = IKKB_TSC1);
%MPE (PPI = GSK3B_TSC1);
%MPE (PPI = REDD1_TSC1);
%MPE (PPI = AMPK_TSC1);
%MPE (PPI = Akt_TSC1);
%MPE (PPI = Akt_PRAS40);
%MPE (PPI = IKKA_mTORC1);
%MPE (PPI = TSC1_Rheb);
%MPE (PPI = Rheb_mTORC1);
%MPE (PPI = AMPK_mTORC1);
%MPE (PPI = SLC38A9_Ragulator);
%MPE (PPI = VATPase_Ragulator);
%MPE (PPI = FNIP_RagA);
%MPE (PPI = Ragulator_RagA);
%MPE (PPI = RagA_mTORC1);
%MPE (PPI = SESN2_GATOR2);
%MPE (PPI = CASTOR1_GATOR2);
%MPE (PPI = GATOR2_GATOR1);
%MPE (PPI = GATOR1_RagA);
%MPE (PPI = Skp2_RagA);
%MPE (PPI = RNF152_RagA);
%MPE (PPI = S6K_mTORC2);
%MPE (PPI = mTORC1_CLIP170);
%MPE (PPI = mTORC1_Grb10);
%MPE (PPI = mTORC1_Lipin1);
%MPE (PPI = mTORC1_ATG1);
%MPE (PPI = mTORC1_4EBP);
%MPE (PPI = mTORC1_S6K);
%MPE (PPI = 4EBP_eIF4E);
%MPE (PPI = S6K_eIF4B);
%MPE (PPI = S6K_S6);
%MPE (PPI = Deptor_mTORC1);
%MPE (PPI = Deptor_mTORC2);
%MPE (PPI = PRAS40_mTORC1);
%MPE (PPI = mTORC2_Akt);

* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
* Integrate the results of each interaction
	* Input: ADS.LUSC_MPE_&PPI. 
	* Output: TLF.LUSC_MPE
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
data TLF.LUSC_MPE;
	set ADS.LUSC_MPE_Grb10_R 
			ADS.LUSC_MPE_R_IRS1 
			ADS.LUSC_MPE_S6K_IRS1 
			ADS.LUSC_MPE_IRS1_PI3K 
			ADS.LUSC_MPE_PI3K_mTORC2 
			ADS.LUSC_MPE_PDK1_Akt 
			ADS.LUSC_MPE_Akt_IKKA 
			ADS.LUSC_MPE_IKKA_mTORC2 
			ADS.LUSC_MPE_mTORC2_Rho
			ADS.LUSC_MPE_mTORC2_PKC 
			ADS.LUSC_MPE_mTORC2_SGK1
			ADS.LUSC_MPE_R_Grb2
			ADS.LUSC_MPE_Grb2_SOS
			ADS.LUSC_MPE_SOS_Ras
			ADS.LUSC_MPE_Ras_Raf
			ADS.LUSC_MPE_Raf_MEK
			ADS.LUSC_MPE_MEK_ERK1
			ADS.LUSC_MPE_ERK1_RSK
			ADS.LUSC_MPE_TNFR_IKKB
			ADS.LUSC_MPE_Frizzled_Dvl
			ADS.LUSC_MPE_Dvl_GSK3B
			ADS.LUSC_MPE_STRAD_AMPK
			ADS.LUSC_MPE_ERK1_TSC1
			ADS.LUSC_MPE_RSK_TSC1
			ADS.LUSC_MPE_IKKB_TSC1
			ADS.LUSC_MPE_GSK3B_TSC1
			ADS.LUSC_MPE_REDD1_TSC1
			ADS.LUSC_MPE_AMPK_TSC1
			ADS.LUSC_MPE_Akt_TSC1
			ADS.LUSC_MPE_Akt_PRAS40
			ADS.LUSC_MPE_IKKA_mTORC1
			ADS.LUSC_MPE_TSC1_Rheb
			ADS.LUSC_MPE_Rheb_mTORC1
			ADS.LUSC_MPE_AMPK_mTORC1
			ADS.LUSC_MPE_SLC38A9_Ragulator
			ADS.LUSC_MPE_VATPase_Ragulator
			ADS.LUSC_MPE_FNIP_RagA
			ADS.LUSC_MPE_Ragulator_RagA
			ADS.LUSC_MPE_RagA_mTORC1
			ADS.LUSC_MPE_SESN2_GATOR2
			ADS.LUSC_MPE_CASTOR1_GATOR2
			ADS.LUSC_MPE_GATOR2_GATOR1
			ADS.LUSC_MPE_GATOR1_RagA
			ADS.LUSC_MPE_Skp2_RagA
			ADS.LUSC_MPE_RNF152_RagA
			ADS.LUSC_MPE_S6K_mTORC2
			ADS.LUSC_MPE_mTORC1_CLIP170
			ADS.LUSC_MPE_mTORC1_Grb10
			ADS.LUSC_MPE_mTORC1_Lipin1
			ADS.LUSC_MPE_mTORC1_ATG1
			ADS.LUSC_MPE_mTORC1_4EBP
			ADS.LUSC_MPE_mTORC1_S6K
			ADS.LUSC_MPE_4EBP_eIF4E
			ADS.LUSC_MPE_S6K_eIF4B
			ADS.LUSC_MPE_S6K_S6
			ADS.LUSC_MPE_Deptor_mTORC1
			ADS.LUSC_MPE_Deptor_mTORC2
			ADS.LUSC_MPE_PRAS40_mTORC1
			ADS.LUSC_MPE_mTORC2_Akt;
run;





















