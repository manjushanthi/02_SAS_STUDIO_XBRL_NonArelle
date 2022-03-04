PROC SQL ;

OPTIONS MISSING='';

CREATE TABLE SDW_S110104_PARTA_VW AS 

SELECT 
	
	C0020 LABEL = 's2c_dim:CE'

	, C0040 INFORMAT=$24. FORMAT=$24. LENGTH=24 LABEL = 's2c_dim:UI'

	, C0010

	, C0060

	, C0070

	, CASE 
		WHEN C0080 = 'GBXT' THEN 's2c_GA:x115' 
		ELSE CASE 
				WHEN C0080 = '' THEN ''
				ELSE TRIM('s2c_GA:'||TRIM(C0080)) 
			 END 
	  END AS C0080_XBRL INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL='C0080_XBRL'
	, C0080 LENGTH=88  FORMAT=$88.  INFORMAT=$88. LABEL='C0080'

	, C0090 INFORMAT=$1. FORMAT=$1. LENGTH=1 LABEL = 'C0090'

	, C0100  INFORMAT=12.2 FORMAT=12.2 LABEL = 'C0100'

	, SUBSTR(TRIM(VALU.XBRL_CD),1,INDEX(TRIM(VALU.XBRL_CD),'/')-1) AS C0110_XBRL INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = 'C0110_XBRL'
	, C0110 LENGTH=14 FORMAT=$14. INFORMAT=$14. LABEL='C0110'

	, C0120 INFORMAT=12.2 FORMAT=12.2 LABEL = 'C0120'

	, C0130 INFORMAT=12.2 FORMAT=12.2 LABEL = 'C0130'

	, ASST.XBRL_CD AS C0140_XBRL  INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = 'C0140_XBRL'
	, C0140  LENGTH=14 FORMAT=$14. INFORMAT=$14. LABEL='C0140'

FROM 
	SDW_S110104_PART_A 

LEFT JOIN 
	X_EIOPA_CD VALU
		ON 
			C0110 = VALU.EIOPA_CD 
			AND VALU.EFFECTIVE_TO_DATE = '31/12/9999  23:59:59'
			AND TRIM(VALU.EIOPA_CATEGORY) = 'VALUATION_METHOD'

LEFT JOIN 
	X_EIOPA_CD ASST
		ON 
			C0140 = ASST.EIOPA_CD
			AND ASST.EFFECTIVE_TO_DATE = '31/12/9999  23:59:59'
			AND TRIM(ASST.EIOPA_CATEGORY) = 'ASSET_PLEDGED_TYPE'

		;
QUIT;


PROC SQL ;

OPTIONS MISSING='';

CREATE TABLE SDW_S110104_PARTB_VW AS 

SELECT 
	
 	C0040 INFORMAT=$24. FORMAT=$24. LENGTH=24 LABEL = 's2c_dim:UI'
	, C0150 INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = 'C0150'
	, C0160 INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = 'C0160'
	, C0170 INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = 'C0170'

	, CASE 
		WHEN C0190 = '' THEN '' 
		ELSE 's2c_NC:'||TRIM(C0190) 
	  END AS C0190_XBRL INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = 'C0190_XBRL'
	, C0190 INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = 'C0190'

	, C0200  INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = 'C0200'
	, C0210  INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = 'C0210'

	, CASE 
		WHEN C0230 = '' THEN ''
		WHEN C0230 = 'GBXT' THEN 's2c_GA:x115'
		WHEN C0230 = 'GIXT' THEN 's2c_GA:x116'
		ELSE 's2c_GA:'||C0230
	  END AS C0230_XBRL INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = 'C0230_XBRL'
	, C0230 INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = 'C0230'

	, CASE 
		WHEN C0240 = '' THEN ''
		ELSE 's2c_CU:'||C0240
	  END AS C0240_XBRL INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = 'C0240_XBRL'
	, C0240  INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = 'C0240'

	, C0250 INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = 'C0250'

	, '' AS C0260

	, ROUND(C0270,0.0001) AS C0270 FORMAT = 12.4 INFORMAT=COMMA12. 

	, PUT(C0280,YYMMDD10.) AS C0280 INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = 'C0280'

FROM 
	SDW_S110104_PART_B ;

QUIT;

