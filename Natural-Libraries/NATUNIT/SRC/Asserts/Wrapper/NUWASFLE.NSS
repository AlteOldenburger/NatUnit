* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
DEFINE DATA

PARAMETER
01 P-EXPECTED (F8) BY VALUE
01 P-ACTUAL (F8) BY VALUE
01 P-ACCURACY (F8) BY VALUE OPTIONAL
01 P-RESULT (L)

LOCAL USING NUCONST
LOCAL USING NUASSP

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE WRAP-ASSERT-F8-EQUALS
/***********************************************************************

P-RESULT := TRUE
PERFORM ASSERT-F8-EQUALS NUASSP P-EXPECTED P-ACTUAL P-ACCURACY

INCLUDE NUWRAPIN

END-SUBROUTINE
/***********************************************************************

END

