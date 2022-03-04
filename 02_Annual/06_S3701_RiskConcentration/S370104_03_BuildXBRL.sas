PROC SQL;

	/* ------------------------------------------------------------*/
	/* Get all the distinct Scenario Ordinals to avoid Cartesians */
	/* ------------------------------------------------------------*/
	create table WORK.PART_A as 
		select DISTINCT scenario_ORDINAL from 
		(SELECT 
			*
		 FROM
			XBRL.typedMember)
	;
	
	/* ------------------------------------------------------------*/
	/* BUILD View of S.37 - Part A */
	/* ------------------------------------------------------------*/
	CREATE TABLE WORK.ARG_S370104_PARTA_VW AS 
	
		SELECT 
	
			 TM3_C0020.ID AS C0020 INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''
		
			, TM2_C0120.ID AS C0120 INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''
			
			, TM1_C0060.ID AS C0060 INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''
			
			, C0010_TBL.si1386 AS C0010 INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''
			
			, C0040_TBL.ei2345 AS C0040_XBRL INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''
			, CASE 
				WHEN C0040_TBL.ei2345 = '' THEN ''
				WHEN SUBSTR(TRIM(C0040_TBL.ei2345),INDEX(TRIM(C0040_TBL.ei2345),':')+1,LENGTH(TRIM(C0040_TBL.ei2345))) = 'x115' THEN 'GBXT' 
				ELSE SUBSTR(TRIM(C0040_TBL.ei2345),INDEX(TRIM(C0040_TBL.ei2345),':')+1,LENGTH(TRIM(C0040_TBL.ei2345)))
			  END AS C0040 INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''
			
			, C0050_TBL.ei1892 AS C0050_XBRL INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''
			, EXPO.EIOPA_CD AS C0050 INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''
			
			, C0080_TBL.si1555 AS C0080 INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''
			
			, C0090_TBL.ei2521 AS C0090_XBRL INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''
			, CASE 
				WHEN C0090_TBL.ei2521 = 's2c_SE:x179' THEN 'S&P Global Ratings Europe Limited (LEI code:5493008B2TU3S6QE1E12)'
				WHEN C0090_TBL.ei2521 = 's2c_SE:x147' THEN 'Fitch Ratings Limited (LEI code: 2138009F8YAHVC8W3Q52)'
				WHEN C0090_TBL.ei2521 = 's2c_SE:x154' THEN 'Moody¡¦s Investors Service Ltd (LEI code: 549300SM89WABHDNJ349)'
				ELSE ECAI.EIOPA_DESCRIPTION  
			   END AS C0090 INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''
			
			, C0091_TBL.si1782 AS C0091 INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''
			
			, C0100_TBL.ei1658 AS C0100_XBRL INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''	 		
			, CASE 
				WHEN C0100_TBL.ei1658 = '' THEN '' 
				WHEN C0100_TBL.ei1658 = 's2c_NC:x0' THEN C0100_TBL.ei1658
				ELSE SUBSTR(C0100_TBL.ei1658,LENGTH(C0100_TBL.ei1658)-4) 	
			  END AS C0100 INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''
			  
			 , C0110_TBL.si1387 AS C0110 INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''
			 
			 , PUT(C0140_TBL.di1041,YYMMDD10.) AS C0140
			 
			 , ROUND(C0150_TBL.mi1141,0.01) AS C0150 FORMAT=12.2
			 
			 , C0160_TBL.ei1024 AS C0160_XBRL INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = '' 			 
			 , CASE 
				WHEN TRIM(C0160_TBL.ei1024) = '' THEN '' 
				ELSE SUBSTR(C0160_TBL.ei1024,LENGTH(C0160_TBL.ei1024)-2) 	
			   END AS C0160 INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''
			   
			 , 0.00 AS C0170  FORMAT=COMMA15.2  LABEL =''
			
	FROM 
		WORK.PART_A PA 

 		INNER JOIN XBRL.scenario SC  
 			ON SC.scenario_ORDINAL=PA.scenario_ORDINAL  
						
		INNER JOIN XBRL.context CON 
			ON CON.context_ORDINAL=SC.context_ORDINAL 		
			
		INNER JOIN XBRL.typedMember TM3_C0020
			ON PA.scenario_ORDINAL = TM3_C0020.scenario_ORDINAL
			AND TM3_C0020.typedMember_dimension = 's2c_dim:GO'	
			
		INNER JOIN XBRL.typedMember TM2_C0120
			ON PA.scenario_ORDINAL = TM2_C0120.scenario_ORDINAL
			AND TM2_C0120.typedMember_dimension = 's2c_dim:CE'			
			
		INNER JOIN XBRL.typedMember TM1_C0060
			ON PA.scenario_ORDINAL = TM1_C0060.scenario_ORDINAL
			AND TM1_C0060.typedMember_dimension = 's2c_dim:UI'
			
		LEFT JOIN XBRL.si1386 C0010_TBL
			ON C0010_TBL.si1386_contextRef=CON.context_id

		LEFT JOIN XBRL.ei2345 C0040_TBL
			ON C0040_TBL.ei2345_contextRef=CON.context_id
			
		LEFT JOIN XBRL.ei1892 C0050_TBL
			ON C0050_TBL.ei1892_contextRef=CON.context_id	
			
		LEFT JOIN XBRL.si1555 C0080_TBL
			ON C0080_TBL.si1555_contextRef=CON.context_id	
		
		LEFT JOIN XBRL.ei2521 C0090_TBL
			ON C0090_TBL.ei2521_contextRef=CON.context_id	
			
		LEFT JOIN XBRL.si1782 C0091_TBL
			ON C0091_TBL.si1782_contextRef=CON.context_id	
			
		LEFT JOIN XBRL.ei1658 C0100_TBL
			ON C0100_TBL.ei1658_contextRef=CON.context_id		
			
		LEFT JOIN XBRL.si1387 C0110_TBL
			ON C0110_TBL.si1387_contextRef=CON.context_id	
			
		LEFT JOIN XBRL.di1041 C0140_TBL
			ON C0140_TBL.di1041_contextRef=CON.context_id		

		LEFT JOIN XBRL.mi1141 C0150_TBL
			ON C0150_TBL.mi1141_contextRef=CON.context_id	

		LEFT JOIN XBRL.ei1024 C0160_TBL
			ON C0160_TBL.ei1024_contextRef=CON.context_id					
		
		/************************eiopa table joins***************************/
		
		LEFT JOIN X_EIOPA_CD EXPO
		ON 
			TRIM(C0050_TBL.ei1892) = TRIM(EXPO.XBRL_CD)
			AND EXPO.EFFECTIVE_TO_DATE = '31/12/9999  23:59:59'

		LEFT JOIN X_EIOPA_CD ECAI
		ON 
			C0090_TBL.ei2521 = ECAI.XBRL_CD
			AND ECAI.EFFECTIVE_TO_DATE = '31/12/9999  23:59:59'
			AND ECAI.EIOPA_CATEGORY = 'ECAI'
			AND ECAI.EIOPA_SHORT_DESC LIKE '%HIG%'
	;

	/* ------------------------------------------------------------*/
	/* Delete Temporary Part_A table */
	/* ------------------------------------------------------------*/		
	DROP TABLE 
		WORK.PART_A;
QUIT;