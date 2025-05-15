********************************************************************************************************************;
* Project: Model-based detection of aberrant protein-protein interactions through pathway maps and gene expression levels
* Program: LUSC_01_CreationProteinLevels_4May2025_KKK.sas
* Objective: Creation of protein levels
* Author: Kenta Kevee Kisai
* SAS version: 9.4
* Platform: Windows
* Made: 7 July 2024
* Update: 4 May 2025
* Note: 
********************************************************************************************************************;
/* 3_LOG */
proc printto log = 'YOUR_PATH_TO_DIRECTORY\3_LOG\LUSC_01_CreationProteinLevels_4May2025_KKK.txt' new;
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
* Load the file without opening it
	* Input: Group_8Jul2024.xlsx, UnstrandedTPM_9Jul2024.xlsx
	* Output: GROUP, TPM
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
/* 1_RAW */
proc import out = GROUP
	datafile = 'YOUR_PATH_TO_DIRECTORY\1_RAW\2_TCGA_LUSC_RNASeq_Group_8Jul2024.xlsx'
	dbms = xlsx replace;
	datarow = 2;
	getnames = yes;
run;
proc import out = TPM
	datafile = 'YOUR_PATH_TO_DIRECTORY\1_RAW\2_TCGA_LUSC_RNASeq_UnstrandedTPM_9Jul2024.xlsx'
	dbms = xlsx replace;
	datarow = 2;
	getnames = yes;
run;

* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
* Integrate the GROUP and TPM datasets
	* Input: GROUP, TPM
	* Output: EXP
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
/* GROUP */
proc sort data = GROUP;
	by ID;
run;
/* TRM */
proc transpose data = TPM out = TPM;
	var TCGA_22_4593_Case
			TCGA_22_4593_Control
			TCGA_22_4609_Case
			TCGA_22_4609_Control
			TCGA_22_5471_Case
			TCGA_22_5471_Control
			TCGA_22_5472_Case
			TCGA_22_5472_Control
			TCGA_22_5478_Case
			TCGA_22_5478_Control
			TCGA_22_5481_Case
			TCGA_22_5481_Control
			TCGA_22_5482_Case
			TCGA_22_5482_Control
			TCGA_22_5483_Case
			TCGA_22_5483_Control
			TCGA_22_5489_Case
			TCGA_22_5489_Control
			TCGA_22_5491_Case
			TCGA_22_5491_Control
			TCGA_33_4587_Case
			TCGA_33_4587_Control
			TCGA_33_6737_Case
			TCGA_33_6737_Control
			TCGA_34_7107_Case
			TCGA_34_7107_Control
			TCGA_34_8454_Case
			TCGA_34_8454_Control
			TCGA_39_5040_Case
			TCGA_39_5040_Control
			TCGA_43_3394_Case
			TCGA_43_3394_Control
			TCGA_43_5670_Case
			TCGA_43_5670_Control
			TCGA_43_6143_Case
			TCGA_43_6143_Control
			TCGA_43_6647_Case
			TCGA_43_6647_Control
			TCGA_43_6771_Case
			TCGA_43_6771_Control
			TCGA_43_6773_Case
			TCGA_43_6773_Control
			TCGA_43_7657_Case
			TCGA_43_7657_Control
			TCGA_43_7658_Case
			TCGA_43_7658_Control
			TCGA_51_4079_Case
			TCGA_51_4079_Control
			TCGA_51_4080_Case
			TCGA_51_4080_Control
			TCGA_51_4081_Case
			TCGA_51_4081_Control
			TCGA_56_7222_Case
			TCGA_56_7222_Control
			TCGA_56_7579_Case
			TCGA_56_7579_Control
			TCGA_56_7580_Case
			TCGA_56_7580_Control
			TCGA_56_7582_Case
			TCGA_56_7582_Control
			TCGA_56_7730_Case
			TCGA_56_7730_Control
			TCGA_56_7731_Case
			TCGA_56_7731_Control
			TCGA_56_7823_Case
			TCGA_56_7823_Control
			TCGA_56_8082_Case
			TCGA_56_8082_Control
			TCGA_56_8083_Case
			TCGA_56_8083_Control
			TCGA_56_8201_Case
			TCGA_56_8201_Control
			TCGA_56_8309_Case
			TCGA_56_8309_Control
			TCGA_56_8623_Case
			TCGA_56_8623_Control
			TCGA_58_8386_Case
			TCGA_58_8386_Control
			TCGA_60_2709_Case
			TCGA_60_2709_Control
			TCGA_77_7138_Case
			TCGA_77_7138_Control
			TCGA_77_7142_Case
			TCGA_77_7142_Control
			TCGA_77_7335_Case
			TCGA_77_7335_Control
			TCGA_77_7337_Case
			TCGA_77_7337_Control
			TCGA_77_7338_Case
			TCGA_77_7338_Control
			TCGA_77_8007_Case
			TCGA_77_8007_Control
			TCGA_77_8008_Case
			TCGA_77_8008_Control
			TCGA_85_7710_Case
			TCGA_85_7710_Control
			TCGA_90_6837_Case
			TCGA_90_6837_Control
			TCGA_90_7767_Case
			TCGA_90_7767_Control
			TCGA_92_7340_Case
			TCGA_92_7340_Control;
	id GENE_ID;
