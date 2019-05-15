* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
DEFINE DATA

PARAMETER
01 P-HAYSTACK (N12,7/1:*) BY VALUE
01 P-NEEDLE (N12,7) BY VALUE
01 P-RESULT (L)

LOCAL USING NUCONST
LOCAL USING NUASSP

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE WRAP-ASSERT-ARRAY-N-CONTAINS
/***********************************************************************

P-RESULT := TRUE
PERFORM ASSERT-ARRAY-N-CONTAINS NUASSP P-HAYSTACK(*) P-NEEDLE

INCLUDE NUWRAPIN

END-SUBROUTINE
/***********************************************************************

END

