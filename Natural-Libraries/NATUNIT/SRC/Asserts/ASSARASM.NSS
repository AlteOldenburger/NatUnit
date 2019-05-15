* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
/***********************************************************************

/*  File: ASSARASM

/*  Asserts that two alphanumerical arrays are the same (contain the same
/*  elements in the same order).

/***********************************************************************
DEFINE DATA

PARAMETER USING NUASSP

PARAMETER
01 P-EXPECTED (A/1:*) DYNAMIC BY VALUE
01 P-ACTUAL (A/1:*) DYNAMIC BY VALUE

LOCAL USING NUCONST

LOCAL

01 #I (I4)
01 #MESSAGE-PART (A) DYNAMIC
01 #DIFFERENCE-FOUND (L)

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE ASSERT-ARRAY-A-SAME
/***********************************************************************

INCLUDE NUASSHD

IF *OCCURRENCE(P-ACTUAL) NE *OCCURRENCE(P-EXPECTED)
  COMPRESS NUASSP.MESSAGE 'Arrays have different lengths.' INTO NUASSP.MESSAGE
  *ERROR-NR := C-NU-ASSERTION-ERROR
END-IF

RESET #DIFFERENCE-FOUND

FOR #I 1 *OCCURRENCE(P-ACTUAL)
  IF P-ACTUAL(#I) NE P-EXPECTED(#I)
    COMPRESS FULL 'Index ' #I ': Value <' P-ACTUAL(#I) '> should be <' P-EXPECTED(#I) '>. '
      INTO #MESSAGE-PART LEAVING NO SPACE
    COMPRESS NUASSP.MESSAGE #MESSAGE-PART INTO NUASSP.MESSAGE
    #DIFFERENCE-FOUND := TRUE
  END-IF
END-FOR

IF #DIFFERENCE-FOUND
  *ERROR-NR := C-NU-ASSERTION-ERROR
END-IF

END-SUBROUTINE
/***********************************************************************

END