run;
data TPM;
	set TPM;
		rename _NAME_ = ID;
run;
proc sort data = TPM;
	by ID;
run;
/* Integration */
data EXP;
	merge GROUP TPM;
	by ID;
run;

* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
* Create the steady-state protein levels in the mTOR pathway map
	* Input: EXP
	* Output: ADX
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
data ADX;
	set EXP;
		/* Grb10 */
		Grb10 = ENSG00000106070_20; /* GRB10 */
		/* R */
		R = min (ENSG00000140443_15, ENSG00000171105_14); /* IGF1R, NSR */
		/* S6K */
		S6K = (ENSG00000108443_14+ENSG00000175634_15); /* RPS6KB1, RPS6KB2 */
		/* IRS1 */
		IRS1 = ENSG00000169047_5; /* IRS1 */
		/* PI3K */
		PI3K = min ((ENSG00000121879_6+ENSG00000051382_9+ENSG00000171608_16), /* PIK3CA, PIK3CB, PIK3CD */
								(ENSG00000145675_15+ENSG00000105647_19+ENSG00000117461_15)); /* PIK3R1, PIK3R2, PIK3R3 */
		/* PDK1 */
		PDK1 = ENSG00000140992_19; /* PDPK1 */
		/* Akt */
		Akt = ENSG00000142208_17+ENSG00000105221_18+ENSG00000117020_18; /* AKT1, AKT2, AKT3 */
		/* IKKA */
		IKKA = ENSG00000213341_11; /* CHUK */
		/* mSin1 */
		mSin1 = ENSG00000119487_17; /* MAPKAP1 */
		/* Rictor */
		Rictor = ENSG00000164327_13; /* RICTOR */
		/* Protor */
		Protor = ENSG00000186654_21+ENSG00000135362_14; /* PRR5, PRR5L */
		/* mTOR */
		mTOR = ENSG00000198793_13/2; /* MTOR */
		/* mLST8 */
		mLST8 = ENSG00000167965_18/2; /* MLST8 */
		/* Tel2 */
		Tel2 = ENSG00000100726_15/2; /* TELO2 */
		/* Tti1 */
		Tti1 = ENSG00000101407_13/2; /* TTI1 */
		/* mTORC2 */
		mTORC2 = min (mSin1, Rictor, Protor, mTOR, mLST8, Tel2, Tti1);
		/* Rho */
		Rho = ENSG00000067560_13; /* RHOA */
		/* PKC */
		PKC = ENSG00000154229_12+ENSG00000166501_14+ENSG00000126583_11; /* PRKCA, PRKCB, PRKCG */
		/* SGK1 */
		SGK1 = ENSG00000118515_11; /* SGK1 */
		/* Grb2 */
		Grb2 = ENSG00000177885_15; /* GRB2 */
		/* SOS */
		SOS = ENSG00000115904_14+ENSG00000100485_12; /* SOS1, SOS2 */
		/* Ras */
		Ras = ENSG00000174775_17+ENSG00000220635_2+ENSG00000213281_5; /* HRAS, KRAS, NRAS */
		/* Raf */
		Raf = ENSG00000132155_13+ENSG00000157764_14; /* RAF1, BRAF */
		/* MEK */
		MEK = ENSG00000169032_10+ENSG00000126934_14; /* MAP2K1, MAP2K2 */
		/* ERK1 */
		ERK1 = ENSG00000100030_15+ENSG00000102882_12; /* MAPK1, MAPK3 */
		/* RSK */
		RSK = ENSG00000117676_14+ENSG00000071242_12+ENSG00000072133_11+ENSG00000177189_14; /* RPS6KA1, RPS6KA2, RPS6KA6, RPS6KA3 */
		/* TNFR */
		TNFR = ENSG00000067182_8/3; /* TNFRSF1A */
		/* IKKB */
		IKKB = ENSG00000104365_16; /* IKBKB */
		/* TSC1 */
		TSC1 = min (ENSG00000165699_15, ENSG00000103197_18); /* TSC1, TSC2 */
		/* TBC1D7 */
		TBC1D7 = ENSG00000145979_18; /* TBC1D7 */
		/* TSC1 */
		TSC1 = min (TSC1, TBC1D7);
		/* Rheb */
		Rheb = ENSG00000106615_10; /* RHEB */
		/* Frizzled */
		Frizzled = ENSG00000111432_4+ENSG00000180340_7+ENSG00000163251_4+
								ENSG00000104290_11+ENSG00000157240_4+ENSG00000174804_4+
								ENSG00000164930_12+ENSG00000155760_2+	ENSG00000177283_7+
								ENSG00000188763_5; /* FZD10, FZD2, FZD5, FZD3, FZD1, FZD4, FZD6, FZD7, FZD8, FZD9 */
		/* LRP5 */
		LRP5 = ENSG00000070018_9+ENSG00000162337_12; /* LRP6, LRP5 */
		/* Frizzled */
		Frizzled =  min (Frizzled, LRP5);
		/* Dvl */
		Dvl = ENSG00000107404_20+ENSG00000004975_12+ENSG00000161202_20; /* DVL1, DVL2, DVL3 */
		/* GSK3B */
		GSK3B = ENSG00000082701_17; /* GSK3B */
		/* REDD1 */
		REDD1 = ENSG00000168209_5; /* DDIT4 */
		/* AMPK */
		AMPK = ENSG00000132356_11+ENSG00000162409_11; /* PRKAA1, PRKAA2 */
		/* STRAD */
		STRAD = ENSG00000082146_13+ENSG00000266173_7; /* STRADB, STRADA */
		/* LKB1 */
		LKB1 = ENSG00000118046_16; /* STK11 */
		/* MO25 */
		MO25 = ENSG00000135932_11+ENSG00000102547_19; /* CAB39, CAB39L */
		/* STRAD */
		STRAD = min (STRAD, LKB1, MO25);
		/* SLC38A9 */
		SLC38A9 = ENSG00000177058_12; /* SLC38A9 */
		/* VATPase */
		VATPase = min (ENSG00000114573_10/3, (ENSG00000116039_13+ENSG00000147416_11)/3, 
										(ENSG00000155097_12+ENSG00000143882_12), ENSG00000100554_12,
										(ENSG00000131100_13+ENSG00000250565_7), ENSG00000128524_5,
										(ENSG00000136888_8+ENSG00000213760_11+ENSG00000151418_12),
										ENSG00000047249_18); /* ATP6V1A, ATP6V1B1, ATP6V1B2, ATP6V1C1, ATP6V1C2,
										ATP6V1D, ATP6V1E1, ATP6V1E2, ATP6V1F, ATP6V1G1, ATP6V1G2, ATP6V1G3, ATP6V1H */
		/* Ragulator */
		Ragulator = min (ENSG00000134248_14, ENSG00000116586_12, ENSG00000188186_10, 
											ENSG00000149357_10, ENSG00000109270_13); /* LAMTOR5, LAMTOR2, 
											LAMTOR4, LAMTOR1, LAMTOR3 */
		/* FNIP */
		FNIP = ENSG00000052795_13+ENSG00000217128_12; /* FNIP2, FNIP1 */
		/* FLCN */
		FLCN = ENSG00000154803_13; /* FLCN */
		/* FNIP */
		FNIP = min (FNIP, FLCN);
		/* RagA */
		RagA = ENSG00000155876_6+ENSG00000083750_13; /* RRAGA, RRAGB */
		/* RagC */
		RagC = ENSG00000025039_15+ENSG00000116954_8; /* RRAGD, RRAGC */
		/* RagA */
		RagA = min (RagA, RagC);
		/* SESN2 */
		SESN2 = ENSG00000130766_5; /* SESN2 */
		/* CASTOR1 */
		CASTOR1 = ENSG00000239282_8; /* CASTOR1 */
		/* CASTOR2 */
		CASTOR2 = ENSG00000274070_2; /* CASTOR2 */
		/* CASTOR1 */
		CASTOR1 = min (CASTOR1, CASTOR2);
		/* GATOR2 */
		GATOR2 = min (ENSG00000164654_16, ENSG00000157020_18, ENSG00000103091_15, 
										ENSG00000085415_16, ENSG00000127580_17); /* MIOS, SEC13, WDR59, SEH1L, WDR24 */
		/* GATOR1 */
		GATOR1 = min (ENSG00000114388_14, ENSG00000103148_17, ENSG00000100150_20); /* NPRL2, NPRL3, DEPDC5 */
		/* Skp2 */
		Skp2 = ENSG00000145604_17; /* SKP2 */
		/* RNF152 */
		RNF152 = ENSG00000176641_11; /* RNF152 */
		/* Raptor */
		Raptor = ENSG00000141564_15; /* RPTOR */
		/* PRAS40 */
		PRAS40 = ENSG00000204673_11; /* AKT1S1 */
		/* mTORC1 */
		mTORC1 = min (Raptor, mTOR, mLST8, Tel2, Tti1);
		/* CLIP170 */
		CLIP170 = ENSG00000130779_21; /* CLIP1 */
		/* Lipin1 */
		Lipin1 = ENSG00000134324_12+ENSG00000132793_12+ENSG00000101577_10; /* LPIN1, LPIN3, LPIN2 */
		/* ATG1 */
		ATG1 = ENSG00000177169_10+ENSG00000083290_20; /* ULK1, ULK2 */
		/* 4EBP */
		_4EBP_ = ENSG00000187840_5; /* EIF4EBP1 */
		/* eIF4E */
		eIF4E = ENSG00000151247_12+ENSG00000175766_13+ENSG00000135930_14; /* EIF4E, EIF4E1B, EIF4E2 */
		/* eIF4B */
		eIF4B = ENSG00000063046_18; /* EIF4B */
		/* S6 */
		S6 = ENSG00000137154_13; /* RPS6 */ 
		/* Deptor */
		Deptor = ENSG00000155792_10/2; /* DEPTOR */
	keep ID GROUP Grb10 R S6K IRS1 PI3K PDK1 Akt IKKA mTORC2 Rho PKC SGK1 Grb2 SOS Ras Raf MEK 
				ERK1 RSK TNFR IKKB TSC1 Rheb Frizzled Dvl GSK3B REDD1 AMPK STRAD SLC38A9 VATPase 
				Ragulator FNIP RagA SESN2 CASTOR1 GATOR2 GATOR1 Skp2 RNF152 mTORC1 CLIP170 
				Lipin1 ATG1 _4EBP_ eIF4E eIF4B S6 Deptor PRAS40;
