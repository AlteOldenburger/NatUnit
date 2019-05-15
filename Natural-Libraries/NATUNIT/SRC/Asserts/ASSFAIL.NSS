* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
/***********************************************************************

/*  File: ASSFAIL

/*  Assertion that always fails.

/***********************************************************************
DEFINE DATA

PARAMETER USING NUASSP

LOCAL USING NUCONST

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE ASSERT-FAIL
/***********************************************************************

INCLUDE NUASSHD

RESET NUASSP.EXPECTED-ERROR
*ERROR-NR := C-NU-ASSERTION-ERROR

END-SUBROUTINE
/***********************************************************************

END

