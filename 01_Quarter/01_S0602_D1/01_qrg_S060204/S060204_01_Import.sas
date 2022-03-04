%LET InputFileFolder = /home/dlg0mxb/XBRL_Reconcilliations/00_Files;

%LET EIOPAFilePath = &InputFileFolder/DC181_EIOPA_STD_CODE- Oct - Tax 2.6 - V7.xls;
%LET XBRLFilePath = &InputFileFolder/DLG_S060204_(ListOfAssets)_Group_V260-Q4_2021-R-28012022.xbrl;
%LET SDWFilePath = &InputFileFolder/S060204_(ListOfAssets)_Group.xlsx;

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

/* --------------------------------------------------------------------------*/
/* 							Import XBRL File       							*/
/*                    Import XBRL Into XBRL libref                         */
/* -----------------------------------------------------------------------*/

/* Import XBRL Into XBRL libref */
filename XML_MAP temp;
libname XBRL xmlv2 "&XBRLFilePath" 
		automap=replace xmlmap=XML_MAP ;

/* --------------------------------------------------------------------------*/
/* 							Import SDW Invoke File       					*/
/* ------------------------------------------------------------------------*/

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
			OUT=WORK.SDW_S060204_PART_A
			DBMS=XLSX REPLACE;
			OPTIONS	MISSING='';
			RANGE = 'SDW_PART_A' ;
			GETNAMES=YES;
RUN;

/* Import Invoke Input Extracts - Part 3 Extract Part B */
PROC IMPORT DATAFILE="&SDWFilePath"
			OUT=WORK.SDW_S060204_PART_B
			DBMS=XLSX REPLACE;
			OPTIONS	MISSING='';
			RANGE = 'SDW_PART_B' ;
			GETNAMES=YES;
		
RUN;