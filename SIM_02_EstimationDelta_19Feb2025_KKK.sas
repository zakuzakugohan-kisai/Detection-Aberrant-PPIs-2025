********************************************************************************************************************;
* Project: Model-based detection of aberrant protein-protein interactions 
					for exploration of aberrant signalling pathways 
					through pathway maps and gene expression levels
* Program: SIM_02_EstimationDelta_19Feb2025_KKK.sas
* Objective: Estimation of DLT
* Author: Kenta Kevee Kisai
* SAS version: 9.4
* Platform: Windows
* Made: 2 September 2024
* Update: 19 February 2025
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

%macro MPE (NMB, F);

/* 3_LOG */
proc printto log = 'YOUR_PATH_TO_DIRECTORY\3_LOG\SIM_02_EstimationDelta_OUT_19Feb2025_KKK.txt' new;
run;

* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
* Specify the dataset to be applied
	* Input: ADS.SIM_DAT_SNR_&NMB.
	* Output: ADX
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
data ADX;
	set ADS.SIM_DAT_SNR_&NMB.;
		where F = &F.;
run;

* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
* Model X1
	* Input: ADX
	* Output: MDLX1
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
/* Least squares estimation for initial values of parameters */

/* Case */
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
data ADQ;
	set ADX (obs = 1);
	keep Q_1;
run;
data CAS;
	merge CAS ADQ;
run;
data CAS;
	set CAS;
		P_1_MDLX1_TIL = BET_1_MDLX1_TIL/Q_1_HAT;
			if P_1_MDLX1_TIL <= 0 or P_1_MDLX1_TIL >= 1 or P_1_MDLX1_TIL = . then P_1_MDLX1_TIL = 0.5;
		K_1_MDLX1_TIL = P_1_MDLX1_TIL/(ALP_1_MDLX1_TIL*(1-P_1_MDLX1_TIL));
			if K_1_MDLX1_TIL <= 0 or K_1_MDLX1_TIL = . then K_1_MDLX1_TIL = 1;
	keep Q_1 K_1_MDLX1_TIL P_1_MDLX1_TIL;
run;
/* Control */
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
data ADQ;
	set ADX (obs = 1);
	keep Q_0;
run;
data CTL;
	merge CTL ADQ;
run;
data CTL;
	set CTL;
		P_0_MDLX1_TIL = BET_0_MDLX1_TIL/Q_0_HAT;
			if P_0_MDLX1_TIL <= 0 or P_0_MDLX1_TIL >= 1 or P_0_MDLX1_TIL = . then P_0_MDLX1_TIL = 0.5;
		K_0_MDLX1_TIL = P_0_MDLX1_TIL/(ALP_0_MDLX1_TIL*(1-P_0_MDLX1_TIL));
			if K_0_MDLX1_TIL <= 0 or K_0_MDLX1_TIL = . then K_0_MDLX1_TIL = 1;
	keep Q_0 K_0_MDLX1_TIL P_0_MDLX1_TIL;
run;
/* Integration */
data MDLX1;
	merge CAS CTL;
		DLT_MDLX1_TIL = P_1_MDLX1_TIL - P_0_MDLX1_TIL; 
run;

/* Maximum likelihood estimation */

data _null_;
	set MDLX1;
		call symputx ('Q_1', Q_1);
		call symputx ('K_1_MDLX1_TIL', K_1_MDLX1_TIL);
		call symputx ('DLT_MDLX1_TIL', DLT_MDLX1_TIL);
		call symputx ('Q_0', Q_0);
		call symputx ('K_0_MDLX1_TIL', K_0_MDLX1_TIL);
		call symputx ('P_0_MDLX1_TIL', P_0_MDLX1_TIL);
run;

/* 3_LOG */
proc printto log = 'YOUR_PATH_TO_DIRECTORY\3_LOG\SIM_02_EstimationDelta_WNG_19Feb2025_KKK.txt' new;
run;

	proc nlmixed data = ADX technique = quanew method = gauss maxiter = 200;
		parms K_MDLX1_HAT = 1, &K_1_MDLX1_TIL., &K_0_MDLX1_TIL.
						DLT_MDLX1_HAT = &DLT_MDLX1_TIL., 0
						P_0_MDLX1_HAT = 0.5, &P_0_MDLX1_TIL.
						SGM_GAM_MDLX1_HAT = 0.0001, 0.001, 0.01, 0.1, 1, 10, 100, 1000, 10000 /* Variance */
						SGM_EPS_MDLX1_HAT = 0.0001, 0.001, 0.01, 0.1, 1, 10, 100, 1000, 10000 /* Variance */;
		bounds -1 < DLT_MDLX1_HAT < 1, SGM_GAM_MDLX1_HAT > 0, SGM_EPS_MDLX1_HAT > 0;
		model X_2 ~ normal (J*(((DLT_MDLX1_HAT+P_0_MDLX1_HAT)/(K_MDLX1_HAT*(1-(DLT_MDLX1_HAT+P_0_MDLX1_HAT))))+(DLT_MDLX1_HAT+P_0_MDLX1_HAT)*&Q_1.*X_1)
											+ (1-J)*((P_0_MDLX1_HAT/(K_MDLX1_HAT*(1-P_0_MDLX1_HAT)))+P_0_MDLX1_HAT*&Q_0.*X_1) + GAM_MDLX1_HAT, SGM_EPS_MDLX1_HAT);
		random GAM_MDLX1_HAT ~ normal (0, SGM_GAM_MDLX1_HAT) subject = ID;
		ods output ParameterEstimates = PES FitStatistics = FST ConvergenceStatus = CGS;
	run;

