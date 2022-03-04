PROC SQL;

CREATE TABLE DATE_CONTEXT AS 

	SELECT 
	  DISTINCT
		'REPORT_NAME' AS CONTEXT_NAME LENGTH = 50
		,CASE WHEN  explicitMember='s2c_MC:x169' THEN 'S080101-D2o_SOLO'
			ELSE explicitMember END AS CONTEXT_DESC  LENGTH = 50
	FROM 
		 XBRL.explicitMember 

UNION ALL 

	SELECT 
	  DISTINCT
		'ENTITY_NAME' AS CONTEXT_NAME LENGTH = 50
		,CASE WHEN  identifier = '213800FF2R23ALJQOP04' THEN 'DirectLine Group plc'
				WHEN identifier = '549300Z5UV7Z65LTYJ43' THEN 'U K Insurance Limited'
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
