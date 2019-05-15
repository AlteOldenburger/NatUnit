* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
/***********************************************************************

/*  File: ASSBINEQ

/*  Asserts that two binary values are equal.

/***********************************************************************
DEFINE DATA

PARAMETER USING NUASSP

PARAMETER
01 P-EXPECTED (B) DYNAMIC BY VALUE
01 P-ACTUAL (B) DYNAMIC BY VALUE

LOCAL USING NUCONST

LOCAL
01 #GIVEN-MESSAGE (A) DYNAMIC

1 #INDEX (I4)
1 #LENGTH (I4)

1 #VALUE-A(A2)
1 #VALUE-B (B1)
01 #EXPECTED-A (A) DYNAMIC
01 #ACTUAL-A (A) DYNAMIC

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE ASSERT-BINARY-EQUALS
/***********************************************************************

INCLUDE NUASSHD

IF NUASSP.MESSAGE NE ' '
  #GIVEN-MESSAGE := NUASSP.MESSAGE
END-IF

IF *TRIM(P-ACTUAL) NE *TRIM(P-EXPECTED)
  #LENGTH := *LENGTH(P-EXPECTED)
  FOR #INDEX = 1 TO #LENGTH
    MOVE SUBSTRING(P-EXPECTED,#INDEX,1) TO #VALUE-B
    MOVE EDITED #VALUE-B (EM=H) TO #VALUE-A
    COMPRESS #EXPECTED-A #VALUE-A TO #EXPECTED-A LEAVING NO SPACE
  END-FOR
  #LENGTH := *LENGTH(P-ACTUAL)
  FOR #INDEX = 1 TO #LENGTH
    MOVE SUBSTRING(P-ACTUAL,#INDEX,1) TO #VALUE-B
    MOVE EDITED #VALUE-B (EM=H) TO #VALUE-A
    COMPRESS #ACTUAL-A #VALUE-A TO #ACTUAL-A LEAVING NO SPACE
  END-FOR
  COMPRESS '<H"' #ACTUAL-A '"> should be <H"' #EXPECTED-A '">.' INTO NUASSP.MESSAGE LEAVING NO
  COMPRESS #GIVEN-MESSAGE NUASSP.MESSAGE INTO NUASSP.MESSAGE
  *ERROR-NR := C-NU-ASSERTION-ERROR
END-IF

END-SUBROUTINE
/***********************************************************************

END

