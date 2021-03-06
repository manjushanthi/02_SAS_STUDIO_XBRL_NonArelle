/*PartA eligible ID's*/
PROC SQL;
create table WORK.PART_A as 
	select scenario_ORDINAL from 
	(SELECT 
	* FROM
	XBRL.typedMember)
	group by scenario_ORDINAL
	/* 	A Part Records having 2 records */
	having count(*)>1;
QUIT;

/*PartB eligible ID's*/
PROC SQL;
create table WORK.PART_B as 
	select scenario_ORDINAL from 
	(SELECT 
	* FROM
	XBRL.typedMember)
	group by scenario_ORDINAL
	/* 	B Part Records having 1 record */
	having count(*)=1;
QUIT;

PROC SQL;
	CREATE TABLE WORK.S110104_XBRL_PartA AS 
	
		SELECT 
			TM.scenario_ORDINAL
			, SC.context_ORDINAL
			, CON.context_id
		
			, TM1.ID AS C0020 INFORMAT=$24. FORMAT=$24. LENGTH=24 LABEL = 's2c_dim:CE'
			
			, TM.ID AS C0040 INFORMAT=$24. FORMAT=$24. LENGTH=24 LABEL = 's2c_dim:UI'
			
			, C0010_TBL.si1376 AS C0010 INFORMAT=$21. FORMAT=$21. LENGTH=21 LABEL = 'C0010'
			
			, C0060_TBL.si1576 AS C0060 INFORMAT=$38. FORMAT=$38. LENGTH=38 LABEL = 'C0060'
			
			, C0070_TBL.si1589 AS C0070  INFORMAT=$32. FORMAT=$32. LENGTH=32 LABEL = 'C0070'
			
			, C0080_TBL.ei1507 AS C0080_XBRL INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = 'C0080_XBRL'
			, SUBSTR(TRIM(C0080_TBL.ei1507),INDEX(TRIM(C0080_TBL.ei1507),':')+1,LENGTH(TRIM(C0080_TBL.ei1507))) AS C0080 
			  LENGTH=88  FORMAT=$88.  INFORMAT=$88. LABEL='C0080'
			
			, '' AS C0090 INFORMAT=$1. FORMAT=$1. LENGTH=1 LABEL = 'C0090'
			
			, C0100_TBL.mi2376 AS C0100 INFORMAT=12.2 FORMAT=12.2 LABEL = 'C0100'
			
			, C0110_TBL.ei2218 AS C0110_XBRL  INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = 'C0110_XBRL'
			,  VALU.EIOPA_CD AS C0110 LENGTH=14 FORMAT=$14. INFORMAT=$14. LABEL='C0110'
			
			, C0120_TBL.mi1132 AS C0120 INFORMAT=12.2 FORMAT=12.2 LABEL = 'C0120'
			
			, C0130_TBL.mi1129 AS C0130 INFORMAT=12.2 FORMAT=12.2 LABEL = 'C0130'
			
			, C0140_TBL.ei1834 AS C0140_XBRL  INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = 'C0140_XBRL'
			, ASST.EIOPA_CD AS C0140  LENGTH=14 FORMAT=$14. INFORMAT=$14. LABEL='C0140'

 
		FROM 
			XBRL.typedMember TM 
			
		LEFT JOIN XBRL.typedMember TM1 
			ON TM1.scenario_ORDINAL = TM.scenario_ORDINAL
			AND TM1.typedMember_dimension='s2c_dim:CE' 
			
		INNER JOIN PART_A PA
			ON PA.scenario_ORDINAL=TM.scenario_ORDINAL
				
 		INNER JOIN XBRL.scenario SC  
 			ON SC.scenario_ORDINAL=TM.scenario_ORDINAL  
						
		INNER JOIN XBRL.context CON 
			ON CON.context_ORDINAL=SC.context_ORDINAL 

		LEFT JOIN XBRL.si1376 C0010_TBL 
			ON C0010_TBL.si1376_contextRef=CON.context_id 
				
		LEFT JOIN XBRL.si1576 C0060_TBL 
			ON C0060_TBL.si1576_contextRef=CON.context_id 
		
		LEFT JOIN XBRL.si1589 C0070_TBL 
			ON C0070_TBL.si1589_contextRef=CON.context_id 
		
		LEFT JOIN XBRL.ei1507 C0080_TBL 
			ON C0080_TBL.ei1507_contextRef=CON.context_id 
		
		LEFT JOIN XBRL.mi2376 C0100_TBL
			ON C0100_TBL.mi2376_contextRef=CON.context_id 

		LEFT JOIN XBRL.ei2218 C0110_TBL
			ON C0110_TBL.ei2218_contextRef=CON.context_id 	

		LEFT JOIN XBRL.mi1132 C0120_TBL 
			ON C0120_TBL.mi1132_contextRef=CON.context_id 			
			
		LEFT JOIN XBRL.mi1129 C0130_TBL 
			ON C0130_TBL.mi1129_contextRef=CON.context_id 				
		
		LEFT JOIN XBRL.ei1834 C0140_TBL 
			ON C0140_TBL.ei1834_contextRef=CON.context_id 	
	
		/* -------------------------------------------*/
		
		LEFT JOIN 
			X_EIOPA_CD VALU
			ON C0110_TBL.ei2218 = SUBSTR(TRIM(VALU.XBRL_CD),1,INDEX(TRIM(VALU.XBRL_CD),'/')-1)
			AND VALU.EFFECTIVE_TO_DATE = '31/12/9999  23:59:59'

		LEFT JOIN 
			X_EIOPA_CD ASST
			ON C0140_TBL.ei1834 = ASST.XBRL_CD
			AND ASST.EFFECTIVE_TO_DATE = '31/12/9999  23:59:59'
				
		WHERE 
			TM.typedMember_dimension <> 's2c_dim:XG' 
			AND TM.typedMember_dimension <> 's2c_dim:CE' 
		
		ORDER BY 
			TM.ID;
