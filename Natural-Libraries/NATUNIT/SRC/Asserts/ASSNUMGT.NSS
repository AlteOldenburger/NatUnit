* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
/***********************************************************************

/*  File: ASSNUMGT

/*  Asserts that the value of the given number is greater than the given value.

/***********************************************************************
DEFINE DATA

PARAMETER USING NUASSP

PARAMETER
01 P-EXPECTED (N20,7) BY VALUE
01 P-ACTUAL (N20,7) BY VALUE

LOCAL USING NUCONST

LOCAL
01 #GIVEN-MESSAGE (A) DYNAMIC

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE ASSERT-NUM-GREATER-THAN
/***********************************************************************

INCLUDE NUASSHD

IF NUASSP.MESSAGE NE ' '
  #GIVEN-MESSAGE := NUASSP.MESSAGE
END-IF

IF P-EXPECTED LE P-ACTUAL
  COMPRESS NUMERIC '<' P-EXPECTED '> should be greater than <' P-ACTUAL '>'
    INTO NUASSP.MESSAGE LEAVING NO
  COMPRESS #GIVEN-MESSAGE NUASSP.MESSAGE INTO NUASSP.MESSAGE
  *ERROR-NR := C-NU-ASSERTION-ERROR
END-IF

END-SUBROUTINE
/***********************************************************************

END

