	/* ---------------------------------------------------------------*/
	/* Build Part A Eligible ID's ID's which have multiple attributes */
	/*					PartA eligible ID's							  */
	/* ---------------------------------------------------------------*/	
PROC SQL;

	CREATE TABLE WORK.PART_A as 
		select scenario_ORDINAL 
			from 
				(SELECT * FROM XBRL.typedMember)
			group by scenario_ORDINAL
			
			/* 	A Part Records having 2 records */
			having count(*)>1;

	/* -------------------------------------------------------------*/
	/* 					Build Part A View for S0802  				*/
	/* -------------------------------------------------------------*/	
	

	CREATE TABLE WORK.QRG_S080204_PARTA_VW AS 
	
		SELECT 

			 ID_C0020.ID AS C0020 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''

			, ID_C0040.ID AS C0040 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, ID_C0070.ID AS C0070 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, ID_C0090.ID AS C0090 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''

			, C0010_TBL.si1376 AS C0010 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, C0060_TBL.ei2426 AS C0060_XBRL INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, PORT.EIOPA_CD AS C0060 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, C0080_TBL.ei1070 AS C0080_XBRL INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, LINK.EIOPA_CD AS C0080 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, C0110_TBL.ei1811 AS C0110_XBRL INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, DVTS.EIOPA_CD AS C0110 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = '' 
		
			, C0120_TBL.mi1112 AS C0120 FORMAT = 12.2 INFORMAT=COMMA12.
			
			, '' AS C0130_XBRL  /*WILL NOT BE AVAILABLE IN THE XBRL CODE*/ INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, '' AS C0130       /*WILL NOT BE AVAILABLE IN THE XBRL CODE*/ INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = '' 
			
			, C0140_TBL.mi1812 AS C0140 FORMAT = 12.2
			, C0150_TBL.mi1813 AS C0150 FORMAT = 12.2
			
			, C0160_TBL.mi1990 AS C0160 FORMAT = 12.2
			
			, C0170_TBL.ii1067 AS C0170 FORMAT = 12.
			
			,'' AS C0180 /*WILL NOT BE AVAILABLE IN THE XBRL CODE*/  INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL=''
			,'' AS C0190 /*WILL NOT BE AVAILABLE IN THE XBRL CODE*/  INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL=''
			
			, C0200_TBL.mi1115 AS C0200 FORMAT = 12.2
			, C0210_TBL.mi1096 AS C0210 FORMAT = 12.2
			
			, PUT(C0220_TBL.di1047,YYMMDD10.) AS C0220  FORMAT=$CHAR10.
				
			, C0230_TBL.mi1127 AS C0230 FORMAT = 12.2
			
		FROM 
		WORK.PART_A PA 

 		INNER JOIN XBRL.scenario SC  
 			ON SC.scenario_ORDINAL=PA.scenario_ORDINAL  
						
		INNER JOIN XBRL.context CON 
			ON CON.context_ORDINAL=SC.context_ORDINAL 		

		/*****************C0020********************/			
		INNER JOIN XBRL.typedMember TM1_C0020
			ON PA.scenario_ORDINAL = TM1_C0020.scenario_ORDINAL
			AND TM1_C0020.typedMember_dimension = 's2c_dim:CE'	
			
		INNER JOIN XBRL.ID ID_C0020
			ON ID_C0020.typedMember_ORDINAL = TM1_C0020.typedMember_ORDINAL
		/*****************C0020********************/			
		
		/*****************C0040********************/
		INNER JOIN XBRL.typedMember TM2_C0040
			ON PA.scenario_ORDINAL = TM2_C0040.scenario_ORDINAL
			AND TM2_C0040.typedMember_dimension = 's2c_dim:UI'
			
		INNER JOIN XBRL.ID ID_C0040
			ON ID_C0040.typedMember_ORDINAL = TM2_C0040.typedMember_ORDINAL			
		/*****************C0040********************/			
		
		/*****************C0070********************/
		INNER JOIN XBRL.typedMember TM3_C0070
			ON PA.scenario_ORDINAL = TM3_C0070.scenario_ORDINAL
			AND TM3_C0070.typedMember_dimension = 's2c_dim:NF'
			
		INNER JOIN XBRL.ID ID_C0070
			ON ID_C0070.typedMember_ORDINAL = TM3_C0070.typedMember_ORDINAL				
		/*****************C0070********************/

		/*****************C0090********************/			
		INNER JOIN XBRL.typedMember TM4_C0090
			ON PA.scenario_ORDINAL = TM4_C0090.scenario_ORDINAL
			AND TM4_C0090.typedMember_dimension = 's2c_dim:IW'			
		
		INNER JOIN XBRL.ID ID_C0090
			ON ID_C0090.typedMember_ORDINAL = TM4_C0090.typedMember_ORDINAL	
		/*****************C0090********************/	

		/***************Join Metrics tables********************/
		
		LEFT JOIN XBRL.si1376 C0010_TBL
			ON C0010_TBL.si1376_contextRef=CON.context_id
			
		LEFT JOIN XBRL.ei2426 C0060_TBL
			ON C0060_TBL.ei2426_contextRef=CON.context_id	

		LEFT JOIN XBRL.ei1070 C0080_TBL
			ON C0080_TBL.ei1070_contextRef=CON.context_id	
			
		LEFT JOIN XBRL.ei1811 C0110_TBL
			ON C0110_TBL.ei1811_contextRef=CON.context_id	

		LEFT JOIN XBRL.mi1112 C0120_TBL
			ON C0120_TBL.mi1112_contextRef=CON.context_id		
			
		LEFT JOIN XBRL.mi1812 C0140_TBL
			ON C0140_TBL.mi1812_contextRef=CON.context_id	
			
		LEFT JOIN XBRL.mi1813 C0150_TBL
			ON C0150_TBL.mi1813_contextRef=CON.context_id

		LEFT JOIN XBRL.mi1990 C0160_TBL
			ON C0160_TBL.mi1990_contextRef=CON.context_id			
			
		LEFT JOIN XBRL.ii1067 C0170_TBL
			ON C0170_TBL.ii1067_contextRef=CON.context_id	

		LEFT JOIN XBRL.mi1115 C0200_TBL
			ON C0200_TBL.mi1115_contextRef=CON.context_id	
			
		LEFT JOIN XBRL.mi1096 C0210_TBL
			ON C0210_TBL.mi1096_contextRef=CON.context_id		
		
		LEFT JOIN XBRL.di1047 C0220_TBL
			ON C0220_TBL.di1047_contextRef=CON.context_id
			
		LEFT JOIN XBRL.mi1127 C0230_TBL
			ON C0230_TBL.mi1127_contextRef=CON.context_id				
			
		/***************EIOPA JOINS***************************/

		LEFT JOIN X_EIOPA_CD PORT
		ON 
			C0060_TBL.ei2426 = PORT.XBRL_CD
			AND PORT.EFFECTIVE_TO_DATE = '31/12/9999  23:59:59'
		
		LEFT JOIN X_EIOPA_CD LINK
		ON 
			C0080_TBL.ei1070 = LINK.XBRL_CD
			AND LINK.EFFECTIVE_TO_DATE = '31/12/9999  23:59:59'
		
		LEFT JOIN X_EIOPA_CD DVTS
		ON 
			C0110_TBL.ei1811 = DVTS.XBRL_CD
			AND DVTS.EFFECTIVE_TO_DATE = '31/12/9999  23:59:59'
							
		ORDER BY 
			ID_C0040.ID;
						
	/* ------------------------------------------------------------*/
	/* Delete Temporary Part_A table */
	/* ------------------------------------------------------------*/		
	DROP TABLE 
		WORK.PART_A;
