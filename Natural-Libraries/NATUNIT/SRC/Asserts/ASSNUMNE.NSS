* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
/***********************************************************************

/*  File: ASSNUMNE

/*  Asserts that two numbers are not equal.

/***********************************************************************
DEFINE DATA

PARAMETER USING NUASSP

PARAMETER
01 P-EXPECTED (N20,7) BY VALUE
01 P-ACTUAL (N20,7) BY VALUE

LOCAL USING NUCONST

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE ASSERT-NUM-NOT-EQUALS
/***********************************************************************

INCLUDE NUASSHD

IF P-EXPECTED EQ P-ACTUAL
  COMPRESS NUASSP.MESSAGE 'Numbers are equal.' INTO NUASSP.MESSAGE LEAVING NO
  *ERROR-NR := C-NU-ASSERTION-ERROR
END-IF

END-SUBROUTINE
/***********************************************************************

END

