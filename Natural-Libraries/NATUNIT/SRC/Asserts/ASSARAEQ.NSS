* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
/***********************************************************************

/*  File: ASSARAEQ

/*  Asserts that two alphanumerical arrays are equal (contain the same
/*  elements but not necessarily in the same order).

/***********************************************************************
DEFINE DATA

PARAMETER USING NUASSP

PARAMETER
01 P-EXPECTED (A/1:*) DYNAMIC BY VALUE
01 P-ACTUAL (A/1:*) DYNAMIC BY VALUE
01 P-IN-ORDER (L) OPTIONAL

LOCAL USING NUCONST

LOCAL
01 #MESSAGE-PART (A) DYNAMIC
01 #INDEX (I4)
01 #DIFFERENCE-FOUND (L)

01 #ORDER  (L)

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE ASSERT-ARRAY-A-EQUALS
/***********************************************************************
IF P-IN-ORDER SPECIFIED
  PERFORM ASSERT-ARRAY-A-SAME NUASSP P-EXPECTED(*) P-ACTUAL(*)
  ESCAPE MODULE
END-IF

INCLUDE NUASSHD

IF *OCCURRENCE(P-ACTUAL) NE *OCCURRENCE(P-EXPECTED)
  COMPRESS NUASSP.MESSAGE 'Arrays have different lengths.' INTO NUASSP.MESSAGE
  *ERROR-NR := C-NU-ASSERTION-ERROR
END-IF

RESET #DIFFERENCE-FOUND

FOR #INDEX = 1 TO *OCCURRENCE(P-EXPECTED)

  IF P-ACTUAL(#INDEX) EQ P-EXPECTED(*)
    ESCAPE TOP
  END-IF

  COMPRESS 'Element <' P-ACTUAL(#INDEX) '> not found.' INTO #MESSAGE-PART LEAVING NO
  COMPRESS NUASSP.MESSAGE #MESSAGE-PART INTO NUASSP.MESSAGE
  #DIFFERENCE-FOUND := TRUE
END-FOR

IF #DIFFERENCE-FOUND
  *ERROR-NR := C-NU-ASSERTION-ERROR
END-IF

END-SUBROUTINE
/***********************************************************************

END

