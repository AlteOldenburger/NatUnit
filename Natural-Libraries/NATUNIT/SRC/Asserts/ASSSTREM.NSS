* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
/***********************************************************************

/*  File: ASSSTREM

/*  Asserts that the given string is empty.

/***********************************************************************
DEFINE DATA

PARAMETER USING NUASSP

PARAMETER
01 P-ACTUAL (A) DYNAMIC BY VALUE

LOCAL USING NUCONST

LOCAL
01 #THE-STRING (A) DYNAMIC

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE ASSERT-STRING-EMPTY
/***********************************************************************

INCLUDE NUASSHD

IF *TRIM(P-ACTUAL) NE ' '
  COMPRESS '<' P-ACTUAL '>' INTO #THE-STRING LEAVING NO
  COMPRESS NUASSP.MESSAGE 'String' #THE-STRING 'is not empty.' INTO NUASSP.MESSAGE
  *ERROR-NR := C-NU-ASSERTION-ERROR
END-IF

END-SUBROUTINE
/***********************************************************************

END

