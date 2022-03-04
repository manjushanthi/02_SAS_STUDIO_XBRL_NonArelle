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
	

	CREATE TABLE WORK.QRG_S060204_PARTA_VW AS 
	
		SELECT 

			 ID_C0020.ID AS C0020 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''

			, ID_C0040.ID AS C0040 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, ID_C0070.ID AS C0070 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, ID_C0080.ID AS C0080 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''

			, C0010_TBL.si1376 AS C0010 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, C0060_TBL.ei2426 AS C0060_XBRL INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, PORT.EIOPA_CD AS C0060 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, C0090_TBL.ei1070 AS C0090_XBRL INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, LINK.EIOPA_CD AS C0090 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, C0100_TBL.ei1007 AS C0100_XBRL INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, COLL.EIOPA_CD AS C0100 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, C0110_TBL.ei1061 AS C0110_XBRL INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, CASE 
				WHEN SUBSTR(TRIM(C0110_TBL.ei1061),INDEX(TRIM(C0110_TBL.ei1061),':')+1,LENGTH(TRIM(C0110_TBL.ei1061))) = 'x115' THEN 'GBXT' 
				ELSE SUBSTR(TRIM(C0110_TBL.ei1061),INDEX(TRIM(C0110_TBL.ei1061),':')+1,LENGTH(TRIM(C0110_TBL.ei1061)))
			  END AS C0110 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			  
			, C0120_TBL.si1780 AS C0120  INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, C0130_TBL.ri2265 AS C0130  FORMAT = 12.4  LABEL = '' 
			, C0140_TBL.mi1110 AS C0140  FORMAT = 12.2  LABEL = '' 
			
			, C0150_TBL.ei2218 AS C0150_XBRL INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, VALU.EIOPA_CD AS C0150 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, C0160_TBL.mi1987 AS C0160 FORMAT = 12.2 LABEL=''
			, C0170_TBL.mi1131 AS C0170 FORMAT = 12.2 LABEL=''
			, C0180_TBL.mi1128 AS C0180 FORMAT = 12.2 LABEL=''
			
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
		INNER JOIN XBRL.typedMember TM4_C0080
			ON PA.scenario_ORDINAL = TM4_C0080.scenario_ORDINAL
			AND TM4_C0080.typedMember_dimension = 's2c_dim:MP'			
		
		INNER JOIN XBRL.ID ID_C0080
			ON ID_C0080.typedMember_ORDINAL = TM4_C0080.typedMember_ORDINAL	
		/*****************C0090********************/	

		/***************Join Metrics tables********************/
		
		LEFT JOIN XBRL.si1376 C0010_TBL
			ON C0010_TBL.si1376_contextRef=CON.context_id
			
		LEFT JOIN XBRL.ei2426 C0060_TBL
			ON C0060_TBL.ei2426_contextRef=CON.context_id	

		LEFT JOIN XBRL.ei1070 C0090_TBL
			ON C0090_TBL.ei1070_contextRef=CON.context_id	
			
		LEFT JOIN XBRL.ei1007 C0100_TBL
			ON C0100_TBL.ei1007_contextRef=CON.context_id	

		LEFT JOIN XBRL.ei1061 C0110_TBL
			ON C0110_TBL.ei1061_contextRef=CON.context_id

		LEFT JOIN XBRL.si1780 C0120_TBL
			ON C0120_TBL.si1780_contextRef=CON.context_id	
			
		LEFT JOIN XBRL.ri2265 C0130_TBL
			ON C0130_TBL.ri2265_contextRef=CON.context_id	
			
		LEFT JOIN XBRL.mi1110 C0140_TBL
			ON C0140_TBL.mi1110_contextRef=CON.context_id	

		LEFT JOIN XBRL.ei2218 C0150_TBL
			ON C0150_TBL.ei2218_contextRef=CON.context_id			

		LEFT JOIN XBRL.mi1987 C0160_TBL
			ON C0160_TBL.mi1987_contextRef=CON.context_id	

		LEFT JOIN XBRL.mi1131 C0170_TBL
			ON C0170_TBL.mi1131_contextRef=CON.context_id	

		LEFT JOIN XBRL.mi1128 C0180_TBL
			ON C0180_TBL.mi1128_contextRef=CON.context_id				

		/***************EIOPA JOINS***************************/

		LEFT JOIN X_EIOPA_CD PORT
		ON 
			C0060_TBL.ei2426 = PORT.XBRL_CD
			AND PORT.EFFECTIVE_TO_DATE = '31/12/9999  23:59:59'
		
		LEFT JOIN X_EIOPA_CD LINK
		ON 
			C0090_TBL.ei1070 = LINK.XBRL_CD
			AND LINK.EFFECTIVE_TO_DATE = '31/12/9999  23:59:59'

		LEFT JOIN X_EIOPA_CD COLL
		ON 
			C0100_TBL.ei1007 = COLL.XBRL_CD
			AND COLL.EFFECTIVE_TO_DATE = '31/12/9999  23:59:59'	

		LEFT JOIN X_EIOPA_CD VALU
		ON 
			C0150_TBL.ei2218 = SUBSTR(TRIM(VALU.XBRL_CD),1,INDEX(TRIM(VALU.XBRL_CD),'/')-1)
			AND VALU.EFFECTIVE_TO_DATE = '31/12/9999  23:59:59'			
		
		ORDER BY 
			ID_C0040.ID;
						
	/* ------------------------------------------------------------*/
	/* Delete Temporary Part_A table */
	/* ------------------------------------------------------------*/		
	DROP TABLE 
		WORK.PART_A;
		
