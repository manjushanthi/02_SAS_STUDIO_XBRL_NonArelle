%LET EIOPAFilePath = '/home/dlg0mxb/XBRL_Reconcilliations/00_Files/DC181_EIOPA_STD_CODE- Oct - Tax 2.6 - V7.xls';
%LET XBRLFilePath = '/home/dlg0mxb/XBRL_Reconcilliations/00_Files/UKI_S110101_(AssetsHeldAsCollateral)_Solo_V260-Annual_2021-R-03022022.xbrl' ;
%LET SDWFilePath = '/home/dlg0mxb/XBRL_Reconcilliations/00_Files/S110101_(AssetsHeldAsCollateral)_Solo.xlsx';

/* --------------------------------------------------------------------------*/
/* 							Import EIOPA_CODE file 							*/
/* ----------------------------------------------------------------------- */

/* Import EIOPA_CODE file */
PROC IMPORT DATAFILE="&EIOPAFilePath"
			OUT=WORK.X_EIOPA_CD
			DBMS=XLS REPLACE;
			OPTIONS	MISSING='';
			SHEET='EIOPA_CODE';
			GETNAMES=YES;
RUN;

/* Import XBRL Into XBRL libref */
filename XML_MAP temp;
libname XBRL xmlv2  "&XBRLFilePath"
		automap=replace xmlmap=XML_MAP ;

/* Import Invoke Input Extracts - Part 1 Extract the CONTEXT */
PROC IMPORT DATAFILE="&SDWFilePath"
			OUT=WORK.SDW_CONTEXT(RENAME=(B=F1 C=F2))
			DBMS=XLSX REPLACE;
			OPTIONS	MISSING='';
			RANGE = 'SDW_CONTEXT' ;
			GETNAMES=NO;
RUN;

/* Import Invoke Input Extracts - Part 2 Extract Part A */
PROC IMPORT DATAFILE="&SDWFilePath"
			OUT=WORK.SDW_S110101_PART_A
			DBMS=XLSX REPLACE;
			OPTIONS	MISSING='';
			RANGE = 'SDW_PART_A' ;
			GETNAMES=YES;
RUN;


/* Import Invoke Input Extracts - Part 2 Extract Part A */
PROC IMPORT DATAFILE="&SDWFilePath"
			OUT=WORK.SDW_S110101_PART_B
			DBMS=XLSX REPLACE;
			OPTIONS	MISSING='';
			RANGE = 'SDW_PART_B' ;
			GETNAMES=YES;
RUN;