run;

* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
* Create the protein levels for each interaction in the mTOR pathway map
	* Input: ADX
	* Output: ADS.LUSC_ADX_&PPI.
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
/* Grb10_R */
data ADS.LUSC_ADX_Grb10_R;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = Grb10/2;
		X_2 = R/2;
		if GROUP = 'LUSC' then J = 1;
			else J = 0; 
	keep ID X_1 X_2 J;
run;
/* R_IRS1 */
data ADS.LUSC_ADX_R_IRS1;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = R/2;
		X_2 = IRS1/2;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* S6K_IRS1 */
data ADS.LUSC_ADX_S6K_IRS1;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = S6K/4;
		X_2 = IRS1/2;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* IRS1_PI3K */
data ADS.LUSC_ADX_IRS1_PI3K;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = IRS1;
		X_2 = PI3K;
		if GROUP = 'LUSC' then J = 1;
			else J = 0; 
	keep ID X_1 X_2 J;
run;
/* PI3K_mTORC2 */
data ADS.LUSC_ADX_PI3K_mTORC2;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = PI3K/2;
		X_2 = mTORC2/4;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* PDK1_Akt */
data ADS.LUSC_ADX_PDK1_Akt;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = PDK1;
		X_2 = Akt/2;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* Akt_IKKA */
