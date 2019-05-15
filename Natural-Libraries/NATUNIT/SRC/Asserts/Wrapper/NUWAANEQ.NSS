* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
DEFINE DATA

PARAMETER
01 P-EXPECTED (N20,7/1:*) BY VALUE
01 P-ACTUAL (N20,7/1:*) BY VALUE
01 P-RESULT (L)

LOCAL USING NUCONST
LOCAL USING NUASSP

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE WRAP-ASSERT-ARRAY-N-EQUALS
/***********************************************************************

P-RESULT := TRUE
PERFORM ASSERT-ARRAY-N-EQUALS NUASSP P-EXPECTED(*) P-ACTUAL(*)

INCLUDE NUWRAPIN

END-SUBROUTINE
/***********************************************************************

END

