PROC SQL;

CREATE TABLE DATE_CONTEXT AS 

	SELECT 
	  DISTINCT
		'REPORT_NAME' AS CONTEXT_NAME LENGTH = 50
		,CASE WHEN explicitMember='s2c_MC:x168' THEN 'S060301_D4_SOLO_CIC'
			ELSE explicitMember_dimension END AS CONTEXT_DESC  LENGTH = 50
	FROM 
		XBRL.explicitMember

UNION ALL 

	SELECT 
	  DISTINCT
		'SDW_ENTITY_NAME' AS CONTEXT_NAME LENGTH = 50
		,CASE 
			WHEN F2 = '549300Z5UV7Z65LTYJ43' THEN 'U K Insurance Limited'
			WHEN F2 = '2138007B4PLYNW611O59' THEN 'Churchill Insurance Company Limited'
			WHEN F2 = '213800FF2R23ALJQOP04' THEN 'Directline Group plc'
			ELSE F2 END AS CONTEXT_DESC  LENGTH = 50
	FROM 
		SDW_CONTEXT 
	WHERE 	
		F1 = 'Entity'

UNION ALL 

	SELECT 
	  DISTINCT
		'XBRL_ENTITY_NAME' AS CONTEXT_NAME LENGTH = 50
		,CASE 
			WHEN identifier = '549300Z5UV7Z65LTYJ43' THEN 'U K Insurance Limited'
			WHEN identifier = '2138007B4PLYNW611O59' THEN 'Churchill Insurance Company Limited'
			WHEN identifier = '213800FF2R23ALJQOP04' THEN 'Directline Group plc'
			ELSE identifier END AS CONTEXT_DESC  LENGTH = 50
	FROM 
		XBRL.identifier  	
	

UNION ALL 

	SELECT 
		'SDW_EXTRACTION' AS CONTEXT_NAME LENGTH = 25
		, PUT ( (INPUT(F2,32.) - 21916) , YYMMDD10.) AS CONTEXT_DESC  
	FROM 
		SDW_CONTEXT 
	WHERE 	
		UPCASE(F1)='CONTEXT'

UNION ALL 

	SELECT 
		DISTINCT 
		'XBRL_EXTRACTION' LENGTH = 25
		 ,PUT(instant,YYMMDD10.)
		/*Invoke XBRL gets a day after the reporting date*/ 
	FROM 
		XBRL.period 

UNION ALL 

	SELECT 
		DISTINCT 
		'TAXONOMY_VERSION' AS CONTEXT_NAME LENGTH = 25
		 ,MAX(XBRL_VERSION)
	FROM 
		X_EIOPA_CD 
	WHERE 
		XBRL_VERSION <> ''

	;
QUIT;


PROC PRINT DATA=DATE_CONTEXT;
RUN;