data ADS.LUSC_ADX_Akt_IKKA;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = Akt/3;
		X_2 = IKKA;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* IKKA_mTORC2 */
data ADS.LUSC_ADX_IKKA_mTORC2;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = IKKA/2;
		X_2 = mTORC2/4;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* mTORC2_Rho */
data ADS.LUSC_ADX_mTORC2_Rho;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = mTORC2/4;
		X_2 = Rho;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* mTORC2_PKC */
data ADS.LUSC_ADX_mTORC2_PKC;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = mTORC2/4;
		X_2 = PKC;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* mTORC2_SGK1 */
data ADS.LUSC_ADX_mTORC2_SGK1;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = mTORC2/4;
		X_2 = SGK1;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* R_Grb2 */
data ADS.LUSC_ADX_R_Grb2;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = R/2;
		X_2 = Grb2;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* Grb2_SOS */
data ADS.LUSC_ADX_Grb2_SOS;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = Grb2;
		X_2 = SOS;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* SOS_Ras */
data ADS.LUSC_ADX_SOS_Ras;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = SOS;
		X_2 = Ras;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* Ras_Raf */
data ADS.LUSC_ADX_Ras_Raf;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = Ras;
		X_2 = Raf;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* Raf_MEK */
data ADS.LUSC_ADX_Raf_MEK;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = Raf;
		X_2 = MEK;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* MEK_ERK1 */
