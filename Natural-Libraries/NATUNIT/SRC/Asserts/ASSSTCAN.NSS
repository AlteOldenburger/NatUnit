* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
/***********************************************************************

/*  File: ASSSTCAN

/*  Asserts that a string contains any string out of an array of other strings.

/***********************************************************************
DEFINE DATA

PARAMETER USING NUASSP

PARAMETER
01 P-HAYSTACK (A) DYNAMIC BY VALUE
01 P-NEEDLES (A/1:*) DYNAMIC BY VALUE

LOCAL USING NUCONST

LOCAL
01 #LENGTH-HAYSTACK (I4)
01 #LENGTH-NEEDLE (I4)

01 #INDEX (I4)

01 #POSITION-FOUND (I4)

01 #MESSAGE (A) DYNAMIC

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE ASSERT-STRING-CONTAINS-ANY
/***********************************************************************

INCLUDE NUASSHD

#LENGTH-HAYSTACK := *LENGTH(P-HAYSTACK)

FOR #INDEX = 1 TO *OCC(P-NEEDLES)

  #LENGTH-NEEDLE := *LENGTH(P-NEEDLES(#INDEX))

  IF #LENGTH-NEEDLE GT #LENGTH-HAYSTACK
      OR (#LENGTH-NEEDLE EQ #LENGTH-HAYSTACK AND P-NEEDLES(#INDEX) NE P-HAYSTACK)
    ESCAPE TOP
  END-IF

  EXAMINE FULL P-HAYSTACK FOR FULL P-NEEDLES(#INDEX) GIVING POSITION #POSITION-FOUND

  IF #POSITION-FOUND EQ 0
    ESCAPE TOP
  END-IF

  ESCAPE ROUTINE

END-FOR

COMPRESS 'No needle found in haystack <' P-HAYSTACK '>.' INTO #MESSAGE LEAVING NO
COMPRESS NUASSP.MESSAGE #MESSAGE INTO NUASSP.MESSAGE
*ERROR-NR := C-NU-ASSERTION-ERROR

END-SUBROUTINE
/***********************************************************************

END

