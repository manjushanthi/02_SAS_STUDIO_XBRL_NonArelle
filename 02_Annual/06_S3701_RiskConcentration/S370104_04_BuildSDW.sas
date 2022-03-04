PROC SQL ;

OPTIONS MISSING='';

CREATE TABLE SDW_S370104_PARTA_VW AS 

SELECT 
	
	C0020 INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''
	, C0120 INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''
	, C0060 INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''
	, C0010 INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''

	,  CASE 
		WHEN C0040 = 'GBXT' THEN 's2c_GA:x115' 
		ELSE CASE 
				WHEN C0040 = '' THEN ''
				ELSE TRIM('s2c_GA:'||TRIM(C0040)) 
			 END 
	  END AS C0040_XBRL INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''	
	, C0040 INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''

	, EXPO.XBRL_CD AS C0050_XBRL  INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''
	, C0050 INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''

	, C0080  INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''
	,  CASE 
		WHEN C0090 = 'S&P Global Ratings Europe Limited (LEI code:5493008B2TU3S6QE1E12)'  THEN 's2c_SE:x179'
		WHEN C0090 = 'Fitch Ratings Limited (LEI code: 2138009F8YAHVC8W3Q52)' THEN 's2c_SE:x147'
		WHEN C0090 = 'Moody��s Investors Service Ltd (LEI code: 549300SM89WABHDNJ349)'  THEN 's2c_SE:x154'
		ELSE ECAI.XBRL_CD 
	   END AS C0090_XBRL INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''
	, C0090 INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''

	, C0091 INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''

	, CASE 
		WHEN C0100 = '' THEN '' 
		ELSE 's2c_NC:'||TRIM(C0100) 
	  END AS C0100_XBRL INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''
	,  C0100 INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''


	,  C0110 INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''
	,  PUT(C0140,YYMMDD10.) AS C0140
	,  ROUND(C0150,0.01) AS C0150 FORMAT=12.2

	, CASE 
		WHEN C0160 = '' THEN ''
		ELSE 's2c_CU:'||C0160
	  END AS C0160_XBRL INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''
	,  C0160 INFORMAT=$200. FORMAT=$200. LENGTH=200 LABEL = ''


	,  C0170 FORMAT=COMMA15.2  LABEL =''   
 
FROM 
	SDW_S370104_PART_A 

LEFT JOIN 
	X_EIOPA_CD EXPO
		ON 
			TRIM(C0050) = TRIM(EXPO.EIOPA_CD)
			AND EXPO.EFFECTIVE_TO_DATE = '31/12/9999  23:59:59'
			AND EXPO.EIOPA_CATEGORY = 'EXPOSURE_TYPE'


LEFT JOIN 
	X_EIOPA_CD ECAI
		ON 
			C0090 = ECAI.EIOPA_DESCRIPTION
			AND ECAI.EFFECTIVE_TO_DATE = '31/12/9999  23:59:59'
			AND TRIM(ECAI.EIOPA_CATEGORY) = 'ECAI'
	;

QUIT;