data ADS.LUSC_ADX_MEK_ERK1;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = MEK;
		X_2 = ERK1;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* ERK1_RSK */
data ADS.LUSC_ADX_ERK1_RSK;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = ERK1/2;
		X_2 = RSK;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* TNFR_IKKB */
data ADS.LUSC_ADX_TNFR_IKKB;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = TNFR;
		X_2 = IKKB;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* Frizzled_Dvl */
data ADS.LUSC_ADX_Frizzled_Dvl;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = Frizzled;
		X_2 = Dvl;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* Dvl_GSK3B */
data ADS.LUSC_ADX_Dvl_GSK3B;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = Dvl;
		X_2 = GSK3B;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* STRAD_AMPK */
data ADS.LUSC_ADX_STRAD_AMPK;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = STRAD;
		X_2 = AMPK/2;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* ERK1_TSC1 */
data ADS.LUSC_ADX_ERK1_TSC1;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = ERK1/2;
		X_2 = TSC1/7;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* RSK_TSC1 */
data ADS.LUSC_ADX_RSK_TSC1;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = RSK;
		X_2 = TSC1/7;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* IKKB_TSC1 */
data ADS.LUSC_ADX_IKKB_TSC1;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = IKKB;
		X_2 = TSC1/7;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* GSK3B_TSC1 */
data ADS.LUSC_ADX_GSK3B_TSC1;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = GSK3B;
		X_2 = TSC1/7;
		if GROUP = 'LUSC' then J = 1;
			else J = 0; 
	keep ID X_1 X_2 J;
run;
/* REDD1_TSC1 */
data ADS.LUSC_ADX_REDD1_TSC1;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = REDD1;
		X_2 = TSC1/7;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* AMPK_TSC1 */
data ADS.LUSC_ADX_AMPK_TSC1;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = AMPK/2;
		X_2 = TSC1/7;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* Akt_TSC1 */
data ADS.LUSC_ADX_Akt_TSC1;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = Akt/3;
		X_2 = TSC1/7;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* Akt_PRAS40 */
data ADS.LUSC_ADX_Akt_PRAS40;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = Akt/3;
		X_2 = PRAS40;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* IKKA_mTORC1 */
data ADS.LUSC_ADX_IKKA_mTORC1;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = IKKA/2;
		X_2 = mTORC1/6;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* TSC1_Rheb */
