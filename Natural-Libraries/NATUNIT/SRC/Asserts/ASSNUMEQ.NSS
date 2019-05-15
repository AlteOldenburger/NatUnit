* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
/***********************************************************************

/*  File: ASSNUMEQ

/*  Asserts that the given (floating point) numbers are equal (difference
/*  is less than the given accuracy).

/***********************************************************************
DEFINE DATA

PARAMETER USING NUASSP

PARAMETER
01 P-EXPECTED (N20,7) BY VALUE
01 P-ACTUAL (N20,7) BY VALUE
01 P-ACCURACY (N1,7) BY VALUE OPTIONAL

LOCAL USING NUCONST

LOCAL
01 #DIFFERENCE (N20,7)
01 #ACCURACY (N1,7)
01 #GIVEN-MESSAGE (A) DYNAMIC

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE ASSERT-NUM-EQUALS
/***********************************************************************

INCLUDE NUASSHD

IF NUASSP.MESSAGE NE ' '
  #GIVEN-MESSAGE := NUASSP.MESSAGE
END-IF

IF P-ACCURACY NOT SPECIFIED
  #ACCURACY := 0
ELSE
  #ACCURACY := P-ACCURACY
END-IF
IF #ACCURACY < 0
  MULTIPLY #ACCURACY BY -1
END-IF

#DIFFERENCE := P-EXPECTED - P-ACTUAL
IF #DIFFERENCE < 0
  MULTIPLY #DIFFERENCE BY -1
END-IF
IF #DIFFERENCE LE #ACCURACY
  #DIFFERENCE := 0
END-IF

IF #DIFFERENCE NE 0
  COMPRESS NUMERIC '<' P-ACTUAL '> should be <' P-EXPECTED '>' INTO NUASSP.MESSAGE LEAVING NO
  IF P-ACCURACY SPECIFIED
    COMPRESS NUMERIC NUASSP.MESSAGE '(accuracy:' #ACCURACY INTO NUASSP.MESSAGE
    COMPRESS NUMERIC NUASSP.MESSAGE ')'  INTO NUASSP.MESSAGE LEAVING NO
  END-IF
  COMPRESS #GIVEN-MESSAGE NUASSP.MESSAGE INTO NUASSP.MESSAGE
  *ERROR-NR := C-NU-ASSERTION-ERROR
END-IF

END-SUBROUTINE
/***********************************************************************

END