QUIT;




/*************************************************************************************/
/************************************** Build Part B  *******************************/
/***********************************************************************************/

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

CREATE TABLE WORK.QRG_S060204_PARTB_VW AS  
	
	SELECT 
	
			ID_C0040.ID AS C0040 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, C0190_TBL.si1338 AS C0190 INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''

			, C0200_TBL.si1381 AS C0200 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, C0210_TBL.si1552 AS C0210 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, C0230_TBL.ei1658 AS C0230_XBRL INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, CASE 
				WHEN C0230_TBL.ei1658 = '' THEN '' 
				WHEN C0230_TBL.ei1658 = 's2c_NC:x0' THEN C0230_TBL.ei1658
				ELSE SUBSTR(C0230_TBL.ei1658,LENGTH(C0230_TBL.ei1658)-4) 	
			  END AS C0230 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, COMPRESS(C0240_TBL.si1337) AS C0240 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, C0250_TBL.si1553 AS C0250 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			
			, C0270_TBL.ei1062 AS C0270_XBRL INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			, CASE 
				WHEN SUBSTR(TRIM(C0270_TBL.ei1062),INDEX(TRIM(C0270_TBL.ei1062),':')+1,LENGTH(TRIM(C0270_TBL.ei1062))) = 'x115' THEN 'GBXT' 
				WHEN SUBSTR(TRIM(C0270_TBL.ei1062),INDEX(TRIM(C0270_TBL.ei1062),':')+1,LENGTH(TRIM(C0270_TBL.ei1062))) = 'x116' THEN 'GIXT' 
				ELSE SUBSTR(TRIM(C0270_TBL.ei1062),INDEX(TRIM(C0270_TBL.ei1062),':')+1,LENGTH(TRIM(C0270_TBL.ei1062)))
			  END AS C0270 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			 
			 , C0280_TBL.ei1024 AS C0280_XBRL INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			 , CASE 
				WHEN TRIM(C0280_TBL.ei1024) = '' THEN '' 
				ELSE SUBSTR(C0280_TBL.ei1024,LENGTH(C0280_TBL.ei1024)-2) 	
			  END AS C0280 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			 
			 , C0290_TBL.si1554 AS C0290 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			 
			 , C0300_TBL.ei2422 AS C0300_XBRL INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			 , INFRA.EIOPA_CD AS C0300 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			 
			 , C0310_TBL.ei2222 AS C0310_XBRL INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			 , PART.EIOPA_CD AS C0310 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			 
			 , C0320_TBL.si1555 AS C0320 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			 
			 , C0330_TBL.ei2551 AS C0330_XBRL INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			 , CASE 
				WHEN C0330_TBL.ei2551 = 's2c_SE:x179' THEN 'S&P Global Ratings Europe Limited (LEI code:5493008B2TU3S6QE1E12)'
				WHEN C0330_TBL.ei2551 = 's2c_SE:x147' THEN 'Fitch Ratings Limited (LEI code: 2138009F8YAHVC8W3Q52)'
				WHEN C0330_TBL.ei2551 = 's2c_SE:x154' THEN 'Moody???s Investors Service Ltd (LEI code: 549300SM89WABHDNJ349)'
				ELSE ECAI.EIOPA_DESCRIPTION  
			   END AS C0330 INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = '' 
			   
			 , C0340_TBL.ei2522 AS C0340_XBRL INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			 , QUAL.EIOPA_CD AS C0340 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			 
			 , C0350_TBL.si1782 AS C0350 INFORMAT=$100. FORMAT=$100. LENGTH=100 LABEL = ''
			 
			 , C0360_TBL.ri2266 AS C0360 LABEL = '' FORMAT=COMMA15.4
			 , C0370_TBL.mi1126 AS C0370 FORMAT=12.2 INFORMAT=COMMA12. LABEL=''
			 , C0380_TBL.pi1286 AS C0380  FORMAT=12.4 INFORMAT=COMMA12. LABEL=''
			 
			 , PUT(C0390_TBL.di1041,YYMMDD10.) AS C0390
			 
			
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
		
		LEFT JOIN XBRL.si1338 C0190_TBL
			ON C0190_TBL.si1338_contextRef=CON.context_id
			
		LEFT JOIN XBRL.si1381 C0200_TBL
			ON C0200_TBL.si1381_contextRef=CON.context_id	
		
		LEFT JOIN XBRL.si1552 C0210_TBL
			ON C0210_TBL.si1552_contextRef=CON.context_id		
		
		LEFT JOIN XBRL.ei1658 C0230_TBL
			ON C0230_TBL.ei1658_contextRef=CON.context_id	

		LEFT JOIN XBRL.si1337 C0240_TBL
			ON C0240_TBL.si1337_contextRef=CON.context_id		
			
		LEFT JOIN XBRL.si1553 C0250_TBL
			ON C0250_TBL.si1553_contextRef=CON.context_id					
			
		LEFT JOIN XBRL.ei1062 C0270_TBL
			ON C0270_TBL.ei1062_contextRef=CON.context_id	

		LEFT JOIN XBRL.ei1024 C0280_TBL
			ON C0280_TBL.ei1024_contextRef=CON.context_id				
		
		LEFT JOIN XBRL.si1554 C0290_TBL
			ON C0290_TBL.si1554_contextRef=CON.context_id	

		LEFT JOIN XBRL.ei2422 C0300_TBL
			ON C0300_TBL.ei2422_contextRef=CON.context_id		
			
		LEFT JOIN XBRL.ei2222 C0310_TBL
			ON C0310_TBL.ei2222_contextRef=CON.context_id	
			
		LEFT JOIN XBRL.si1555 C0320_TBL
			ON C0320_TBL.si1555_contextRef=CON.context_id	

		LEFT JOIN XBRL.ei2551 C0330_TBL
			ON C0330_TBL.ei2551_contextRef=CON.context_id	

		LEFT JOIN XBRL.ei2522 C0340_TBL
			ON C0340_TBL.ei2522_contextRef=CON.context_id		
			
		LEFT JOIN XBRL.si1782 C0350_TBL
			ON C0350_TBL.si1782_contextRef=CON.context_id	
			
		LEFT JOIN XBRL.ri2266 C0360_TBL
			ON C0360_TBL.ri2266_contextRef=CON.context_id	
			
		LEFT JOIN XBRL.mi1126 C0370_TBL
			ON C0370_TBL.mi1126_contextRef=CON.context_id	
			
		LEFT JOIN XBRL.pi1286 C0380_TBL
			ON C0380_TBL.pi1286_contextRef=CON.context_id	

		LEFT JOIN XBRL.di1041 C0390_TBL
			ON C0390_TBL.di1041_contextRef=CON.context_id				
			
		/***************EIOPA JOINS***************************/

		LEFT JOIN X_EIOPA_CD INFRA
		ON  C0300_TBL.ei2422 = INFRA.XBRL_CD
			AND INFRA.EFFECTIVE_TO_DATE = '31/12/9999  23:59:59'

		LEFT JOIN X_EIOPA_CD PART
		ON C0310_TBL.ei2222 = PART.XBRL_CD
			AND PART.EFFECTIVE_TO_DATE = '31/12/9999  23:59:59'

		LEFT JOIN X_EIOPA_CD ECAI
		ON 	C0330_TBL.ei2551 = ECAI.XBRL_CD
			AND ECAI.EFFECTIVE_TO_DATE = '31/12/9999  23:59:59'
			AND ECAI.EIOPA_CATEGORY = 'ECAI'
			AND ECAI.EIOPA_SHORT_DESC LIKE '%HIG%'
			
		LEFT JOIN X_EIOPA_CD QUAL
		ON C0340_TBL.ei2522 = QUAL.XBRL_CD
		   AND QUAL.EFFECTIVE_TO_DATE = '31/12/9999  23:59:59'			

		ORDER BY 
			ID_C0040.ID ;
						
DROP TABLE 
	WORK.PART_B;
			
QUIT;
