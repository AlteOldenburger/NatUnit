* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
DEFINE DATA

PARAMETER
01 P-ACTUAL (N20,7) BY VALUE
01 P-RESULT (L)

LOCAL USING NUCONST
LOCAL USING NUASSP

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE WRAP-ASSERT-NUM-NOT-ZERO
/***********************************************************************

P-RESULT := TRUE
PERFORM ASSERT-NUM-NOT-ZERO NUASSP P-ACTUAL

INCLUDE NUWRAPIN

END-SUBROUTINE
/***********************************************************************

END

