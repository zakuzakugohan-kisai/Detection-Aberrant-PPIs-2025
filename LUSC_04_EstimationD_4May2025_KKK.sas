********************************************************************************************************************;
* Project: Model-based detection of aberrant protein-protein interactions 
					for exploration of aberrant signalling pathways 
					through pathway maps and gene expression levels
* Program: LUSC_04_EstimationD_4May2025_KKK.sas
* Objective: Estimation of D
* Author: Kenta Kevee Kisai
* SAS version: 9.4
* Platform: Windows
* Made: 7 July 2024
* Update: 4 May 2025
* Note: 
********************************************************************************************************************;
/* 3_LOG */
proc printto log = 'YOUR_PATH_TO_DIRECTORY\3_LOG\LUSC_04_EstimationD_4May2025_KKK.txt' new;
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

%macro EOD (PPI);

* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
* Estimate d
	* Input: ADS.LUSC_MPE_&PPI.
	* Output: ADS.LUSC_EOD_&PPI.
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
data EOD;
	set ADS.LUSC_MPE_&PPI.;
		/* ZERO */
		if MPE = 'ZERO' then do;
			ABS_D_HAT = 0.0;
		end;
		/* Non-estimation */
		else if MPE = 'NE' then do;
			ABS_D_HAT = 10.0;
		end;
		/* Model X1 */
		else if MPE = 'X1' then do;
			ABS_D_HAT = abs (DLT_MDLX1_HAT/V_MDLX1_HAT);
			if ABS_D_HAT > 10.0 then do;
				ABS_D_HAT = 10.0;
				ABS_D = 'OVER';
			end;
			else if ABS_D_HAT = . then do;
				ABS_D_HAT = 10.0;
				ABS_D = 'VHAT';
			end;
		end;
		/* Model X2 */
		else if MPE = 'X2' then do;
			ABS_D_HAT = abs (DLT_MDLX2_HAT/V_MDLX2_HAT);
			if ABS_D_HAT > 10.0 then do;
				ABS_D_HAT = 10.0;
				ABS_D = 'OVER';
			end;
			else if ABS_D_HAT = . then do;
				ABS_D_HAT = 10.0;
				ABS_D = 'VHAT';
			end;
		end;
		/* Model X3 */
		else if MPE = 'X3' then do;
			ABS_D_MDLX1_HAT = abs (DLT_MDLX1_HAT/V_MDLX1_HAT);
			ABS_D_MDLX2_HAT = abs (DLT_MDLX2_HAT/V_MDLX2_HAT);
			ABS_D_HAT = (LH_MDLX1/(LH_MDLX1+LH_MDLX2))*ABS_D_MDLX1_HAT
										+ (LH_MDLX2/(LH_MDLX1+LH_MDLX2))*ABS_D_MDLX2_HAT;
			if ABS_D_HAT > 10.0 then do;
				ABS_D_HAT = 10.0;
				ABS_D = 'OVER';
			end;
			else if ABS_D_HAT = . then do;
				ABS_D_HAT = 10.0;
				ABS_D = 'VHAT';
			end;
		end;
	keep MPE PPI LLR ABS_D_HAT ABS_D;
run;
/* Distinction between aberrant and normal interactions */
data ADS.LUSC_EOD_&PPI.;
	set EOD;
		if PPI in ('Akt_TSC1', 'TSC1_Rheb', 'Rheb_mTORC1', 'Akt_IKKA', 'IKKA_mTORC2',
			'mTORC2_Rho', 'mTORC2_PKC', 'mTORC2_SGK1', 'mTORC2_Akt', 'Grb2_SOS',
			'SOS_Ras', 'Ras_Raf', 'Raf_MEK', 'MEK_ERK1', 'Akt_PRAS40', 'S6K_mTORC2', 
			'mTORC1_CLIP170', 'mTORC1_Grb10', 'mTORC1_Lipin1', 'mTORC1_ATG1', 
			'mTORC1_4EBP', 'mTORC1_S6K', '4EBP_eIF4E', 'S6K_eIF4B', 'S6K_S6', 
			'PRAS40_mTORC1', 'IKKA_mTORC1') then AON = 'Aberrant'; else AON = 'Normal';
run;

%mend EOD;

