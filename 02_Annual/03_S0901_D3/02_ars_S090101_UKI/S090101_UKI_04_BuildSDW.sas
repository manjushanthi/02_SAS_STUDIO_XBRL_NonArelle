PROC SQL ;

OPTIONS MISSING='';

CREATE TABLE SDW_S090101_PARTA_VW AS 

SELECT 
	
	ASST.XBRL_CD AS C0040_XBRL  INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = ''
	, C0040  INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = ''

	, PORT.XBRL_CD AS C0050_XBRL  INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = ''
	, C0050 INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = ''

	, LINK.XBRL_CD AS C0060_XBRL  INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = ''
	, C0060 INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = ''

	, C0070 INFORMAT=$88. FORMAT=$88. LENGTH=88 LABEL = ''

	, SUM(C0080) AS C0080 
	, SUM(C0090) AS C0090 
	, SUM(C0100) AS C0100 
	, SUM(C0110) AS C0110 

FROM 
	SDW_S090101_PART_A 


LEFT JOIN 
	X_EIOPA_CD ASST
		ON 
			TRIM(C0040) = TRIM(ASST.EIOPA_CD)
			AND ASST.EFFECTIVE_TO_DATE = '31/12/9999  23:59:59'
			AND ASST.EIOPA_CATEGORY = 'ASSET_CATEGORY'

LEFT JOIN 
	X_EIOPA_CD PORT
		ON 
			C0050 = PORT.EIOPA_CD
			AND PORT.EFFECTIVE_TO_DATE = '31/12/9999  23:59:59'
			AND PORT.EIOPA_CATEGORY = 'PORTFOLIO_CLASSIFICATION'

LEFT JOIN 
	X_EIOPA_CD LINK
		ON 
			C0060 = LINK.EIOPA_CD
			AND LINK.EFFECTIVE_TO_DATE = '31/12/9999  23:59:59'
			AND LINK.EIOPA_CATEGORY = 'UNIT_INDEX_LINKED'
GROUP BY 

	C0040_XBRL 
	, C0040 

	, C0050_XBRL 
	, C0050

	, C0060_XBRL 
	, C0060

	, C0070
	
	ORDER BY 
	
		C0040	
		,C0050	
		,C0060		;
QUIT;