* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
/***********************************************************************

/*  File: ASSARNCO

/*  Asserts that a numerical array contains the given value.

/***********************************************************************
DEFINE DATA

PARAMETER USING NUASSP

PARAMETER
01 P-HAYSTACK (N12,7/1:*) BY VALUE
01 P-NEEDLE (N12,7) BY VALUE

LOCAL USING NUCONST

LOCAL

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE ASSERT-ARRAY-N-CONTAINS
/***********************************************************************

INCLUDE NUASSHD

IF *OCC(P-HAYSTACK) EQ 0
  COMPRESS 'Element <' P-NEEDLE '> not found in empty array.' INTO NUASSP.MESSAGE LEAVING NO SPACE
  *ERROR-NR := C-NU-ASSERTION-ERROR
END-IF

IF NOT P-HAYSTACK(*) = P-NEEDLE
  COMPRESS 'Element <' P-NEEDLE '> not found in array.' INTO NUASSP.MESSAGE LEAVING NO SPACE
  *ERROR-NR := C-NU-ASSERTION-ERROR
END-IF

END-SUBROUTINE
/***********************************************************************

END