QUIT;

DATA WORK.ARG_S110104_PARTA_VW ;
	DROP  context_id context_ORDINAL scenario_ORDINAL;
	SET WORK.S110104_XBRL_PartA;
RUN;	

PROC SQL;
	CREATE TABLE WORK.S110104_XBRL_PartB AS 
	
		SELECT 
			TM.scenario_ORDINAL
			, SC.context_ORDINAL
			, CON.context_id
			
			, TM.ID AS C0040 INFORMAT=$24. FORMAT=$24. LENGTH=24 LABEL = 's2c_dim:UI'
			
			, C0150_TBL.si1338 AS C0150 INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = 'C0150'
			
			, C0160_TBL.si1381 AS C0160 INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = 'C0160'
			
			, C0170_TBL.si1552 AS C0170 INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = 'C0170'
			
			, C0190_TBL.ei1658 AS C0190_XBRL  INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = 'C0190_XBRL'
			, CASE 
					WHEN C0190_TBL.ei1658 = '' THEN '' 
					WHEN C0190_TBL.ei1658 = 's2c_NC:x0' THEN C0190_TBL.ei1658
				ELSE SUBSTR(C0190_TBL.ei1658,LENGTH(C0190_TBL.ei1658)-4) 	
	  		   END AS C0190 INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = 'C0190'
			
			, C0200_TBL.si1337 AS C0200 INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = 'C0200'
			
			, C0210_TBL.si1553 AS C0210	 INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = 'C0210'
			
			, C0230_TBL.ei1508 AS C0230_XBRL INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = 'C0230_XBRL'
			, SUBSTR(TRIM(C0230_TBL.ei1508),INDEX(TRIM(C0230_TBL.ei1508),':')+1,LENGTH(TRIM(C0230_TBL.ei1508))) AS C0230
				INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = 'C0230'
				
			, C0240_TBL.ei1024 AS C0240_XBRL  INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = 'C0240_XBRL'
			, CASE 
				WHEN TRIM(C0240_TBL.ei1024) = '' THEN '' 
				ELSE SUBSTR(C0240_TBL.ei1024,LENGTH(C0240_TBL.ei1024)-2) 	
	  		  END AS C0240  INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = 'C0240'
			
			, C0250_TBL.si1554 AS C0250 INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = 'C0250'
			
			, '' AS C0260
			
			, C0270_TBL.pi1286 AS C0270 FORMAT = 12.4 INFORMAT=COMMA12. 
			
			, PUT(C0280_TBL.di1041,YYMMDD10.)  AS C0280  INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = 'C0280'
			
		FROM 
			XBRL.typedMember TM 
						
		INNER JOIN PART_B PB
			ON PB.scenario_ORDINAL=TM.scenario_ORDINAL
			
 		INNER JOIN XBRL.scenario SC  
 			ON SC.scenario_ORDINAL=TM.scenario_ORDINAL  
						
		INNER JOIN XBRL.context CON 
			ON CON.context_ORDINAL=SC.context_ORDINAL 
				
		LEFT JOIN XBRL.si1338 C0150_TBL 
			ON C0150_TBL.si1338_contextRef=CON.context_id 
		
		LEFT JOIN XBRL.si1381 C0160_TBL 
			ON C0160_TBL.si1381_contextRef=CON.context_id 
		
		LEFT JOIN XBRL.si1552 C0170_TBL 
			ON C0170_TBL.si1552_contextRef=CON.context_id 
		
		LEFT JOIN XBRL.ei1658 C0190_TBL
			ON C0190_TBL.ei1658_contextRef=CON.context_id 

		LEFT JOIN XBRL.si1337 C0200_TBL
			ON C0200_TBL.si1337_contextRef=CON.context_id 	

		LEFT JOIN XBRL.si1553 C0210_TBL 
			ON C0210_TBL.si1553_contextRef=CON.context_id 			
			
		LEFT JOIN XBRL.ei1508 C0230_TBL 
			ON C0230_TBL.ei1508_contextRef=CON.context_id 				
		
		LEFT JOIN XBRL.ei1024 C0240_TBL 
			ON C0240_TBL.ei1024_contextRef=CON.context_id 	
		
		LEFT JOIN XBRL.si1554 C0250_TBL 
			ON C0250_TBL.si1554_contextRef=CON.context_id 	
			
		LEFT JOIN XBRL.pi1286 C0270_TBL 
			ON C0270_TBL.pi1286_contextRef=CON.context_id 		

		LEFT JOIN XBRL.di1041 C0280_TBL 
			ON C0280_TBL.di1041_contextRef=CON.context_id 			
					
		WHERE 
			TM.typedMember_dimension <> 's2c_dim:XG' 
		
		ORDER BY 
			TM.ID;
QUIT;

DATA WORK.ARG_S110104_PARTB_VW ;
	DROP  context_id context_ORDINAL scenario_ORDINAL;
	SET WORK.S110104_XBRL_PartB;
RUN;	

PROC DATASETS LIBRARY= WORK NOLIST;
	DELETE PART_A PART_B S110104_XBRL_PartA S110104_XBRL_PartB;
RUN;
	
	
