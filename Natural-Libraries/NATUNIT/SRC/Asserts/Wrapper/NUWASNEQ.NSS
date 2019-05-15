* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
DEFINE DATA

PARAMETER
01 P-EXPECTED (N20,7) BY VALUE
01 P-ACTUAL (N20,7) BY VALUE
01 P-ACCURACY (N1,7) BY VALUE OPTIONAL
01 P-RESULT (L)

LOCAL USING NUCONST
LOCAL USING NUASSP

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE WRAP-ASSERT-NUM-EQUALS
/***********************************************************************

P-RESULT := TRUE
PERFORM ASSERT-NUM-EQUALS NUASSP P-EXPECTED P-ACTUAL P-ACCURACY

INCLUDE NUWRAPIN

END-SUBROUTINE
/***********************************************************************

END