data ADS.LUSC_ADX_TSC1_Rheb;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = TSC1;
		X_2 = Rheb;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* Rheb_mTORC1 */
data ADS.LUSC_ADX_Rheb_mTORC1;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = Rheb;
		X_2 = mTORC1/6;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* AMPK_mTORC1 */
data ADS.LUSC_ADX_AMPK_mTORC1;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = AMPK/2;
		X_2 = mTORC1/6;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* SLC38A9_Ragulator */
data ADS.LUSC_ADX_SLC38A9_Ragulator;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = SLC38A9;
		X_2 = Ragulator/2;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* VATPase_Ragulator */
data ADS.LUSC_ADX_VATPase_Ragulator;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = VATPase;
		X_2 = Ragulator/2;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* FNIP_RagA */
data ADS.LUSC_ADX_FNIP_RagA;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = FNIP;
		X_2 = RagA/6;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* Ragulator_RagA */
data ADS.LUSC_ADX_Ragulator_RagA;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = Ragulator;
		X_2 = RagA/6;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* RagA_mTORC1 */
data ADS.LUSC_ADX_RagA_mTORC1;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = RagA;
		X_2 = mTORC1/6;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* SESN2_GATOR2 */
data ADS.LUSC_ADX_SESN2_GATOR2;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = SESN2;
		X_2 = GATOR2/2;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* CASTOR1_GATOR2 */
data ADS.LUSC_ADX_CASTOR1_GATOR2;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = CASTOR1;
		X_2 = GATOR2/2;
		if GROUP = 'LUSC' then J = 1;
			else J = 0; 
	keep ID X_1 X_2 J;
run;
/* GATOR2_GATOR1 */
data ADS.LUSC_ADX_GATOR2_GATOR1;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = GATOR2;
		X_2 = GATOR1;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* GATOR1_RagA */
data ADS.LUSC_ADX_GATOR1_RagA;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = GATOR1;
		X_2 = RagA/6;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* Skp2_RagA */
data ADS.LUSC_ADX_Skp2_RagA;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = Skp2;
		X_2 = RagA/6;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* RNF152_RagA */
data ADS.LUSC_ADX_RNF152_RagA;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = RNF152;
		X_2 = RagA/6;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* S6K_mTORC2 */
data ADS.LUSC_ADX_S6K_mTORC2;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = S6K/4;
		X_2 = mTORC2/4;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* mTORC1_CLIP170 */
data ADS.LUSC_ADX_mTORC1_CLIP170;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = mTORC1/6;
		X_2 = CLIP170;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* mTORC1_Grb10 */
data ADS.LUSC_ADX_mTORC1_Grb10;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = mTORC1/6;
		X_2 = Grb10;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* mTORC1_Lipin1 */
data ADS.LUSC_ADX_mTORC1_Lipin1;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = mTORC1/6;
		X_2 = Lipin1;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* mTORC1_ATG1 */
data ADS.LUSC_ADX_mTORC1_ATG1;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = mTORC1/6;
		X_2 = ATG1;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* mTORC1_4EBP */
data ADS.LUSC_ADX_mTORC1_4EBP;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = mTORC1/6;
		X_2 = _4EBP_;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* mTORC1_S6K */
data ADS.LUSC_ADX_mTORC1_S6K;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = mTORC1/6;
		X_2 = S6K;
		if GROUP = 'LUSC' then J = 1;
			else J = 0; 
	keep ID X_1 X_2 J;
run;
/* 4EBP_eIF4E */
data ADS.LUSC_ADX_4EBP_eIF4E;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = _4EBP_;
		X_2 = eIF4E;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* S6K_eIF4B */
data ADS.LUSC_ADX_S6K_eIF4B;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = S6K/4;
		X_2 = eIF4B;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* S6K_S6 */
data ADS.LUSC_ADX_S6K_S6;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = S6K/4;
		X_2 = S6;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* Deptor_mTORC1 */
data ADS.LUSC_ADX_Deptor_mTORC1;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = Deptor;
		X_2 = mTORC1/6;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* Deptor_mTORC2 */
