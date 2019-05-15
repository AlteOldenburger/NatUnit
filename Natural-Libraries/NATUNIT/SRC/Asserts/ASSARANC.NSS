* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
/***********************************************************************

/*  File: ASSARANC

/*  Asserts that an alphanumerical array does not contain the given value.

/***********************************************************************
DEFINE DATA

PARAMETER USING NUASSP

PARAMETER
01 P-HAYSTACK (A/1:*) DYNAMIC BY VALUE
01 P-NEEDLE (A) DYNAMIC BY VALUE

LOCAL USING NUCONST

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE ASSERT-ARRAY-A-NOT-CONTAINS
/***********************************************************************

INCLUDE NUASSHD

IF *OCC(P-HAYSTACK) EQ 0
  ESCAPE MODULE
END-IF

IF P-HAYSTACK(*) = P-NEEDLE
  COMPRESS 'Element <' P-NEEDLE '> found in array.' INTO NUASSP.MESSAGE LEAVING NO SPACE
  *ERROR-NR := C-NU-ASSERTION-ERROR
END-IF

END-SUBROUTINE
/***********************************************************************

END

