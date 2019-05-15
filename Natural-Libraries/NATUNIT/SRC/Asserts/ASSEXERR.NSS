* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
/***********************************************************************

/*  File: ASSEXERR

/*  Asserts sets the expected error-nr.

/***********************************************************************
DEFINE DATA

PARAMETER USING NUASSP

PARAMETER
01 P-EXPECTED-ERROR-NR (N4) BY VALUE

LOCAL USING NUCONST

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE ASSERT-EXPECTED-ERROR
/***********************************************************************
INCLUDE NUASSHD

NUASSP.EXPECTED-ERROR := P-EXPECTED-ERROR-NR
COMPRESS NUASSP.MESSAGE 'expected Natural error <' P-EXPECTED-ERROR-NR '>' INTO NUASSP.MESSAGE LEAVING NO

END-SUBROUTINE
/***********************************************************************

END

