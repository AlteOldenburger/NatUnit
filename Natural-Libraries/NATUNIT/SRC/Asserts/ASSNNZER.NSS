* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
/***********************************************************************

/*  File: ASSNNZER

/*  Asserts that the given number is not 0.

/***********************************************************************
DEFINE DATA

PARAMETER USING NUASSP

PARAMETER
01 P-ACTUAL (N20,7) BY VALUE

LOCAL USING NUCONST

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE ASSERT-NUM-NOT-ZERO
/***********************************************************************

INCLUDE NUASSHD

IF P-ACTUAL EQ 0
  COMPRESS NUASSP.MESSAGE 'Number is zero.' INTO NUASSP.MESSAGE
  *ERROR-NR := C-NU-ASSERTION-ERROR
END-IF

END-SUBROUTINE
/***********************************************************************

END

