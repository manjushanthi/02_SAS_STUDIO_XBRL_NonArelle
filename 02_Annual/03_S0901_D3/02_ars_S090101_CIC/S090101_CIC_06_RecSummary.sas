PROC SQL;

CREATE TABLE REC_SUM AS 

	SELECT 
		'S090101-D3_CIC_SOLO' AS QRT
		, 'SDW' AS SYSTEM LENGTH = 4
		, 'PART_A_CNT' AS QRT_PART
		, COUNT(*) AS COUNT 
		, SUM(C0080) AS MKT_VALUE
	FROM 
		SDW_S090101_PARTA_VW 
	
UNION ALL 

	SELECT 
		'S090101-D3_CIC_SOLO' AS QRT
		, 'XBRL' AS SYSTEM LENGTH = 4
		, 'PART_A_CNT' AS QRT_PART
		, COUNT(*) AS COUNT 
		, SUM(C0080) AS MKT_VALUE
	FROM 
		ARS_S090101_PARTA_VW 
	
UNION ALL 

	SELECT 
		'S090101-D3_CIC_SOLO' AS QRT
		, 'DIFF' AS SYSTEM LENGTH = 4
		, 'PART_A_CNT' AS QRT_PART
		, COUNT(A.C0040) - COUNT(B.C0040) AS COUNT 
		, SUM(A.C0080) - SUM(B.C0080) AS MKT_VALUE
	FROM 
		SDW_S090101_PARTA_VW  A , 
		ARS_S090101_PARTA_VW  B			
	WHERE 
		A.C0040=B.C0040
	;

QUIT;


PROC SORT DATA=REC_SUM;
BY QRT  SYSTEM  ;
RUN;


PROC TRANSPOSE DATA=WORK.REC_SUM OUT=WORK.REC_SUM_CNT (DROP=_NAME_)  ;

/*Y - AXIS*/
BY QRT SYSTEM   ;

/*PIVOT MONETARY COLUMN*/
VAR COUNT ;

/*X - AXIS PIVOTAL COLUMN*/
ID QRT_PART;

/* Remove the '.' to ''*/
OPTIONS MISSING='';

RUN;


PROC TRANSPOSE DATA=WORK.REC_SUM OUT=WORK.REC_SUM_AMT (DROP=_NAME_ RENAME=PART_A_CNT=PART_A_MKT_VAL)   ;

/*Y - AXIS*/
BY QRT SYSTEM   ;

/*PIVOT MONETARY COLUMN*/
VAR MKT_VALUE ;

/*X - AXIS PIVOTAL COLUMN*/
ID QRT_PART;

/* Remove the '.' to ''*/
OPTIONS MISSING='';

RUN;


DATA REC_SUM_FINAL;
MERGE REC_SUM_CNT REC_SUM_AMT;
BY SYSTEM;
RUN;

PROC SORT DATA=REC_SUM_FINAL;
BY DESCENDING  SYSTEM ; 
RUN;

PROC PRINT DATA=REC_SUM_FINAL;
FORMAT  PART_A_MKT_VAL COMMA21.2;
RUN;
