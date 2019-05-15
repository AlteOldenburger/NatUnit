* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
/***********************************************************************

/*  File: ASSFALSE

/*  Asserts that the given value is FALSE.

/***********************************************************************
DEFINE DATA

PARAMETER USING NUASSP

PARAMETER
01 P-ACTUAL (L) BY VALUE

LOCAL USING NUCONST

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE ASSERT-FALSE
/***********************************************************************

INCLUDE NUASSHD

IF P-ACTUAL
  COMPRESS NUASSP.MESSAGE 'Value is TRUE.' INTO NUASSP.MESSAGE
  *ERROR-NR := C-NU-ASSERTION-ERROR
END-IF

END-SUBROUTINE
/***********************************************************************

END

