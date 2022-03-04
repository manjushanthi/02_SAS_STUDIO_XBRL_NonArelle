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
	/* 					Build Part A View for S0801  				*/
	/* -------------------------------------------------------------*/	
	

	CREATE TABLE WORK.QRG_S080104_PARTA_VW AS 
	
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
		
			, '' AS C0120 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = '' /*WILL NOT BE AVAILABLE IN THE XBRL CODE*/ 
		
			, C0130_TBL.mi1112 AS C0130 FORMAT = 12.2 INFORMAT=COMMA12.
			
			, C0140_TBL.ei1851 AS C0140_XBRL   INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, BYSE.EIOPA_CD AS C0140     INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = '' 
		
			, C0150_TBL.mi1812 AS C0150 FORMAT = 12.2			
			, C0160_TBL.mi1813 AS C0160 FORMAT = 12.2
			
			, C0170_TBL.ii1067 AS C0170 FORMAT = 12.
			
			,'' AS C0180 /*WILL NOT BE AVAILABLE IN THE XBRL CODE*/  INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL=''
			,'' AS C0190 /*WILL NOT BE AVAILABLE IN THE XBRL CODE*/  INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL=''
			
			, C0200_TBL.mi1115 AS C0200 FORMAT = 12.2
			, C0210_TBL.mi1096 AS C0210 FORMAT = 12.2
			
			, PUT(C0220_TBL.di1047,YYMMDD10.) AS C0220  FORMAT=$CHAR10.

			, C0230_TBL.ri2266 AS C0230 LABEL = '' FORMAT = COMMA15.4
			
			, C0240_TBL.mi1127 AS C0240 LABEL = '' FORMAT = COMMA15.2
		
			, C0250_TBL.ei2294 AS C0250_XBRL INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, VALU.EIOPA_CD AS C0250 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
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

		LEFT JOIN XBRL.mi1112 C0130_TBL
			ON C0130_TBL.mi1112_contextRef=CON.context_id		
			
		LEFT JOIN XBRL.ei1851 C0140_TBL
			ON C0140_TBL.ei1851_contextRef=CON.context_id	
			
		LEFT JOIN XBRL.mi1812 C0150_TBL
			ON C0150_TBL.mi1812_contextRef=CON.context_id

		LEFT JOIN XBRL.mi1813 C0160_TBL
			ON C0160_TBL.mi1813_contextRef=CON.context_id			
			
		LEFT JOIN XBRL.ii1067 C0170_TBL
			ON C0170_TBL.ii1067_contextRef=CON.context_id	

		LEFT JOIN XBRL.mi1115 C0200_TBL
			ON C0200_TBL.mi1115_contextRef=CON.context_id	
			
		LEFT JOIN XBRL.mi1096 C0210_TBL
			ON C0210_TBL.mi1096_contextRef=CON.context_id		
		
		LEFT JOIN XBRL.di1047 C0220_TBL
			ON C0220_TBL.di1047_contextRef=CON.context_id

		LEFT JOIN XBRL.ri2266 C0230_TBL
			ON C0230_TBL.ri2266_contextRef=CON.context_id				
			
		LEFT JOIN XBRL.mi1127 C0240_TBL
			ON C0240_TBL.mi1127_contextRef=CON.context_id	
			
		LEFT JOIN XBRL.ei2294 C0250_TBL
			ON C0250_TBL.ei2294_contextRef=CON.context_id				
			
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
			
		LEFT JOIN X_EIOPA_CD BYSE /*Buyer Seller*/
		ON 
			C0140_TBL.ei1851 = SUBSTR(TRIM(BYSE.XBRL_CD),1,INDEX(TRIM(BYSE.XBRL_CD),'/')-1)
			AND BYSE.EFFECTIVE_TO_DATE = '31/12/9999  23:59:59'

		LEFT JOIN X_EIOPA_CD VALU
		ON 
			C0250_TBL.ei2294 = SUBSTR(TRIM(VALU.XBRL_CD),INDEX(TRIM(VALU.XBRL_CD),'/')+1,LENGTH(TRIM(VALU.XBRL_CD)))
			AND VALU.EFFECTIVE_TO_DATE = '31/12/9999  23:59:59'			
							
		ORDER BY 
			ID_C0040.ID;
						
	/* ------------------------------------------------------------*/
	/* Delete Temporary Part_A table */
	/* ------------------------------------------------------------*/		
	DROP TABLE 
		WORK.PART_A;
		
QUIT;


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

