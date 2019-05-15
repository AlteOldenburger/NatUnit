* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
/***********************************************************************

/*  File: ASSSTREQ

/*  Asserts that two strings are equal.

/***********************************************************************
DEFINE DATA

PARAMETER USING NUASSP

PARAMETER
01 P-EXPECTED (A) DYNAMIC BY VALUE
01 P-ACTUAL (A) DYNAMIC BY VALUE

LOCAL USING NUCONST

LOCAL
01 #GIVEN-MESSAGE (A) DYNAMIC

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE ASSERT-STRING-EQUALS
/***********************************************************************

INCLUDE NUASSHD

IF NUASSP.MESSAGE NE ' '
  #GIVEN-MESSAGE := NUASSP.MESSAGE
END-IF

EXAMINE P-ACTUAL FOR H'0A' REPLACE '\n'
EXAMINE P-EXPECTED FOR H'0A' REPLACE '\n'

IF *TRIM(P-ACTUAL) NE *TRIM(P-EXPECTED)
  COMPRESS '<' P-ACTUAL '> should be <' P-EXPECTED '>.' INTO NUASSP.MESSAGE LEAVING NO
  COMPRESS #GIVEN-MESSAGE NUASSP.MESSAGE INTO NUASSP.MESSAGE
  *ERROR-NR := C-NU-ASSERTION-ERROR
END-IF

END-SUBROUTINE
/***********************************************************************

END
