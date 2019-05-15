* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
DEFINE DATA

PARAMETER
01 P-HAYSTACK (A/1:*) DYNAMIC BY VALUE
01 P-NEEDLE (A) DYNAMIC BY VALUE
01 P-RESULT (L)

LOCAL USING NUCONST
LOCAL USING NUASSP

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE WRAP-ASSERT-ARRAY-A-NOT-CONTAINS
/***********************************************************************

P-RESULT := TRUE
PERFORM ASSERT-ARRAY-A-NOT-CONTAINS NUASSP P-HAYSTACK(*) P-NEEDLE

INCLUDE NUWRAPIN

END-SUBROUTINE
/***********************************************************************

END

