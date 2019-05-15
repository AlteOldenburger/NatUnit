* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
/***********************************************************************

/*  File: ASSTRUE

/*  Asserts that the given value is TRUE.

/***********************************************************************
DEFINE DATA

PARAMETER USING NUASSP

PARAMETER
01 P-ACTUAL (L) BY VALUE

LOCAL USING NUCONST

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE ASSERT-TRUE
/***********************************************************************

INCLUDE NUASSHD

IF NOT P-ACTUAL
  COMPRESS NUASSP.MESSAGE 'Value is FALSE.' INTO NUASSP.MESSAGE
  *ERROR-NR := C-NU-ASSERTION-ERROR
END-IF

END-SUBROUTINE
/***********************************************************************

END