/* 3_LOG */
proc printto log = 'YOUR_PATH_TO_DIRECTORY\3_LOG\SIM_02_EstimationDelta_OUT_19Feb2025_KKK.txt' new;
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
/* Output of log warnings to the dataset */
data WNG;
	/* 3_LOG */
	infile 'YOUR_PATH_TO_DIRECTORY\3_LOG\SIM_02_EstimationDelta_WNG_19Feb2025_KKK.txt' truncover;
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
	* Input: ADX
	* Output: MDLX2
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
/* Least squares estimation for initial values of parameters */

/* Case */
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
data ADQ;
	set ADX (obs = 1);
	keep Q_1;
run;
data CAS;
	merge CAS ADQ;
run;
data CAS;
	set CAS;
		P_1_MDLX2_TIL = Q_1_HAT/BET_1_MDLX2_TIL;
			if P_1_MDLX2_TIL <= 0 or P_1_MDLX2_TIL >= 1 or P_1_MDLX2_TIL = . then P_1_MDLX2_TIL = 0.5;
		K_1_MDLX2_TIL = 1/(ALP_1_MDLX2_TIL*(P_1_MDLX2_TIL-1));
			if K_1_MDLX2_TIL <= 0 or K_1_MDLX2_TIL = . then K_1_MDLX2_TIL = 1;
	keep Q_1 K_1_MDLX2_TIL P_1_MDLX2_TIL;
run;
/* Control */
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
data ADQ;
	set ADX (obs = 1);
	keep Q_0;
run;
data CTL;
	merge CTL ADQ;
run;
data CTL;
	set CTL;
		P_0_MDLX2_TIL = Q_0_HAT/BET_0_MDLX2_TIL;
			if P_0_MDLX2_TIL <= 0 or P_0_MDLX2_TIL >= 1 or P_0_MDLX2_TIL = . then P_0_MDLX2_TIL = 0.5;
		K_0_MDLX2_TIL = 1/(ALP_0_MDLX2_TIL*(P_0_MDLX2_TIL-1));
			if K_0_MDLX2_TIL <= 0 or K_0_MDLX2_TIL = . then K_0_MDLX2_TIL = 1;
	keep Q_0 K_0_MDLX2_TIL P_0_MDLX2_TIL;
run;
/* Integration */
data MDLX2;
	merge CAS CTL;
		DLT_MDLX2_TIL = P_1_MDLX2_TIL - P_0_MDLX2_TIL;
run;

/* Maximum likelihood estimation */

data _null_;
	set MDLX2;
		call symputx ('Q_1', Q_1);
		call symputx ('K_1_MDLX2_TIL', K_1_MDLX2_TIL);
		call symputx ('DLT_MDLX2_TIL', DLT_MDLX2_TIL);
		call symputx ('Q_0', Q_0);
		call symputx ('K_0_MDLX2_TIL', K_0_MDLX2_TIL);
		call symputx ('P_0_MDLX2_TIL', P_0_MDLX2_TIL);
run;