CREATE TABLE WORK.QRG_S080104_PARTB_VW AS  
	
	SELECT 
	
			ID_C0040.ID AS C0040 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, C0260_TBL.si1378 AS C0260 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, C0270_TBL.si1558 AS C0270 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
						
			, C0290_TBL.si1555 AS C0290 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, C0300_TBL.ei2534 AS C0300_XBRL INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''
			, ECAI.EIOPA_DESCRIPTION AS C0300 INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''
			
			, C0310_TBL.ei1866 AS C0310_XBRL INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, QUAL.EIOPA_CD AS C0310 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
									
			, '' AS C0320 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, C0330_TBL.si1336 AS C0330 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, C0340_TBL.si1559 AS C0340 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, C0360_TBL.si1341 AS C0360 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, C0370_TBL.ei1024 AS C0370_XBRL INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, CASE 
				WHEN TRIM(C0370_TBL.ei1024) = '' THEN '' 
				ELSE SUBSTR(C0370_TBL.ei1024,LENGTH(C0370_TBL.ei1024)-2) 	
			  END AS C0370 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			  
			, C0380_TBL.si1554 AS C0380 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''			
			, C0390_TBL.si1340 AS C0390 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, C0400_TBL.ei1814 AS C0400_XBRL INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, UNWI.EIOPA_CD AS C0400 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, '' AS C0410_XBRL  /* Not Available in source */ INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, '' AS C0410		/* Not Available in source */ INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, '' AS C0420_XBRL	/* Not Available in source */ INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, '' AS C0420		/* Not Available in source */ INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''	
			
			, PUT(C0430_TBL.di1041,YYMMDD10.) AS C0430  FORMAT=$10. 
			
			
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
		
		LEFT JOIN XBRL.si1378 C0260_TBL
			ON C0260_TBL.si1378_contextRef=CON.context_id
			
		LEFT JOIN XBRL.si1558 C0270_TBL
			ON C0270_TBL.si1558_contextRef=CON.context_id	

		LEFT JOIN XBRL.si1555 C0290_TBL
			ON C0290_TBL.si1555_contextRef=CON.context_id	

		LEFT JOIN XBRL.ei2534 C0300_TBL
			ON C0300_TBL.ei2534_contextRef=CON.context_id	

		LEFT JOIN XBRL.ei1866 C0310_TBL
			ON C0310_TBL.ei1866_contextRef=CON.context_id				

		LEFT JOIN XBRL.si1336 C0330_TBL
			ON C0330_TBL.si1336_contextRef=CON.context_id
			
		LEFT JOIN XBRL.si1559 C0340_TBL
			ON C0340_TBL.si1559_contextRef=CON.context_id	

		LEFT JOIN XBRL.si1341 C0360_TBL
			ON C0360_TBL.si1341_contextRef=CON.context_id			
		
		LEFT JOIN XBRL.ei1024 C0370_TBL
			ON C0370_TBL.ei1024_contextRef=CON.context_id	
			
		LEFT JOIN XBRL.si1554 C0380_TBL
			ON C0380_TBL.si1554_contextRef=CON.context_id
			
		LEFT JOIN XBRL.si1340 C0390_TBL
			ON C0390_TBL.si1340_contextRef=CON.context_id			
			
		LEFT JOIN XBRL.ei1814 C0400_TBL
			ON C0400_TBL.ei1814_contextRef=CON.context_id	

		LEFT JOIN XBRL.di1041 C0430_TBL
			ON C0430_TBL.di1041_contextRef=CON.context_id	

		/***************EIOPA JOINS***************************/

		LEFT JOIN X_EIOPA_CD UNWI
			ON 
				TRIM(C0400_TBL.ei1814) = TRIM(UNWI.XBRL_CD)
				AND UNWI.EFFECTIVE_TO_DATE = '31/12/9999  23:59:59'

		LEFT JOIN X_EIOPA_CD ECAI
			ON 
				C0300_TBL.ei2534 = ECAI.XBRL_CD
				AND ECAI.EFFECTIVE_TO_DATE = '31/12/9999  23:59:59'
				AND ECAI.EIOPA_CATEGORY = 'ECAI'
				AND ECAI.EIOPA_SHORT_DESC LIKE '%HIG%'

		LEFT JOIN X_EIOPA_CD QUAL
			ON 
				C0310_TBL.ei1866 = QUAL.XBRL_CD
				AND QUAL.EFFECTIVE_TO_DATE = '31/12/9999  23:59:59'
				

		ORDER BY 
			ID_C0040.ID ;
						
DROP TABLE 
	WORK.PART_B;
			
QUIT;
