* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
DEFINE DATA

PARAMETER
01 P-HAYSTACK (A) DYNAMIC BY VALUE
01 P-NEEDLES (A/1:*) DYNAMIC BY VALUE
01 P-RESULT (L)

LOCAL USING NUCONST
LOCAL USING NUASSP

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE WRAP-ASSERT-STRING-CONTAINS-ANY
/***********************************************************************

P-RESULT := TRUE
PERFORM ASSERT-STRING-CONTAINS-ANY NUASSP P-HAYSTACK P-NEEDLES(*)

INCLUDE NUWRAPIN

END-SUBROUTINE
/***********************************************************************

END

