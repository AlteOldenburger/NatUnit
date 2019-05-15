* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
DEFINE DATA

PARAMETER
01 P-RESULT (L)

LOCAL USING NUCONST
LOCAL USING NUASSP

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE WRAP-ASSERT-FAIL
/***********************************************************************

P-RESULT := TRUE
PERFORM ASSERT-FAIL NUASSP

INCLUDE NUWRAPIN

END-SUBROUTINE
/***********************************************************************

END

