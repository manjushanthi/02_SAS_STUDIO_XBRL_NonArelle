/************************************ COMPARE PART A *********************/
PROC SORT DATA=SDW_S060304_PARTA_VW ; 
BY _ALL_;
RUN ;
PROC SORT DATA=ARG_S060304_PARTA_VW ; 
BY _ALL_;
RUN ;
PROC COMPARE BASE=SDW_S060304_PARTA_VW COMPARE=ARG_S060304_PARTA_VW;
ID C0010  C0030  C0040 C0050  ;
RUN;
