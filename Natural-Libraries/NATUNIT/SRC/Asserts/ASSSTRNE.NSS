* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
/***********************************************************************

/*  File: ASSSTRNE

/*  Asserts that the given string is not empty.

/***********************************************************************
DEFINE DATA

PARAMETER USING NUASSP

PARAMETER
01 P-ACTUAL (A) DYNAMIC BY VALUE

LOCAL USING NUCONST

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE ASSERT-STRING-NOT-EMPTY
/***********************************************************************

INCLUDE NUASSHD

IF *TRIM(P-ACTUAL) EQ ' '
  COMPRESS NUASSP.MESSAGE 'String is empty.' INTO NUASSP.MESSAGE LEAVING NO
  *ERROR-NR := C-NU-ASSERTION-ERROR
END-IF

END-SUBROUTINE
/***********************************************************************

END