%EOD (PPI = Grb10_R);
%EOD (PPI = R_IRS1);
%EOD (PPI = S6K_IRS1);
%EOD (PPI = IRS1_PI3K);
%EOD (PPI = PI3K_mTORC2);
%EOD (PPI = PDK1_Akt);
%EOD (PPI = Akt_IKKA);
%EOD (PPI = IKKA_mTORC2);
%EOD (PPI = mTORC2_Rho);
%EOD (PPI = mTORC2_PKC);
%EOD (PPI = mTORC2_SGK1);
%EOD (PPI = R_Grb2);
%EOD (PPI = Grb2_SOS);
%EOD (PPI = SOS_Ras);
%EOD (PPI = Ras_Raf);
%EOD (PPI = Raf_MEK);
%EOD (PPI = MEK_ERK1);
%EOD (PPI = ERK1_RSK);
%EOD (PPI = TNFR_IKKB);
%EOD (PPI = Frizzled_Dvl);
%EOD (PPI = Dvl_GSK3B);
%EOD (PPI = STRAD_AMPK);
%EOD (PPI = ERK1_TSC1);
%EOD (PPI = RSK_TSC1);
%EOD (PPI = IKKB_TSC1);
%EOD (PPI = GSK3B_TSC1);
%EOD (PPI = REDD1_TSC1);
%EOD (PPI = AMPK_TSC1);
%EOD (PPI = Akt_TSC1);
%EOD (PPI = Akt_PRAS40);
%EOD (PPI = IKKA_mTORC1);
%EOD (PPI = TSC1_Rheb);
%EOD (PPI = Rheb_mTORC1);
%EOD (PPI = AMPK_mTORC1);
%EOD (PPI = SLC38A9_Ragulator);
%EOD (PPI = VATPase_Ragulator);
%EOD (PPI = FNIP_RagA);
%EOD (PPI = Ragulator_RagA);
%EOD (PPI = RagA_mTORC1);
%EOD (PPI = SESN2_GATOR2);
%EOD (PPI = CASTOR1_GATOR2);
%EOD (PPI = GATOR2_GATOR1);
%EOD (PPI = GATOR1_RagA);
%EOD (PPI = Skp2_RagA);
%EOD (PPI = RNF152_RagA);
%EOD (PPI = S6K_mTORC2);
%EOD (PPI = mTORC1_CLIP170);
%EOD (PPI = mTORC1_Grb10);
%EOD (PPI = mTORC1_Lipin1);
%EOD (PPI = mTORC1_ATG1);
%EOD (PPI = mTORC1_4EBP);
%EOD (PPI = mTORC1_S6K);
%EOD (PPI = 4EBP_eIF4E);
%EOD (PPI = S6K_eIF4B);
%EOD (PPI = S6K_S6);
%EOD (PPI = Deptor_mTORC1);
%EOD (PPI = Deptor_mTORC2);
%EOD (PPI = PRAS40_mTORC1);
%EOD (PPI = mTORC2_Akt);

* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
* Integrate the results of each interaction
	* Input: ADS.LUSC_EOD_&PPI. 
	* Output: TLF.LUSC_EOD
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
data TLF.LUSC_EOD;
	set ADS.LUSC_EOD_Grb10_R 
			ADS.LUSC_EOD_R_IRS1 
			ADS.LUSC_EOD_S6K_IRS1 
			ADS.LUSC_EOD_IRS1_PI3K 
			ADS.LUSC_EOD_PI3K_mTORC2 
			ADS.LUSC_EOD_PDK1_Akt 
			ADS.LUSC_EOD_Akt_IKKA 
			ADS.LUSC_EOD_IKKA_mTORC2 
			ADS.LUSC_EOD_mTORC2_Rho
			ADS.LUSC_EOD_mTORC2_PKC 
			ADS.LUSC_EOD_mTORC2_SGK1
			ADS.LUSC_EOD_R_Grb2
			ADS.LUSC_EOD_Grb2_SOS
			ADS.LUSC_EOD_SOS_Ras
			ADS.LUSC_EOD_Ras_Raf
			ADS.LUSC_EOD_Raf_MEK
			ADS.LUSC_EOD_MEK_ERK1
			ADS.LUSC_EOD_ERK1_RSK
			ADS.LUSC_EOD_TNFR_IKKB
			ADS.LUSC_EOD_Frizzled_Dvl
			ADS.LUSC_EOD_Dvl_GSK3B
			ADS.LUSC_EOD_STRAD_AMPK
			ADS.LUSC_EOD_ERK1_TSC1
			ADS.LUSC_EOD_RSK_TSC1
			ADS.LUSC_EOD_IKKB_TSC1
			ADS.LUSC_EOD_GSK3B_TSC1
			ADS.LUSC_EOD_REDD1_TSC1
			ADS.LUSC_EOD_AMPK_TSC1
			ADS.LUSC_EOD_Akt_TSC1
			ADS.LUSC_EOD_Akt_PRAS40
			ADS.LUSC_EOD_IKKA_mTORC1
			ADS.LUSC_EOD_TSC1_Rheb
			ADS.LUSC_EOD_Rheb_mTORC1
			ADS.LUSC_EOD_AMPK_mTORC1
			ADS.LUSC_EOD_SLC38A9_Ragulator
			ADS.LUSC_EOD_VATPase_Ragulator
			ADS.LUSC_EOD_FNIP_RagA
			ADS.LUSC_EOD_Ragulator_RagA
			ADS.LUSC_EOD_RagA_mTORC1
			ADS.LUSC_EOD_SESN2_GATOR2
			ADS.LUSC_EOD_CASTOR1_GATOR2
			ADS.LUSC_EOD_GATOR2_GATOR1
			ADS.LUSC_EOD_GATOR1_RagA
			ADS.LUSC_EOD_Skp2_RagA
			ADS.LUSC_EOD_RNF152_RagA
			ADS.LUSC_EOD_S6K_mTORC2
			ADS.LUSC_EOD_mTORC1_CLIP170
			ADS.LUSC_EOD_mTORC1_Grb10
			ADS.LUSC_EOD_mTORC1_Lipin1
			ADS.LUSC_EOD_mTORC1_ATG1
			ADS.LUSC_EOD_mTORC1_4EBP
			ADS.LUSC_EOD_mTORC1_S6K
			ADS.LUSC_EOD_4EBP_eIF4E
			ADS.LUSC_EOD_S6K_eIF4B
			ADS.LUSC_EOD_S6K_S6
			ADS.LUSC_EOD_Deptor_mTORC1
			ADS.LUSC_EOD_Deptor_mTORC2
			ADS.LUSC_EOD_PRAS40_mTORC1
			ADS.LUSC_EOD_mTORC2_Akt;
run;














