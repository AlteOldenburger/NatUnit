* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
DEFINE DATA

PARAMETER
01 P-EXPECTED (A) DYNAMIC BY VALUE
01 P-ACTUAL (A) DYNAMIC BY VALUE
01 P-RESULT (L)

LOCAL USING NUCONST
LOCAL USING NUASSP

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE WRAP-ASSERT-STRING-SAME
/***********************************************************************

P-RESULT := TRUE
PERFORM ASSERT-STRING-SAME NUASSP P-EXPECTED P-ACTUAL

INCLUDE NUWRAPIN

END-SUBROUTINE
/***********************************************************************

END

