* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
/***********************************************************************

/*  File: ASSSTRCT

/*  Asserts that a string contains another string.

/***********************************************************************
DEFINE DATA

PARAMETER USING NUASSP

PARAMETER
01 P-HAYSTACK (A) DYNAMIC BY VALUE
01 P-NEEDLE (A) DYNAMIC BY VALUE

LOCAL USING NUCONST

LOCAL
01 #LENGTH-HAYSTACK (I4)
01 #LENGTH-NEEDLE (I4)
01 #POSITION-FOUND (I4)

01 #MESSAGE (A) DYNAMIC

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE ASSERT-STRING-CONTAINS
/***********************************************************************

INCLUDE NUASSHD

#LENGTH-HAYSTACK := *LENGTH(P-HAYSTACK)
#LENGTH-NEEDLE := *LENGTH(P-NEEDLE)

IF #LENGTH-NEEDLE GT #LENGTH-HAYSTACK
  COMPRESS 'Needle <' P-NEEDLE '> is longer than haystack <' P-HAYSTACK '>.' INTO #MESSAGE LEAVING NO
  COMPRESS NUASSP.MESSAGE #MESSAGE INTO NUASSP.MESSAGE
  *ERROR-NR := C-NU-ASSERTION-ERROR
END-IF

IF #LENGTH-NEEDLE EQ #LENGTH-HAYSTACK
    AND P-NEEDLE NE P-HAYSTACK
  COMPRESS 'Needle <' P-NEEDLE '> does not equal <' P-HAYSTACK '>.' INTO #MESSAGE LEAVING NO
  COMPRESS NUASSP.MESSAGE #MESSAGE INTO NUASSP.MESSAGE
  *ERROR-NR := C-NU-ASSERTION-ERROR
END-IF

IF #LENGTH-NEEDLE LT #LENGTH-HAYSTACK
  EXAMINE FULL P-HAYSTACK FOR FULL P-NEEDLE GIVING POSITION #POSITION-FOUND
  IF #POSITION-FOUND EQ 0
    COMPRESS 'Needle <' P-NEEDLE '> not found in haystack <' P-HAYSTACK '>.' INTO #MESSAGE LEAVING NO
    COMPRESS NUASSP.MESSAGE #MESSAGE INTO NUASSP.MESSAGE
    *ERROR-NR := C-NU-ASSERTION-ERROR
  END-IF
END-IF

END-SUBROUTINE

/***********************************************************************

END

