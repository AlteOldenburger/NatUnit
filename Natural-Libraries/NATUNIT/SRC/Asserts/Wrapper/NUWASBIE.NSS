* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
DEFINE DATA

PARAMETER
01 P-EXPECTED (B) DYNAMIC BY VALUE
01 P-ACTUAL (B) DYNAMIC BY VALUE
01 P-RESULT (L)

LOCAL USING NUCONST
LOCAL USING NUASSP

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE WRAP-ASSERT-BINARY-EQUALS
/***********************************************************************

P-RESULT := TRUE
PERFORM ASSERT-BINARY-EQUALS NUASSP P-EXPECTED P-ACTUAL

INCLUDE NUWRAPIN

END-SUBROUTINE
/***********************************************************************

END

