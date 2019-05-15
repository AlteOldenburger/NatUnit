* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
/***********************************************************************

/*  File: ASSNUMLT

/*  Asserts that the value of the given number is less than the given value.

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
DEFINE SUBROUTINE ASSERT-NUM-LESS-THAN
/***********************************************************************

INCLUDE NUASSHD

IF NUASSP.MESSAGE NE ' '
  #GIVEN-MESSAGE := NUASSP.MESSAGE
END-IF

IF P-EXPECTED GE P-ACTUAL
  COMPRESS NUMERIC '<' P-EXPECTED '> should be less than <' P-ACTUAL '>'
    INTO NUASSP.MESSAGE LEAVING NO
  COMPRESS #GIVEN-MESSAGE NUASSP.MESSAGE INTO NUASSP.MESSAGE
  *ERROR-NR := C-NU-ASSERTION-ERROR
END-IF

END-SUBROUTINE
/***********************************************************************

END