/* 3_LOG */
proc printto log = 'YOUR_PATH_TO_DIRECTORY\3_LOG\SIM_02_EstimationDelta_WNG_19Feb2025_KKK.txt' new;
run;

	proc nlmixed data = ADX technique = quanew method = gauss maxiter = 200;
		parms K_MDLX2_HAT = 1, &K_1_MDLX2_TIL., &K_0_MDLX2_TIL.
						DLT_MDLX2_HAT = &DLT_MDLX2_TIL., 0
						P_0_MDLX2_HAT = 0.5, &P_0_MDLX2_TIL.
						SGM_GAM_MDLX2_HAT = 0.0001, 0.001, 0.01, 0.1, 1, 10, 100, 1000, 10000 /* Variance */
						SGM_EPS_MDLX2_HAT = 0.0001, 0.001, 0.01, 0.1, 1, 10, 100, 1000, 10000 /* Variance */;
		bounds -1 < DLT_MDLX2_HAT < 1, SGM_GAM_MDLX2_HAT > 0, SGM_EPS_MDLX2_HAT > 0;
		model X_2 ~ normal (J*((1/(K_MDLX2_HAT*(DLT_MDLX2_HAT+P_0_MDLX2_HAT-1)))+(&Q_1./(DLT_MDLX2_HAT+P_0_MDLX2_HAT))*X_1)
											+ (1-J)*((1/(K_MDLX2_HAT*(P_0_MDLX2_HAT-1)))+(&Q_0./P_0_MDLX2_HAT)*X_1) + GAM_MDLX2_HAT, SGM_EPS_MDLX2_HAT);
		random GAM_MDLX2_HAT ~ normal (0, SGM_GAM_MDLX2_HAT) subject = ID;
		ods output ParameterEstimates = PES FitStatistics = FST ConvergenceStatus = CGS;
	run;

/* 3_LOG */
proc printto log = 'YOUR_PATH_TO_DIRECTORY\3_LOG\SIM_02_EstimationDelta_OUT_19Feb2025_KKK.txt' new;
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
	infile 'YOUR_PATH_TO_DIRECTORY\3_LOG\SIM_02_EstimationDelta_WNG_19Feb2025_KKK.txt' truncover;
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
	* Input: MDLX1, MDLX2
	* Output: MPE
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
/* Integration of Model X1 and X2 */
data MPE;
	merge MDLX1 MDLX2;
	LLR = LLH_MDLX1 - LLH_MDLX2;
run;
data MPE;
	set MPE;
		/* Non-estimation */
		if (STT_MDLX1 ^= 0 or WNF_MDLX1 = 1) and (STT_MDLX2 ^= 0 or WNF_MDLX2 = 1) then do;
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
	keep K_MDLX1_HAT K_MDLX2_HAT
				DLT_MDLX1_HAT DLT_MDLX2_HAT
				P_0_MDLX1_HAT P_0_MDLX2_HAT
				SGM_GAM_MDLX1_HAT SGM_GAM_MDLX2_HAT 
				SGM_EPS_MDLX1_HAT SGM_EPS_MDLX2_HAT 
				V_MDLX1_HAT V_MDLX2_HAT
				LH_MDLX1 LH_MDLX2 LLR MPE;
run;

%mend MPE;

%macro ITE (NMB);

* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
* Run 1,000 iterations
	* Input: MPE
	* Output: ADS.SIM_MPE_SNR_&NMB.
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
data ADS.SIM_MPE_SNR_&NMB.;
run; 
%do F = 1 %to 1000; 
	%MPE (NMB = &NMB., F = &F.); 
	data ADS.SIM_MPE_SNR_&NMB.;
		set ADS.SIM_MPE_SNR_&NMB. MPE;
    run;
	proc datasets lib = WORK kill nolist; 
	run;
%end;
data ADS.SIM_MPE_SNR_&NMB.;
	set ADS.SIM_MPE_SNR_&NMB.;
		if _n_ = 1 then delete;
run;

%mend ITE;

%ITE (NMB = 01);
%ITE (NMB = 02);
%ITE (NMB = 03);
%ITE (NMB = 04);
%ITE (NMB = 05);
%ITE (NMB = 06);
%ITE (NMB = 07);
%ITE (NMB = 08);
%ITE (NMB = 09);
%ITE (NMB = 10);
%ITE (NMB = 11);
%ITE (NMB = 12);
%ITE (NMB = 13);
%ITE (NMB = 14);
%ITE (NMB = 15);
%ITE (NMB = 16);
%ITE (NMB = 17);
%ITE (NMB = 18);
%ITE (NMB = 19);
%ITE (NMB = 20);
%ITE (NMB = 21);
%ITE (NMB = 22);
%ITE (NMB = 23);
%ITE (NMB = 24);
%ITE (NMB = 25);
%ITE (NMB = 26);
%ITE (NMB = 27);
%ITE (NMB = 28);
%ITE (NMB = 29);
%ITE (NMB = 30);
%ITE (NMB = 31);
%ITE (NMB = 32);
%ITE (NMB = 33);
%ITE (NMB = 34);
%ITE (NMB = 35);
%ITE (NMB = 36);
%ITE (NMB = 37);
%ITE (NMB = 38);
%ITE (NMB = 39);
%ITE (NMB = 40);
%ITE (NMB = 41);
%ITE (NMB = 42);
%ITE (NMB = 43);
%ITE (NMB = 44);
%ITE (NMB = 45);
%ITE (NMB = 46);
%ITE (NMB = 47);
%ITE (NMB = 48);
