data ADS.LUSC_ADX_Deptor_mTORC2;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = Deptor;
		X_2 = mTORC2/4;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* PRAS40_mTORC1 */
data ADS.LUSC_ADX_PRAS40_mTORC1;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = PRAS40;
		X_2 = mTORC1/6;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;
/* mTORC2_Akt */
data ADS.LUSC_ADX_mTORC2_Akt;
	set ADX;
		ID = substr (ID, 1, 12);
		X_1 = mTORC2/4;
		X_2 = Akt/2;
		if GROUP = 'LUSC' then J = 1;
			else J = 0;
	keep ID X_1 X_2 J;
run;

%macro MOX (PPI);

* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
* Calculate the mean of X_1 and X_2
	* Input: ADS.LUSC_ADX_&PPI. 
	* Output: ADS.LUSC_MOX_&PPI.
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
proc means data = ADS.LUSC_ADX_&PPI. mean;
	class J;
	output out = MOX mean =;
run;
/* Case */
data MOX_CAS;
	set MOX;
		where J = 1;
		MEAN_CAS_X1 = X_1;
		MEAN_CAS_X2 = X_2;
	keep MEAN_CAS_X1 MEAN_CAS_X2;
run;
/* Control */
data MOX_CTL;
	set MOX;
		where J = 0;
		MEAN_CTL_X1 = X_1;
		MEAN_CTL_X2 = X_2;
	keep MEAN_CTL_X1 MEAN_CTL_X2;
run;
/* Integration */
data ADS.LUSC_MOX_&PPI.;
	merge MOX_ALL MOX_CAS MOX_CTL;
run;

%mend MOX;

%MOX (PPI = Grb10_R);
%MOX (PPI = R_IRS1);
%MOX (PPI = S6K_IRS1);
%MOX (PPI = IRS1_PI3K);
%MOX (PPI = PI3K_mTORC2);
%MOX (PPI = PDK1_Akt);
%MOX (PPI = Akt_IKKA);
%MOX (PPI = IKKA_mTORC2);
%MOX (PPI = mTORC2_Rho);
%MOX (PPI = mTORC2_PKC);
%MOX (PPI = mTORC2_SGK1);
%MOX (PPI = R_Grb2);
%MOX (PPI = Grb2_SOS);
%MOX (PPI = SOS_Ras);
%MOX (PPI = Ras_Raf);
%MOX (PPI = Raf_MEK);
%MOX (PPI = MEK_ERK1);
%MOX (PPI = ERK1_RSK);
%MOX (PPI = TNFR_IKKB);
%MOX (PPI = Frizzled_Dvl);
%MOX (PPI = Dvl_GSK3B);
%MOX (PPI = STRAD_AMPK);
%MOX (PPI = ERK1_TSC1);
%MOX (PPI = RSK_TSC1);
%MOX (PPI = IKKB_TSC1);
%MOX (PPI = GSK3B_TSC1);
%MOX (PPI = REDD1_TSC1);
%MOX (PPI = AMPK_TSC1);
%MOX (PPI = Akt_TSC1);
%MOX (PPI = Akt_PRAS40);
%MOX (PPI = IKKA_mTORC1);
%MOX (PPI = TSC1_Rheb);
%MOX (PPI = Rheb_mTORC1);
%MOX (PPI = AMPK_mTORC1);
%MOX (PPI = SLC38A9_Ragulator);
%MOX (PPI = VATPase_Ragulator);
%MOX (PPI = FNIP_RagA);
%MOX (PPI = Ragulator_RagA);
%MOX (PPI = RagA_mTORC1);
%MOX (PPI = SESN2_GATOR2);
%MOX (PPI = CASTOR1_GATOR2);
%MOX (PPI = GATOR2_GATOR1);
%MOX (PPI = GATOR1_RagA);
%MOX (PPI = Skp2_RagA);
%MOX (PPI = RNF152_RagA);
%MOX (PPI = S6K_mTORC2);
%MOX (PPI = mTORC1_CLIP170);
%MOX (PPI = mTORC1_Grb10);
%MOX (PPI = mTORC1_Lipin1);
%MOX (PPI = mTORC1_ATG1);
%MOX (PPI = mTORC1_4EBP);
%MOX (PPI = mTORC1_S6K);
%MOX (PPI = 4EBP_eIF4E);
%MOX (PPI = S6K_eIF4B);
%MOX (PPI = S6K_S6);
%MOX (PPI = Deptor_mTORC1);
%MOX (PPI = Deptor_mTORC2);
%MOX (PPI = PRAS40_mTORC1);
%MOX (PPI = mTORC2_Akt);

* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
* Integrate the results of each interaction
	* Input: ADS.LUSC_MOX_&PPI.
	* Output: TLF.LUSC_MOX
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
data TLF.LUSC_MOX;
	set ADS.LUSC_MOX_Grb10_R 
			ADS.LUSC_MOX_R_IRS1 
			ADS.LUSC_MOX_S6K_IRS1 
			ADS.LUSC_MOX_IRS1_PI3K 
			ADS.LUSC_MOX_PI3K_mTORC2 
			ADS.LUSC_MOX_PDK1_Akt 
			ADS.LUSC_MOX_Akt_IKKA 
			ADS.LUSC_MOX_IKKA_mTORC2 
			ADS.LUSC_MOX_mTORC2_Rho
			ADS.LUSC_MOX_mTORC2_PKC 
			ADS.LUSC_MOX_mTORC2_SGK1
			ADS.LUSC_MOX_R_Grb2
			ADS.LUSC_MOX_Grb2_SOS
			ADS.LUSC_MOX_SOS_Ras
			ADS.LUSC_MOX_Ras_Raf
			ADS.LUSC_MOX_Raf_MEK
			ADS.LUSC_MOX_MEK_ERK1
			ADS.LUSC_MOX_ERK1_RSK
			ADS.LUSC_MOX_TNFR_IKKB
			ADS.LUSC_MOX_Frizzled_Dvl
			ADS.LUSC_MOX_Dvl_GSK3B
			ADS.LUSC_MOX_STRAD_AMPK
			ADS.LUSC_MOX_ERK1_TSC1
			ADS.LUSC_MOX_RSK_TSC1
			ADS.LUSC_MOX_IKKB_TSC1
			ADS.LUSC_MOX_GSK3B_TSC1
			ADS.LUSC_MOX_REDD1_TSC1
			ADS.LUSC_MOX_AMPK_TSC1
			ADS.LUSC_MOX_Akt_TSC1
			ADS.LUSC_MOX_Akt_PRAS40
			ADS.LUSC_MOX_IKKA_mTORC1
			ADS.LUSC_MOX_TSC1_Rheb
			ADS.LUSC_MOX_Rheb_mTORC1
			ADS.LUSC_MOX_AMPK_mTORC1
			ADS.LUSC_MOX_SLC38A9_Ragulator
			ADS.LUSC_MOX_VATPase_Ragulator
			ADS.LUSC_MOX_FNIP_RagA
			ADS.LUSC_MOX_Ragulator_RagA
			ADS.LUSC_MOX_RagA_mTORC1
			ADS.LUSC_MOX_SESN2_GATOR2
			ADS.LUSC_MOX_CASTOR1_GATOR2
			ADS.LUSC_MOX_GATOR2_GATOR1
			ADS.LUSC_MOX_GATOR1_RagA
			ADS.LUSC_MOX_Skp2_RagA
			ADS.LUSC_MOX_RNF152_RagA
			ADS.LUSC_MOX_S6K_mTORC2
			ADS.LUSC_MOX_mTORC1_CLIP170
			ADS.LUSC_MOX_mTORC1_Grb10
			ADS.LUSC_MOX_mTORC1_Lipin1
			ADS.LUSC_MOX_mTORC1_ATG1
			ADS.LUSC_MOX_mTORC1_4EBP
			ADS.LUSC_MOX_mTORC1_S6K
			ADS.LUSC_MOX_4EBP_eIF4E
			ADS.LUSC_MOX_S6K_eIF4B
			ADS.LUSC_MOX_S6K_S6
			ADS.LUSC_MOX_Deptor_mTORC1
			ADS.LUSC_MOX_Deptor_mTORC2
			ADS.LUSC_MOX_PRAS40_mTORC1
			ADS.LUSC_MOX_mTORC2_Akt;
run;














