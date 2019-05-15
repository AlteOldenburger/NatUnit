* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
/***********************************************************************

/*  File: ASSARANS

/*  Asserts that two alphanumerical arrays are not the same (don't contain
/*  the same elements in the same order).

/***********************************************************************
DEFINE DATA

PARAMETER USING NUASSP

PARAMETER
01 P-EXPECTED (A/1:*) DYNAMIC BY VALUE
01 P-ACTUAL (A/1:*) DYNAMIC BY VALUE

LOCAL USING NUCONST

LOCAL
01 #ARRAYS-ARE-DIFFERENT (L)

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE ASSERT-ARRAY-A-NOT-SAME
/***********************************************************************

#ARRAYS-ARE-DIFFERENT := TRUE
PERFORM ASSERT-ARRAY-A-SAME NUASSP P-EXPECTED(*) P-ACTUAL(*)

#ARRAYS-ARE-DIFFERENT := FALSE
COMPRESS NUASSP.MESSAGE 'Arrays are not different.' INTO NUASSP.MESSAGE
*ERROR-NR := C-NU-ASSERTION-ERROR

ON ERROR
  IF *ERROR-NR EQ C-NU-ASSERTION-ERROR
    IF #ARRAYS-ARE-DIFFERENT
      RESET NUASSP.MESSAGE
      ESCAPE ROUTINE
    ELSE
      *ERROR-NR := C-NU-ASSERTION-ERROR
    END-IF
  END-IF
END-ERROR

END-SUBROUTINE
/***********************************************************************

END

