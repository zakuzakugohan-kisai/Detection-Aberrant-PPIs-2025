********************************************************************************************************************;
* Project: Model-based quantification of protein-protein interaction aberrations 
					for exploring dysregulated signalling pathways through pathway maps and gene expression levels
* Program: SIM_01_GenerationData_250219_KKK.sas
* Objective: Generation of simulation data
* Author: Kenta Kevee Kisai
* SAS version: 9.4
* Platform: Windows
* Made: 2 September 2024
* Update: 19 February 2025
* Note: 
********************************************************************************************************************;
/* 3_LOG */
proc printto log = 'YOUR_PATH_TO_DIRECTORY\3_LOG\SIM_01_GenerationData_250219_KKK.txt' new;
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
* Generate simulation data
	* Input: None
	* Output: ADS.SIM_DAT_SNR_&NMB. 
* ------------------------------------------------------------------------------------------------------------------------------------------------------- *;
/* Scenario 1 */
data ADS.SIM_DAT_SNR_01;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 20;
				if 1 <= ID <= 1 then X_1 = 7;
					else if 2 <= ID <= 4 then X_1 = 9;
					else if 5 <= ID <= 8 then X_1 = 11;
					else if 9 <= ID <= 12 then X_1 = 13;
					else if 13 <= ID <= 17 then X_1 = 15;
					else if 18 <= ID <= 19 then X_1 = 17;
					else if 20 <= ID <= 20 then X_1 = 19;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.00;
				P_0 = 0.50;
				GAM = rand ('normal', 0, 0.1); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 0.1); /* Standard deviation */ 
						X_2 = J*(((DLT+P_0)/(K*(1-(DLT+P_0))))+(DLT+P_0)*Q_1*X_1) + (1-J)*((P_0/(K*(1-P_0)))+P_0*Q_0*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 2 */
data ADS.SIM_DAT_SNR_02;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 20;
				if 1 <= ID <= 1 then X_1 = 7;
					else if 2 <= ID <= 4 then X_1 = 9;
					else if 5 <= ID <= 8 then X_1 = 11;
					else if 9 <= ID <= 12 then X_1 = 13;
					else if 13 <= ID <= 17 then X_1 = 15;
					else if 18 <= ID <= 19 then X_1 = 17;
					else if 20 <= ID <= 20 then X_1 = 19;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.01;
				P_0 = 0.49;
				GAM = rand ('normal', 0, 0.1); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 0.1); /* Standard deviation */ 
						X_2 = J*(((DLT+P_0)/(K*(1-(DLT+P_0))))+(DLT+P_0)*Q_1*X_1) + (1-J)*((P_0/(K*(1-P_0)))+P_0*Q_0*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 3 */
data ADS.SIM_DAT_SNR_03;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 20;
				if 1 <= ID <= 1 then X_1 = 7;
					else if 2 <= ID <= 4 then X_1 = 9;
					else if 5 <= ID <= 8 then X_1 = 11;
					else if 9 <= ID <= 12 then X_1 = 13;
					else if 13 <= ID <= 17 then X_1 = 15;
					else if 18 <= ID <= 19 then X_1 = 17;
					else if 20 <= ID <= 20 then X_1 = 19;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.05;
				P_0 = 0.45;
				GAM = rand ('normal', 0, 0.1); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 0.1); /* Standard deviation */ 
						X_2 = J*(((DLT+P_0)/(K*(1-(DLT+P_0))))+(DLT+P_0)*Q_1*X_1) + (1-J)*((P_0/(K*(1-P_0)))+P_0*Q_0*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 4 */
data ADS.SIM_DAT_SNR_04;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 20;
				if 1 <= ID <= 1 then X_1 = 7;
					else if 2 <= ID <= 4 then X_1 = 9;
					else if 5 <= ID <= 8 then X_1 = 11;
					else if 9 <= ID <= 12 then X_1 = 13;
					else if 13 <= ID <= 17 then X_1 = 15;
					else if 18 <= ID <= 19 then X_1 = 17;
					else if 20 <= ID <= 20 then X_1 = 19;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.00;
				P_0 = 0.50;
				GAM = rand ('normal', 0, 0.5); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 0.5); /* Standard deviation */ 
						X_2 = J*(((DLT+P_0)/(K*(1-(DLT+P_0))))+(DLT+P_0)*Q_1*X_1) + (1-J)*((P_0/(K*(1-P_0)))+P_0*Q_0*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 5 */
data ADS.SIM_DAT_SNR_05;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 20;
				if 1 <= ID <= 1 then X_1 = 7;
					else if 2 <= ID <= 4 then X_1 = 9;
					else if 5 <= ID <= 8 then X_1 = 11;
					else if 9 <= ID <= 12 then X_1 = 13;
					else if 13 <= ID <= 17 then X_1 = 15;
					else if 18 <= ID <= 19 then X_1 = 17;
					else if 20 <= ID <= 20 then X_1 = 19;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.01;
				P_0 = 0.49;
				GAM = rand ('normal', 0, 0.5); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 0.5); /* Standard deviation */ 
						X_2 = J*(((DLT+P_0)/(K*(1-(DLT+P_0))))+(DLT+P_0)*Q_1*X_1) + (1-J)*((P_0/(K*(1-P_0)))+P_0*Q_0*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 6 */
data ADS.SIM_DAT_SNR_06;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 20;
				if 1 <= ID <= 1 then X_1 = 7;
					else if 2 <= ID <= 4 then X_1 = 9;
					else if 5 <= ID <= 8 then X_1 = 11;
					else if 9 <= ID <= 12 then X_1 = 13;
					else if 13 <= ID <= 17 then X_1 = 15;
					else if 18 <= ID <= 19 then X_1 = 17;
					else if 20 <= ID <= 20 then X_1 = 19;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.05;
				P_0 = 0.45;
				GAM = rand ('normal', 0, 0.5); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 0.5); /* Standard deviation */ 
						X_2 = J*(((DLT+P_0)/(K*(1-(DLT+P_0))))+(DLT+P_0)*Q_1*X_1) + (1-J)*((P_0/(K*(1-P_0)))+P_0*Q_0*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 7 */
data ADS.SIM_DAT_SNR_07;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 20;
				if 1 <= ID <= 1 then X_1 = 7;
					else if 2 <= ID <= 4 then X_1 = 9;
					else if 5 <= ID <= 8 then X_1 = 11;
					else if 9 <= ID <= 12 then X_1 = 13;
					else if 13 <= ID <= 17 then X_1 = 15;
					else if 18 <= ID <= 19 then X_1 = 17;
					else if 20 <= ID <= 20 then X_1 = 19;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.00;
				P_0 = 0.50;
				GAM = rand ('normal', 0, 0.4); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 0.4); /* Standard deviation */ 
						X_2 = J*((1/(K*(DLT+P_0-1)))+(Q_1/(DLT+P_0))*X_1) + (1-J)*((1/(K*(P_0-1)))+(Q_0/P_0)*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 8 */
data ADS.SIM_DAT_SNR_08;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 20;
				if 1 <= ID <= 1 then X_1 = 7;
					else if 2 <= ID <= 4 then X_1 = 9;
					else if 5 <= ID <= 8 then X_1 = 11;
					else if 9 <= ID <= 12 then X_1 = 13;
					else if 13 <= ID <= 17 then X_1 = 15;
					else if 18 <= ID <= 19 then X_1 = 17;
					else if 20 <= ID <= 20 then X_1 = 19;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.01;
				P_0 = 0.49;
				GAM = rand ('normal', 0, 0.4); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 0.4); /* Standard deviation */ 
						X_2 = J*((1/(K*(DLT+P_0-1)))+(Q_1/(DLT+P_0))*X_1) + (1-J)*((1/(K*(P_0-1)))+(Q_0/P_0)*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 9 */
data ADS.SIM_DAT_SNR_09;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 20;
				if 1 <= ID <= 1 then X_1 = 7;
					else if 2 <= ID <= 4 then X_1 = 9;
					else if 5 <= ID <= 8 then X_1 = 11;
					else if 9 <= ID <= 12 then X_1 = 13;
					else if 13 <= ID <= 17 then X_1 = 15;
					else if 18 <= ID <= 19 then X_1 = 17;
					else if 20 <= ID <= 20 then X_1 = 19;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.05;
				P_0 = 0.45;
				GAM = rand ('normal', 0, 0.4); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 0.4); /* Standard deviation */ 
						X_2 = J*((1/(K*(DLT+P_0-1)))+(Q_1/(DLT+P_0))*X_1) + (1-J)*((1/(K*(P_0-1)))+(Q_0/P_0)*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 10 */
data ADS.SIM_DAT_SNR_10;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 20;
				if 1 <= ID <= 1 then X_1 = 7;
					else if 2 <= ID <= 4 then X_1 = 9;
					else if 5 <= ID <= 8 then X_1 = 11;
					else if 9 <= ID <= 12 then X_1 = 13;
					else if 13 <= ID <= 17 then X_1 = 15;
					else if 18 <= ID <= 19 then X_1 = 17;
					else if 20 <= ID <= 20 then X_1 = 19;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.00;
				P_0 = 0.50;
				GAM = rand ('normal', 0, 2); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 2); /* Standard deviation */ 
						X_2 = J*((1/(K*(DLT+P_0-1)))+(Q_1/(DLT+P_0))*X_1) + (1-J)*((1/(K*(P_0-1)))+(Q_0/P_0)*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 11 */
data ADS.SIM_DAT_SNR_11;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 20;
				if 1 <= ID <= 1 then X_1 = 7;
					else if 2 <= ID <= 4 then X_1 = 9;
					else if 5 <= ID <= 8 then X_1 = 11;
					else if 9 <= ID <= 12 then X_1 = 13;
					else if 13 <= ID <= 17 then X_1 = 15;
					else if 18 <= ID <= 19 then X_1 = 17;
					else if 20 <= ID <= 20 then X_1 = 19;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.01;
				P_0 = 0.49;
				GAM = rand ('normal', 0, 2); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 2); /* Standard deviation */ 
						X_2 = J*((1/(K*(DLT+P_0-1)))+(Q_1/(DLT+P_0))*X_1) + (1-J)*((1/(K*(P_0-1)))+(Q_0/P_0)*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 12 */
data ADS.SIM_DAT_SNR_12;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 20;
				if 1 <= ID <= 1 then X_1 = 7;
					else if 2 <= ID <= 4 then X_1 = 9;
					else if 5 <= ID <= 8 then X_1 = 11;
					else if 9 <= ID <= 12 then X_1 = 13;
					else if 13 <= ID <= 17 then X_1 = 15;
					else if 18 <= ID <= 19 then X_1 = 17;
					else if 20 <= ID <= 20 then X_1 = 19;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.05;
				P_0 = 0.45;
				GAM = rand ('normal', 0, 2); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 2); /* Standard deviation */ 
						X_2 = J*((1/(K*(DLT+P_0-1)))+(Q_1/(DLT+P_0))*X_1) + (1-J)*((1/(K*(P_0-1)))+(Q_0/P_0)*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 13 */
data ADS.SIM_DAT_SNR_13;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 20;
				if 1 <= ID <= 1 then X_1 = 55;
					else if 2 <= ID <= 2 then X_1 = 65;
					else if 3 <= ID <= 4 then X_1 = 75;
					else if 5 <= ID <= 7 then X_1 = 85;
					else if 8 <= ID <= 11 then X_1 = 95;
					else if 12 <= ID <= 14 then X_1 = 105;
					else if 15 <= ID <= 17 then X_1 = 115;
					else if 18 <= ID <= 18 then X_1 = 125;
					else if 19 <= ID <= 19 then X_1 = 135;
					else if 20 <= ID <= 20 then X_1 = 145;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.00;
				P_0 = 0.50;
				GAM = rand ('normal', 0, 0.5); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 0.5); /* Standard deviation */ 
						X_2 = J*(((DLT+P_0)/(K*(1-(DLT+P_0))))+(DLT+P_0)*Q_1*X_1) + (1-J)*((P_0/(K*(1-P_0)))+P_0*Q_0*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 14 */
data ADS.SIM_DAT_SNR_14;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 20;
				if 1 <= ID <= 1 then X_1 = 55;
					else if 2 <= ID <= 2 then X_1 = 65;
					else if 3 <= ID <= 4 then X_1 = 75;
					else if 5 <= ID <= 7 then X_1 = 85;
					else if 8 <= ID <= 11 then X_1 = 95;
					else if 12 <= ID <= 14 then X_1 = 105;
					else if 15 <= ID <= 17 then X_1 = 115;
					else if 18 <= ID <= 18 then X_1 = 125;
					else if 19 <= ID <= 19 then X_1 = 135;
					else if 20 <= ID <= 20 then X_1 = 145;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.01;
				P_0 = 0.49;
				GAM = rand ('normal', 0, 0.5); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 0.5); /* Standard deviation */ 
						X_2 = J*(((DLT+P_0)/(K*(1-(DLT+P_0))))+(DLT+P_0)*Q_1*X_1) + (1-J)*((P_0/(K*(1-P_0)))+P_0*Q_0*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 15 */
data ADS.SIM_DAT_SNR_15;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 20;
				if 1 <= ID <= 1 then X_1 = 55;
					else if 2 <= ID <= 2 then X_1 = 65;
					else if 3 <= ID <= 4 then X_1 = 75;
					else if 5 <= ID <= 7 then X_1 = 85;
					else if 8 <= ID <= 11 then X_1 = 95;
					else if 12 <= ID <= 14 then X_1 = 105;
					else if 15 <= ID <= 17 then X_1 = 115;
					else if 18 <= ID <= 18 then X_1 = 125;
					else if 19 <= ID <= 19 then X_1 = 135;
					else if 20 <= ID <= 20 then X_1 = 145;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.05;
				P_0 = 0.45;
				GAM = rand ('normal', 0, 0.5); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 0.5); /* Standard deviation */
						X_2 = J*(((DLT+P_0)/(K*(1-(DLT+P_0))))+(DLT+P_0)*Q_1*X_1) + (1-J)*((P_0/(K*(1-P_0)))+P_0*Q_0*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 16 */
data ADS.SIM_DAT_SNR_16;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 20;
				if 1 <= ID <= 1 then X_1 = 55;
					else if 2 <= ID <= 2 then X_1 = 65;
					else if 3 <= ID <= 4 then X_1 = 75;
					else if 5 <= ID <= 7 then X_1 = 85;
					else if 8 <= ID <= 11 then X_1 = 95;
					else if 12 <= ID <= 14 then X_1 = 105;
					else if 15 <= ID <= 17 then X_1 = 115;
					else if 18 <= ID <= 18 then X_1 = 125;
					else if 19 <= ID <= 19 then X_1 = 135;
					else if 20 <= ID <= 20 then X_1 = 145;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.00;
				P_0 = 0.50;
				GAM = rand ('normal', 0, 2.5); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 2.5); /* Standard deviation */ 
						X_2 = J*(((DLT+P_0)/(K*(1-(DLT+P_0))))+(DLT+P_0)*Q_1*X_1) + (1-J)*((P_0/(K*(1-P_0)))+P_0*Q_0*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 17 */
data ADS.SIM_DAT_SNR_17;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 20;
				if 1 <= ID <= 1 then X_1 = 55;
					else if 2 <= ID <= 2 then X_1 = 65;
					else if 3 <= ID <= 4 then X_1 = 75;
					else if 5 <= ID <= 7 then X_1 = 85;
					else if 8 <= ID <= 11 then X_1 = 95;
					else if 12 <= ID <= 14 then X_1 = 105;
					else if 15 <= ID <= 17 then X_1 = 115;
					else if 18 <= ID <= 18 then X_1 = 125;
					else if 19 <= ID <= 19 then X_1 = 135;
					else if 20 <= ID <= 20 then X_1 = 145;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.01;
				P_0 = 0.49;
				GAM = rand ('normal', 0, 2.5); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 2.5); /* Standard deviation */ 
						X_2 = J*(((DLT+P_0)/(K*(1-(DLT+P_0))))+(DLT+P_0)*Q_1*X_1) + (1-J)*((P_0/(K*(1-P_0)))+P_0*Q_0*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 18 */
data ADS.SIM_DAT_SNR_18;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 20;
				if 1 <= ID <= 1 then X_1 = 55;
					else if 2 <= ID <= 2 then X_1 = 65;
					else if 3 <= ID <= 4 then X_1 = 75;
					else if 5 <= ID <= 7 then X_1 = 85;
					else if 8 <= ID <= 11 then X_1 = 95;
					else if 12 <= ID <= 14 then X_1 = 105;
					else if 15 <= ID <= 17 then X_1 = 115;
					else if 18 <= ID <= 18 then X_1 = 125;
					else if 19 <= ID <= 19 then X_1 = 135;
					else if 20 <= ID <= 20 then X_1 = 145;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.05;
				P_0 = 0.45;
				GAM = rand ('normal', 0, 2.5); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 2.5); /* Standard deviation */ 
						X_2 = J*(((DLT+P_0)/(K*(1-(DLT+P_0))))+(DLT+P_0)*Q_1*X_1) + (1-J)*((P_0/(K*(1-P_0)))+P_0*Q_0*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 19 */
data ADS.SIM_DAT_SNR_19;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 20;
				if 1 <= ID <= 1 then X_1 = 55;
					else if 2 <= ID <= 2 then X_1 = 65;
					else if 3 <= ID <= 4 then X_1 = 75;
					else if 5 <= ID <= 7 then X_1 = 85;
					else if 8 <= ID <= 11 then X_1 = 95;
					else if 12 <= ID <= 14 then X_1 = 105;
					else if 15 <= ID <= 17 then X_1 = 115;
					else if 18 <= ID <= 18 then X_1 = 125;
					else if 19 <= ID <= 19 then X_1 = 135;
					else if 20 <= ID <= 20 then X_1 = 145;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.00;
				P_0 = 0.50;
				GAM = rand ('normal', 0, 2); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 2); /* Standard deviation */ 
						X_2 = J*((1/(K*(DLT+P_0-1)))+(Q_1/(DLT+P_0))*X_1) + (1-J)*((1/(K*(P_0-1)))+(Q_0/P_0)*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 20 */
data ADS.SIM_DAT_SNR_20;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 20;
				if 1 <= ID <= 1 then X_1 = 55;
					else if 2 <= ID <= 2 then X_1 = 65;
					else if 3 <= ID <= 4 then X_1 = 75;
					else if 5 <= ID <= 7 then X_1 = 85;
					else if 8 <= ID <= 11 then X_1 = 95;
					else if 12 <= ID <= 14 then X_1 = 105;
					else if 15 <= ID <= 17 then X_1 = 115;
					else if 18 <= ID <= 18 then X_1 = 125;
					else if 19 <= ID <= 19 then X_1 = 135;
					else if 20 <= ID <= 20 then X_1 = 145;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.01;
				P_0 = 0.49;
				GAM = rand ('normal', 0, 2); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 2); /* Standard deviation */ 
						X_2 = J*((1/(K*(DLT+P_0-1)))+(Q_1/(DLT+P_0))*X_1) + (1-J)*((1/(K*(P_0-1)))+(Q_0/P_0)*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 21 */
data ADS.SIM_DAT_SNR_21;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 20;
				if 1 <= ID <= 1 then X_1 = 55;
					else if 2 <= ID <= 2 then X_1 = 65;
					else if 3 <= ID <= 4 then X_1 = 75;
					else if 5 <= ID <= 7 then X_1 = 85;
					else if 8 <= ID <= 11 then X_1 = 95;
					else if 12 <= ID <= 14 then X_1 = 105;
					else if 15 <= ID <= 17 then X_1 = 115;
					else if 18 <= ID <= 18 then X_1 = 125;
					else if 19 <= ID <= 19 then X_1 = 135;
					else if 20 <= ID <= 20 then X_1 = 145;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.05;
				P_0 = 0.45;
				GAM = rand ('normal', 0, 2); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 2); /* Standard deviation */ 
						X_2 = J*((1/(K*(DLT+P_0-1)))+(Q_1/(DLT+P_0))*X_1) + (1-J)*((1/(K*(P_0-1)))+(Q_0/P_0)*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 22 */
data ADS.SIM_DAT_SNR_22;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 20;
				if 1 <= ID <= 1 then X_1 = 55;
					else if 2 <= ID <= 2 then X_1 = 65;
					else if 3 <= ID <= 4 then X_1 = 75;
					else if 5 <= ID <= 7 then X_1 = 85;
					else if 8 <= ID <= 11 then X_1 = 95;
					else if 12 <= ID <= 14 then X_1 = 105;
					else if 15 <= ID <= 17 then X_1 = 115;
					else if 18 <= ID <= 18 then X_1 = 125;
					else if 19 <= ID <= 19 then X_1 = 135;
					else if 20 <= ID <= 20 then X_1 = 145;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.00;
				P_0 = 0.50;
				GAM = rand ('normal', 0, 10); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 10); /* Standard deviation */ 
						X_2 = J*((1/(K*(DLT+P_0-1)))+(Q_1/(DLT+P_0))*X_1) + (1-J)*((1/(K*(P_0-1)))+(Q_0/P_0)*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 23 */
data ADS.SIM_DAT_SNR_23;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 20;
				if 1 <= ID <= 1 then X_1 = 55;
					else if 2 <= ID <= 2 then X_1 = 65;
					else if 3 <= ID <= 4 then X_1 = 75;
					else if 5 <= ID <= 7 then X_1 = 85;
					else if 8 <= ID <= 11 then X_1 = 95;
					else if 12 <= ID <= 14 then X_1 = 105;
					else if 15 <= ID <= 17 then X_1 = 115;
					else if 18 <= ID <= 18 then X_1 = 125;
					else if 19 <= ID <= 19 then X_1 = 135;
					else if 20 <= ID <= 20 then X_1 = 145;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.01;
				P_0 = 0.49;
				GAM = rand ('normal', 0, 10); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 10); /* Standard deviation */ 
						X_2 = J*((1/(K*(DLT+P_0-1)))+(Q_1/(DLT+P_0))*X_1) + (1-J)*((1/(K*(P_0-1)))+(Q_0/P_0)*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 24 */
data ADS.SIM_DAT_SNR_24;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 20;
				if 1 <= ID <= 1 then X_1 = 55;
					else if 2 <= ID <= 2 then X_1 = 65;
					else if 3 <= ID <= 4 then X_1 = 75;
					else if 5 <= ID <= 7 then X_1 = 85;
					else if 8 <= ID <= 11 then X_1 = 95;
					else if 12 <= ID <= 14 then X_1 = 105;
					else if 15 <= ID <= 17 then X_1 = 115;
					else if 18 <= ID <= 18 then X_1 = 125;
					else if 19 <= ID <= 19 then X_1 = 135;
					else if 20 <= ID <= 20 then X_1 = 145;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.05;
				P_0 = 0.45;
				GAM = rand ('normal', 0, 10); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 10); /* Standard deviation */ 
						X_2 = J*((1/(K*(DLT+P_0-1)))+(Q_1/(DLT+P_0))*X_1) + (1-J)*((1/(K*(P_0-1)))+(Q_0/P_0)*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 25 */
data ADS.SIM_DAT_SNR_25;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 100;
				if 1 <= ID <= 5 then X_1 = 7;
					else if 6 <= ID <= 20 then X_1 = 9;
					else if 21 <= ID <= 40 then X_1 = 11;
					else if 41 <= ID <= 60 then X_1 = 13;
					else if 61 <= ID <= 85 then X_1 = 15;
					else if 86 <= ID <= 95 then X_1 = 17;
					else if 96 <= ID <= 100 then X_1 = 19;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.00;
				P_0 = 0.50;
				GAM = rand ('normal', 0, 0.1); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 0.1); /* Standard deviation */ 
						X_2 = J*(((DLT+P_0)/(K*(1-(DLT+P_0))))+(DLT+P_0)*Q_1*X_1) + (1-J)*((P_0/(K*(1-P_0)))+P_0*Q_0*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 26 */
data ADS.SIM_DAT_SNR_26;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 100;
				if 1 <= ID <= 5 then X_1 = 7;
					else if 6 <= ID <= 20 then X_1 = 9;
					else if 21 <= ID <= 40 then X_1 = 11;
					else if 41 <= ID <= 60 then X_1 = 13;
					else if 61 <= ID <= 85 then X_1 = 15;
					else if 86 <= ID <= 95 then X_1 = 17;
					else if 96 <= ID <= 100 then X_1 = 19;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.01;
				P_0 = 0.49;
				GAM = rand ('normal', 0, 0.1); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 0.1); /* Standard deviation */ 
						X_2 = J*(((DLT+P_0)/(K*(1-(DLT+P_0))))+(DLT+P_0)*Q_1*X_1) + (1-J)*((P_0/(K*(1-P_0)))+P_0*Q_0*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 27 */
data ADS.SIM_DAT_SNR_27;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 100;
				if 1 <= ID <= 5 then X_1 = 7;
					else if 6 <= ID <= 20 then X_1 = 9;
					else if 21 <= ID <= 40 then X_1 = 11;
					else if 41 <= ID <= 60 then X_1 = 13;
					else if 61 <= ID <= 85 then X_1 = 15;
					else if 86 <= ID <= 95 then X_1 = 17;
					else if 96 <= ID <= 100 then X_1 = 19;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.05;
				P_0 = 0.45;
				GAM = rand ('normal', 0, 0.1); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 0.1); /* Standard deviation */ 
						X_2 = J*(((DLT+P_0)/(K*(1-(DLT+P_0))))+(DLT+P_0)*Q_1*X_1) + (1-J)*((P_0/(K*(1-P_0)))+P_0*Q_0*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 28 */
data ADS.SIM_DAT_SNR_28;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 100;
				if 1 <= ID <= 5 then X_1 = 7;
					else if 6 <= ID <= 20 then X_1 = 9;
					else if 21 <= ID <= 40 then X_1 = 11;
					else if 41 <= ID <= 60 then X_1 = 13;
					else if 61 <= ID <= 85 then X_1 = 15;
					else if 86 <= ID <= 95 then X_1 = 17;
					else if 96 <= ID <= 100 then X_1 = 19;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.00;
				P_0 = 0.50;
				GAM = rand ('normal', 0, 0.5); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 0.5); /* Standard deviation */ 
						X_2 = J*(((DLT+P_0)/(K*(1-(DLT+P_0))))+(DLT+P_0)*Q_1*X_1) + (1-J)*((P_0/(K*(1-P_0)))+P_0*Q_0*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 29 */
data ADS.SIM_DAT_SNR_29;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 100;
				if 1 <= ID <= 5 then X_1 = 7;
					else if 6 <= ID <= 20 then X_1 = 9;
					else if 21 <= ID <= 40 then X_1 = 11;
					else if 41 <= ID <= 60 then X_1 = 13;
					else if 61 <= ID <= 85 then X_1 = 15;
					else if 86 <= ID <= 95 then X_1 = 17;
					else if 96 <= ID <= 100 then X_1 = 19;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.01;
				P_0 = 0.49;
				GAM = rand ('normal', 0, 0.5); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 0.5); /* Standard deviation */ 
						X_2 = J*(((DLT+P_0)/(K*(1-(DLT+P_0))))+(DLT+P_0)*Q_1*X_1) + (1-J)*((P_0/(K*(1-P_0)))+P_0*Q_0*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 30 */
data ADS.SIM_DAT_SNR_30;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 100;
				if 1 <= ID <= 5 then X_1 = 7;
					else if 6 <= ID <= 20 then X_1 = 9;
					else if 21 <= ID <= 40 then X_1 = 11;
					else if 41 <= ID <= 60 then X_1 = 13;
					else if 61 <= ID <= 85 then X_1 = 15;
					else if 86 <= ID <= 95 then X_1 = 17;
					else if 96 <= ID <= 100 then X_1 = 19;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.05;
				P_0 = 0.45;
				GAM = rand ('normal', 0, 0.5); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 0.5); /* Standard deviation */ 
						X_2 = J*(((DLT+P_0)/(K*(1-(DLT+P_0))))+(DLT+P_0)*Q_1*X_1) + (1-J)*((P_0/(K*(1-P_0)))+P_0*Q_0*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 31 */
data ADS.SIM_DAT_SNR_31;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 100;
				if 1 <= ID <= 5 then X_1 = 7;
					else if 6 <= ID <= 20 then X_1 = 9;
					else if 21 <= ID <= 40 then X_1 = 11;
					else if 41 <= ID <= 60 then X_1 = 13;
					else if 61 <= ID <= 85 then X_1 = 15;
					else if 86 <= ID <= 95 then X_1 = 17;
					else if 96 <= ID <= 100 then X_1 = 19;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.00;
				P_0 = 0.50;
				GAM = rand ('normal', 0, 0.4); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 0.4); /* Standard deviation */ 
						X_2 = J*((1/(K*(DLT+P_0-1)))+(Q_1/(DLT+P_0))*X_1) + (1-J)*((1/(K*(P_0-1)))+(Q_0/P_0)*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 32 */
data ADS.SIM_DAT_SNR_32;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 100;
				if 1 <= ID <= 5 then X_1 = 7;
					else if 6 <= ID <= 20 then X_1 = 9;
					else if 21 <= ID <= 40 then X_1 = 11;
					else if 41 <= ID <= 60 then X_1 = 13;
					else if 61 <= ID <= 85 then X_1 = 15;
					else if 86 <= ID <= 95 then X_1 = 17;
					else if 96 <= ID <= 100 then X_1 = 19;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.01;
				P_0 = 0.49;
				GAM = rand ('normal', 0, 0.4); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 0.4); /* Standard deviation */ 
						X_2 = J*((1/(K*(DLT+P_0-1)))+(Q_1/(DLT+P_0))*X_1) + (1-J)*((1/(K*(P_0-1)))+(Q_0/P_0)*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 33 */
data ADS.SIM_DAT_SNR_33;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 100;
				if 1 <= ID <= 5 then X_1 = 7;
					else if 6 <= ID <= 20 then X_1 = 9;
					else if 21 <= ID <= 40 then X_1 = 11;
					else if 41 <= ID <= 60 then X_1 = 13;
					else if 61 <= ID <= 85 then X_1 = 15;
					else if 86 <= ID <= 95 then X_1 = 17;
					else if 96 <= ID <= 100 then X_1 = 19;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.05;
				P_0 = 0.45;
				GAM = rand ('normal', 0, 0.4); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 0.4); /* Standard deviation */ 
						X_2 = J*((1/(K*(DLT+P_0-1)))+(Q_1/(DLT+P_0))*X_1) + (1-J)*((1/(K*(P_0-1)))+(Q_0/P_0)*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 34 */
data ADS.SIM_DAT_SNR_34;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 100;
				if 1 <= ID <= 5 then X_1 = 7;
					else if 6 <= ID <= 20 then X_1 = 9;
					else if 21 <= ID <= 40 then X_1 = 11;
					else if 41 <= ID <= 60 then X_1 = 13;
					else if 61 <= ID <= 85 then X_1 = 15;
					else if 86 <= ID <= 95 then X_1 = 17;
					else if 96 <= ID <= 100 then X_1 = 19;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.00;
				P_0 = 0.50;
				GAM = rand ('normal', 0, 2); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 2); /* Standard deviation */ 
						X_2 = J*((1/(K*(DLT+P_0-1)))+(Q_1/(DLT+P_0))*X_1) + (1-J)*((1/(K*(P_0-1)))+(Q_0/P_0)*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 35 */
data ADS.SIM_DAT_SNR_35;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 100;
				if 1 <= ID <= 5 then X_1 = 7;
					else if 6 <= ID <= 20 then X_1 = 9;
					else if 21 <= ID <= 40 then X_1 = 11;
					else if 41 <= ID <= 60 then X_1 = 13;
					else if 61 <= ID <= 85 then X_1 = 15;
					else if 86 <= ID <= 95 then X_1 = 17;
					else if 96 <= ID <= 100 then X_1 = 19;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.01;
				P_0 = 0.49;
				GAM = rand ('normal', 0, 2); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 2); /* Standard deviation */ 
						X_2 = J*((1/(K*(DLT+P_0-1)))+(Q_1/(DLT+P_0))*X_1) + (1-J)*((1/(K*(P_0-1)))+(Q_0/P_0)*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 36 */
data ADS.SIM_DAT_SNR_36;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 100;
				if 1 <= ID <= 5 then X_1 = 7;
					else if 6 <= ID <= 20 then X_1 = 9;
					else if 21 <= ID <= 40 then X_1 = 11;
					else if 41 <= ID <= 60 then X_1 = 13;
					else if 61 <= ID <= 85 then X_1 = 15;
					else if 86 <= ID <= 95 then X_1 = 17;
					else if 96 <= ID <= 100 then X_1 = 19;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.05;
				P_0 = 0.45;
				GAM = rand ('normal', 0, 2); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 2); /* Standard deviation */ 
						X_2 = J*((1/(K*(DLT+P_0-1)))+(Q_1/(DLT+P_0))*X_1) + (1-J)*((1/(K*(P_0-1)))+(Q_0/P_0)*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 37 */
data ADS.SIM_DAT_SNR_37;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 100;
				if 1 <= ID <= 5 then X_1 = 55;
					else if 6 <= ID <= 10 then X_1 = 65;
					else if 11 <= ID <= 20 then X_1 = 75;
					else if 21 <= ID <= 35 then X_1 = 85;
					else if 36 <= ID <= 55 then X_1 = 95;
					else if 56 <= ID <= 70 then X_1 = 105;
					else if 71 <= ID <= 85 then X_1 = 115;
					else if 86 <= ID <= 90 then X_1 = 125;
					else if 91 <= ID <= 95 then X_1 = 135;
					else if 96 <= ID <= 100 then X_1 = 145;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.00;
				P_0 = 0.50;
				GAM = rand ('normal', 0, 0.5); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 0.5); /* Standard deviation */ 
						X_2 = J*(((DLT+P_0)/(K*(1-(DLT+P_0))))+(DLT+P_0)*Q_1*X_1) + (1-J)*((P_0/(K*(1-P_0)))+P_0*Q_0*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 38 */
data ADS.SIM_DAT_SNR_38;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 100;
				if 1 <= ID <= 5 then X_1 = 55;
					else if 6 <= ID <= 10 then X_1 = 65;
					else if 11 <= ID <= 20 then X_1 = 75;
					else if 21 <= ID <= 35 then X_1 = 85;
					else if 36 <= ID <= 55 then X_1 = 95;
					else if 56 <= ID <= 70 then X_1 = 105;
					else if 71 <= ID <= 85 then X_1 = 115;
					else if 86 <= ID <= 90 then X_1 = 125;
					else if 91 <= ID <= 95 then X_1 = 135;
					else if 96 <= ID <= 100 then X_1 = 145;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.01;
				P_0 = 0.49;
				GAM = rand ('normal', 0, 0.5); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 0.5); /* Standard deviation */ 
						X_2 = J*(((DLT+P_0)/(K*(1-(DLT+P_0))))+(DLT+P_0)*Q_1*X_1) + (1-J)*((P_0/(K*(1-P_0)))+P_0*Q_0*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 39 */
data ADS.SIM_DAT_SNR_39;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 100;
				if 1 <= ID <= 5 then X_1 = 55;
					else if 6 <= ID <= 10 then X_1 = 65;
					else if 11 <= ID <= 20 then X_1 = 75;
					else if 21 <= ID <= 35 then X_1 = 85;
					else if 36 <= ID <= 55 then X_1 = 95;
					else if 56 <= ID <= 70 then X_1 = 105;
					else if 71 <= ID <= 85 then X_1 = 115;
					else if 86 <= ID <= 90 then X_1 = 125;
					else if 91 <= ID <= 95 then X_1 = 135;
					else if 96 <= ID <= 100 then X_1 = 145;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.05;
				P_0 = 0.45;
				GAM = rand ('normal', 0, 0.5); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 0.5); /* Standard deviation */ 
						X_2 = J*(((DLT+P_0)/(K*(1-(DLT+P_0))))+(DLT+P_0)*Q_1*X_1) + (1-J)*((P_0/(K*(1-P_0)))+P_0*Q_0*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 40 */
data ADS.SIM_DAT_SNR_40;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 100;
				if 1 <= ID <= 5 then X_1 = 55;
					else if 6 <= ID <= 10 then X_1 = 65;
					else if 11 <= ID <= 20 then X_1 = 75;
					else if 21 <= ID <= 35 then X_1 = 85;
					else if 36 <= ID <= 55 then X_1 = 95;
					else if 56 <= ID <= 70 then X_1 = 105;
					else if 71 <= ID <= 85 then X_1 = 115;
					else if 86 <= ID <= 90 then X_1 = 125;
					else if 91 <= ID <= 95 then X_1 = 135;
					else if 96 <= ID <= 100 then X_1 = 145;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.00;
				P_0 = 0.50;
				GAM = rand ('normal', 0, 2.5); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 2.5); /* Standard deviation */ 
						X_2 = J*(((DLT+P_0)/(K*(1-(DLT+P_0))))+(DLT+P_0)*Q_1*X_1) + (1-J)*((P_0/(K*(1-P_0)))+P_0*Q_0*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 41 */
data ADS.SIM_DAT_SNR_41;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 100;
				if 1 <= ID <= 5 then X_1 = 55;
					else if 6 <= ID <= 10 then X_1 = 65;
					else if 11 <= ID <= 20 then X_1 = 75;
					else if 21 <= ID <= 35 then X_1 = 85;
					else if 36 <= ID <= 55 then X_1 = 95;
					else if 56 <= ID <= 70 then X_1 = 105;
					else if 71 <= ID <= 85 then X_1 = 115;
					else if 86 <= ID <= 90 then X_1 = 125;
					else if 91 <= ID <= 95 then X_1 = 135;
					else if 96 <= ID <= 100 then X_1 = 145;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.01;
				P_0 = 0.49;
				GAM = rand ('normal', 0, 2.5); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 2.5); /* Standard deviation */ 
						X_2 = J*(((DLT+P_0)/(K*(1-(DLT+P_0))))+(DLT+P_0)*Q_1*X_1) + (1-J)*((P_0/(K*(1-P_0)))+P_0*Q_0*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 42 */
data ADS.SIM_DAT_SNR_42;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 100;
				if 1 <= ID <= 5 then X_1 = 55;
					else if 6 <= ID <= 10 then X_1 = 65;
					else if 11 <= ID <= 20 then X_1 = 75;
					else if 21 <= ID <= 35 then X_1 = 85;
					else if 36 <= ID <= 55 then X_1 = 95;
					else if 56 <= ID <= 70 then X_1 = 105;
					else if 71 <= ID <= 85 then X_1 = 115;
					else if 86 <= ID <= 90 then X_1 = 125;
					else if 91 <= ID <= 95 then X_1 = 135;
					else if 96 <= ID <= 100 then X_1 = 145;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.05;
				P_0 = 0.45;
				GAM = rand ('normal', 0, 2.5); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 2.5); /* Standard deviation */ 
						X_2 = J*(((DLT+P_0)/(K*(1-(DLT+P_0))))+(DLT+P_0)*Q_1*X_1) + (1-J)*((P_0/(K*(1-P_0)))+P_0*Q_0*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 43 */
data ADS.SIM_DAT_SNR_43;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 100;
				if 1 <= ID <= 5 then X_1 = 55;
					else if 6 <= ID <= 10 then X_1 = 65;
					else if 11 <= ID <= 20 then X_1 = 75;
					else if 21 <= ID <= 35 then X_1 = 85;
					else if 36 <= ID <= 55 then X_1 = 95;
					else if 56 <= ID <= 70 then X_1 = 105;
					else if 71 <= ID <= 85 then X_1 = 115;
					else if 86 <= ID <= 90 then X_1 = 125;
					else if 91 <= ID <= 95 then X_1 = 135;
					else if 96 <= ID <= 100 then X_1 = 145;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.00;
				P_0 = 0.50;
				GAM = rand ('normal', 0, 2); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 2); /* Standard deviation */ 
						X_2 = J*((1/(K*(DLT+P_0-1)))+(Q_1/(DLT+P_0))*X_1) + (1-J)*((1/(K*(P_0-1)))+(Q_0/P_0)*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 44 */
data ADS.SIM_DAT_SNR_44;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 100;
				if 1 <= ID <= 5 then X_1 = 55;
					else if 6 <= ID <= 10 then X_1 = 65;
					else if 11 <= ID <= 20 then X_1 = 75;
					else if 21 <= ID <= 35 then X_1 = 85;
					else if 36 <= ID <= 55 then X_1 = 95;
					else if 56 <= ID <= 70 then X_1 = 105;
					else if 71 <= ID <= 85 then X_1 = 115;
					else if 86 <= ID <= 90 then X_1 = 125;
					else if 91 <= ID <= 95 then X_1 = 135;
					else if 96 <= ID <= 100 then X_1 = 145;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.01;
				P_0 = 0.49;
				GAM = rand ('normal', 0, 2); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 2); /* Standard deviation */ 
						X_2 = J*((1/(K*(DLT+P_0-1)))+(Q_1/(DLT+P_0))*X_1) + (1-J)*((1/(K*(P_0-1)))+(Q_0/P_0)*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 45 */
data ADS.SIM_DAT_SNR_45;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 100;
				if 1 <= ID <= 5 then X_1 = 55;
					else if 6 <= ID <= 10 then X_1 = 65;
					else if 11 <= ID <= 20 then X_1 = 75;
					else if 21 <= ID <= 35 then X_1 = 85;
					else if 36 <= ID <= 55 then X_1 = 95;
					else if 56 <= ID <= 70 then X_1 = 105;
					else if 71 <= ID <= 85 then X_1 = 115;
					else if 86 <= ID <= 90 then X_1 = 125;
					else if 91 <= ID <= 95 then X_1 = 135;
					else if 96 <= ID <= 100 then X_1 = 145;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.05;
				P_0 = 0.45;
				GAM = rand ('normal', 0, 2); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 2); /* Standard deviation */ 
						X_2 = J*((1/(K*(DLT+P_0-1)))+(Q_1/(DLT+P_0))*X_1) + (1-J)*((1/(K*(P_0-1)))+(Q_0/P_0)*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 46 */
data ADS.SIM_DAT_SNR_46;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 100;
				if 1 <= ID <= 5 then X_1 = 55;
					else if 6 <= ID <= 10 then X_1 = 65;
					else if 11 <= ID <= 20 then X_1 = 75;
					else if 21 <= ID <= 35 then X_1 = 85;
					else if 36 <= ID <= 55 then X_1 = 95;
					else if 56 <= ID <= 70 then X_1 = 105;
					else if 71 <= ID <= 85 then X_1 = 115;
					else if 86 <= ID <= 90 then X_1 = 125;
					else if 91 <= ID <= 95 then X_1 = 135;
					else if 96 <= ID <= 100 then X_1 = 145;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.00;
				P_0 = 0.50;
				GAM = rand ('normal', 0, 10); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 10); /* Standard deviation */ 
						X_2 = J*((1/(K*(DLT+P_0-1)))+(Q_1/(DLT+P_0))*X_1) + (1-J)*((1/(K*(P_0-1)))+(Q_0/P_0)*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 47 */
data ADS.SIM_DAT_SNR_47;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 100;
				if 1 <= ID <= 5 then X_1 = 55;
					else if 6 <= ID <= 10 then X_1 = 65;
					else if 11 <= ID <= 20 then X_1 = 75;
					else if 21 <= ID <= 35 then X_1 = 85;
					else if 36 <= ID <= 55 then X_1 = 95;
					else if 56 <= ID <= 70 then X_1 = 105;
					else if 71 <= ID <= 85 then X_1 = 115;
					else if 86 <= ID <= 90 then X_1 = 125;
					else if 91 <= ID <= 95 then X_1 = 135;
					else if 96 <= ID <= 100 then X_1 = 145;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.01;
				P_0 = 0.49;
				GAM = rand ('normal', 0, 10); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 10); /* Standard deviation */ 
						X_2 = J*((1/(K*(DLT+P_0-1)))+(Q_1/(DLT+P_0))*X_1) + (1-J)*((1/(K*(P_0-1)))+(Q_0/P_0)*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;
/* Scenario 48 */
data ADS.SIM_DAT_SNR_48;
	call streaminit (250219);
		do F = 1 to 1000;
			do ID = 1 to 100;
				if 1 <= ID <= 5 then X_1 = 55;
					else if 6 <= ID <= 10 then X_1 = 65;
					else if 11 <= ID <= 20 then X_1 = 75;
					else if 21 <= ID <= 35 then X_1 = 85;
					else if 36 <= ID <= 55 then X_1 = 95;
					else if 56 <= ID <= 70 then X_1 = 105;
					else if 71 <= ID <= 85 then X_1 = 115;
					else if 86 <= ID <= 90 then X_1 = 125;
					else if 91 <= ID <= 95 then X_1 = 135;
					else if 96 <= ID <= 100 then X_1 = 145;
				K = 1.0;
				Q_1 = 0.5;
				Q_0 = 0.5;
				DLT = 0.05;
				P_0 = 0.45;
				GAM = rand ('normal', 0, 10); /* Standard deviation */
					do J = 0 to 1;
						EPS = rand ('normal', 0, 10); /* Standard deviation */ 
						X_2 = J*((1/(K*(DLT+P_0-1)))+(Q_1/(DLT+P_0))*X_1) + (1-J)*((1/(K*(P_0-1)))+(Q_0/P_0)*X_1) + GAM + EPS;
						output;
					end; 
			end;
		end;
run;



















