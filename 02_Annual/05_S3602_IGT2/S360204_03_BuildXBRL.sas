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
	/* BUILD View of S.36.02 - Part A */
	/* ------------------------------------------------------------*/
	
	CREATE TABLE WORK.ARG_S360204_PARTA_VW AS 
	
		SELECT 
	
			TM_C0010.ID AS C0010 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, TM2_C0080.ID AS C0080 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, TM1_C0030.ID AS C0030 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, TM3_C0060.ID AS C0060 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, C0020_TBL.si1380 AS C0020 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, C0050_TBL.si1381 AS C0050 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, C0100_TBL.ei1888 AS C0100_XBRL INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, ASST.EIOPA_CD AS C0100 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, C0110_TBL.di1048 AS C0110 FORMAT=YYMMDD10. INFORMAT=YYMMDD10. LABEL = ''
			, C0120_TBL.di1041 AS C0120 FORMAT=YYMMDD10. INFORMAT=YYMMDD10. LABEL = ''
			
			, C0130_TBL.ei1024 AS C0130_XBRL INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, CASE 
				WHEN TRIM(C0130_TBL.ei1024) = '' THEN '' 
				ELSE SUBSTR(C0130_TBL.ei1024,LENGTH(C0130_TBL.ei1024)-2) 	
			  END AS C0130 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			  
			 , C0140_TBL.mi1111 AS C0140 FORMAT=12.2 INFORMAT=12.2 LABEL=''
			 , C0150_TBL.mi1113 AS C0150 FORMAT=12.2 INFORMAT=12.2 LABEL=''
			 
			 , C0170_TBL.ei1811 AS C0170_XBRL INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			 , DRVTS.EIOPA_CD AS C0170 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''  
			 
			 , C0180_TBL.si1332 AS C0180 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			/********************new columns *********************************************/
			,  '' AS C0160 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			,  '' AS C0200 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			,  '' AS C0210 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			,  '' AS C0220 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			,  '' AS C0230 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			,  '' AS C0240 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
	FROM 
		WORK.PART_A PA 

 		INNER JOIN XBRL.scenario SC  
 			ON SC.scenario_ORDINAL=PA.scenario_ORDINAL  
						
		INNER JOIN XBRL.context CON 
			ON CON.context_ORDINAL=SC.context_ORDINAL

		/* 		C0010 - GX - ID of intragroup transaction				*/
		INNER JOIN XBRL.typedMember TM_C0010
			ON PA.scenario_ORDINAL = TM_C0010.scenario_ORDINAL
			AND TM_C0010.typedMember_dimension = 's2c_dim:GX'	
									
		/* 		C0030 - IX - Identification code of investor / buyer	*/									
		INNER JOIN XBRL.typedMember TM1_C0030
			ON PA.scenario_ORDINAL = TM1_C0030.scenario_ORDINAL
			AND TM1_C0030.typedMember_dimension = 's2c_dim:IX'	

		/* 		C0080 - UI - ID code of the instrument*					*/	
		INNER JOIN XBRL.typedMember TM2_C0080
			ON PA.scenario_ORDINAL = TM2_C0080.scenario_ORDINAL
			AND TM2_C0080.typedMember_dimension = 's2c_dim:UI'			
			
		/*		C0060 - ZS - Identification code of the issuer / seller*/	
		INNER JOIN XBRL.typedMember TM3_C0060
			ON PA.scenario_ORDINAL = TM3_C0060.scenario_ORDINAL
			AND TM3_C0060.typedMember_dimension = 's2c_dim:ZS'	
	
		/************************METRICS table joins***************************/		
		LEFT JOIN XBRL.si1380 C0020_TBL
			ON C0020_TBL.si1380_contextRef=CON.context_id

		LEFT JOIN XBRL.si1381 C0050_TBL
			ON C0050_TBL.si1381_contextRef=CON.context_id	

		LEFT JOIN XBRL.ei1888 C0100_TBL
			ON C0100_TBL.ei1888_contextRef=CON.context_id		
			
		LEFT JOIN XBRL.di1048 C0110_TBL
			ON C0110_TBL.di1048_contextRef=CON.context_id	
			
		LEFT JOIN XBRL.di1041 C0120_TBL
			ON C0120_TBL.di1041_contextRef=CON.context_id	
			
		LEFT JOIN XBRL.ei1024 C0130_TBL
			ON C0130_TBL.ei1024_contextRef=CON.context_id	
			
		LEFT JOIN XBRL.mi1111 C0140_TBL
			ON C0140_TBL.mi1111_contextRef=CON.context_id			
			
		LEFT JOIN XBRL.mi1113 C0150_TBL
			ON C0150_TBL.mi1113_contextRef=CON.context_id	
			
		LEFT JOIN XBRL.ei1811 C0170_TBL
			ON C0170_TBL.ei1811_contextRef=CON.context_id

		LEFT JOIN XBRL.si1332 C0180_TBL
			ON C0180_TBL.si1332_contextRef=CON.context_id			
	
		/************************eiopa table joins***************************/
		LEFT JOIN X_EIOPA_CD ASST
			ON 
			TRIM(C0100_TBL.ei1888) = TRIM(ASST.XBRL_CD)
			AND ASST.EFFECTIVE_TO_DATE = '31/12/9999  23:59:59'
			AND ASST.EIOPA_CATEGORY = 'IGT_TRANS_TYPE_DRVTS'
			
		LEFT JOIN X_EIOPA_CD DRVTS
			ON 
			TRIM(C0170_TBL.ei1811) = TRIM(DRVTS.XBRL_CD)
			AND DRVTS.EFFECTIVE_TO_DATE = '31/12/9999  23:59:59' 			
	;
	

	DROP TABLE 
		WORK.PART_A
	;

QUIT;
