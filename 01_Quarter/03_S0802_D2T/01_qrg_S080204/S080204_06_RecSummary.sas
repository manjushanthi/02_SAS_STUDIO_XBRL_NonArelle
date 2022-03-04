PROC SQL;

CREATE TABLE REC_SUM AS 

	SELECT 
		'S080204_GROUP' AS QRT
		, 'SDW' AS SYSTEM LENGTH = 4
		, 'PART_A_CNT' AS QRT_PART
		, COUNT(*) AS COUNT 
		, SUM(C0230) AS MKT_VALUE
	FROM 
		SDW_S080204_PARTA_VW 
	

UNION ALL 

	SELECT 
		'S080204_GROUP' AS QRT
		, 'SDW' AS SYSTEM LENGTH = 4
		, 'PART_B_CNT' AS QRT_PART
		, COUNT(*) AS COUNT 
		, 0.00
	FROM 
		SDW_S080204_PARTB_VW 
	
UNION ALL 

	SELECT 
		'S080204_GROUP' AS QRT
		, 'XBRL' AS SYSTEM LENGTH = 4
		, 'PART_A_CNT' AS QRT_PART
		, COUNT(*) AS COUNT 
		, SUM(C0230) AS MKT_VALUE
	FROM 
		QRG_S080204_PARTA_VW 
	
UNION ALL 

	SELECT 
		'S080204_GROUP' AS QRT
		, 'XBRL' AS SYSTEM LENGTH = 4
		, 'PART_B_CNT' AS QRT_PART
		, COUNT(*) AS COUNT 
		,0.00
	FROM 
		QRG_S080204_PARTB_VW 


UNION ALL 


	SELECT 
		'S080204_GROUP' AS QRT
		, 'DIFF' AS SYSTEM LENGTH = 4
		, 'PART_A_CNT' AS QRT_PART
		, COUNT(A.C0040) - COUNT(B.C0040) AS COUNT 
		, SUM(A.C0230) - SUM(B.C0230) AS MKT_VALUE
	FROM 
		SDW_S080204_PARTA_VW  A , 
		QRG_S080204_PARTA_VW  B			
	WHERE 
		A.C0040=B.C0040

UNION ALL

		
	SELECT 
		'S080204_GROUP' AS QRT
		, 'DIFF' AS SYSTEM LENGTH = 4
		, 'PART_B_CNT' AS QRT_PART
		, COUNT(A.C0040) - COUNT(B.C0040) AS COUNT 
		, SUM(A.C0230) - SUM(B.C0230) AS MKT_VALUE
	FROM 
		SDW_S080204_PARTA_VW  A , 
		QRG_S080204_PARTA_VW  B			
	WHERE 
		A.C0040=B.C0040;


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


PROC TRANSPOSE DATA=WORK.REC_SUM OUT=WORK.REC_SUM_AMT (DROP=_NAME_ PART_B_CNT RENAME=PART_A_CNT=PART_A_MKT_VAL)   ;

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