QUIT;

/*********************************************************************************/
/**************************************Part B ***********************************/
/*********************************************************************************/

PROC SQL;

/*PartB eligible ID's*/
CREATE TABLE WORK.PART_B as 
	select scenario_ORDINAL from 
	(SELECT 
	* FROM
	XBRL.typedMember)
	group by scenario_ORDINAL
	/* 	B Part Records having 1 record */
	having count(*)=1;

CREATE TABLE WORK.QRG_S080204_PARTB_VW AS  
	
	SELECT 
	
			ID_C0040.ID AS C0040 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, C0240_TBL.si1378 AS C0240 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, C0250_TBL.si1558 AS C0250 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, C0270_TBL.si1336 AS C0270 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, C0280_TBL.si1559 AS C0280 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = '' 
			, C0300_TBL.si1341 AS C0300 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, C0310_TBL.ei1024 AS C0310_XBRL INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, CASE 
				WHEN TRIM(C0310_TBL.ei1024) = '' THEN '' 
				ELSE SUBSTR(C0310_TBL.ei1024,LENGTH(C0310_TBL.ei1024)-2) 	
			  END AS C0310 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			  
			, C0320_TBL.si1554 AS C0320 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, C0330_TBL.si1340 AS C0330 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, C0340_TBL.ei1814 AS C0340_XBRL INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, UNWI.EIOPA_CD AS C0340 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, '' AS C0350_XBRL  /* Not Available in source */ INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, '' AS C0350		/* Not Available in source */ INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, '' AS C0360_XBRL	/* Not Available in source */ INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, '' AS C0360		/* Not Available in source */ INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''	
			
			, PUT(C0370_TBL.di1041,YYMMDD10.) AS C0370  FORMAT=$10. 
			
			
		FROM 
		WORK.PART_B PB

 		INNER JOIN XBRL.scenario SC  
 			ON SC.scenario_ORDINAL=PB.scenario_ORDINAL  
						
		INNER JOIN XBRL.context CON 
			ON CON.context_ORDINAL=SC.context_ORDINAL 				
		
		/*****************C0040********************/
		INNER JOIN XBRL.typedMember TM2_C0040
			ON PB.scenario_ORDINAL = TM2_C0040.scenario_ORDINAL
			AND TM2_C0040.typedMember_dimension = 's2c_dim:UI'
			
		INNER JOIN XBRL.ID ID_C0040
			ON ID_C0040.typedMember_ORDINAL = TM2_C0040.typedMember_ORDINAL			
		/*****************C0040********************/			
		

		/***************Join Metrics tables********************/
		
		LEFT JOIN XBRL.si1378 C0240_TBL
			ON C0240_TBL.si1378_contextRef=CON.context_id
			
		LEFT JOIN XBRL.si1558 C0250_TBL
			ON C0250_TBL.si1558_contextRef=CON.context_id	

		LEFT JOIN XBRL.si1336 C0270_TBL
			ON C0270_TBL.si1336_contextRef=CON.context_id	
			
		LEFT JOIN XBRL.si1559 C0280_TBL
			ON C0280_TBL.si1559_contextRef=CON.context_id	

		LEFT JOIN XBRL.si1341 C0300_TBL
			ON C0300_TBL.si1341_contextRef=CON.context_id		
			
		LEFT JOIN XBRL.ei1024 C0310_TBL
			ON C0310_TBL.ei1024_contextRef=CON.context_id	
			
		LEFT JOIN XBRL.si1554 C0320_TBL
			ON C0320_TBL.si1554_contextRef=CON.context_id

		LEFT JOIN XBRL.si1340 C0330_TBL
			ON C0330_TBL.si1340_contextRef=CON.context_id			
			
		LEFT JOIN XBRL.ei1814 C0340_TBL
			ON C0340_TBL.ei1814_contextRef=CON.context_id	

		LEFT JOIN XBRL.di1041 C0370_TBL
			ON C0370_TBL.di1041_contextRef=CON.context_id	

		/***************EIOPA JOINS***************************/

		LEFT JOIN X_EIOPA_CD UNWI
			ON 
				TRIM(C0340_TBL.ei1814) = TRIM(UNWI.XBRL_CD)
				AND UNWI.EFFECTIVE_TO_DATE = '31/12/9999  23:59:59'

		ORDER BY 
			ID_C0040.ID ;
						
DROP TABLE 
	WORK.PART_B;
			
QUIT;
