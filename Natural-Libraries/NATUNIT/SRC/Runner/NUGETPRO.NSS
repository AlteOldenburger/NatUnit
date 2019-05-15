* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
/***********************************************************************

/*  File: NUGETPRO

/*  Returns all problems that occured during the TestSuite's run.

/*  Parameters:
/*    NUTCP - The results of the TestSuite.

/*  Returns:
/*    P-PROBLEMS - All problems in an array.

/***********************************************************************
DEFINE DATA

PARAMETER USING NUTCP
PARAMETER
01 P-PROBLEMS (A/1:*) DYNAMIC

LOCAL USING NUCONST

LOCAL
01 #TC (I4)
01 #T (I4)

01 #L (I4)
01 #LINE (A) DYNAMIC
01 #MESSAGE (A) DYNAMIC

01 #RESULT (N1)

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE NU-GET-PROBLEMS
/***********************************************************************
REDUCE ARRAY P-PROBLEMS TO 0

IF NUTCP.TC-RESULT NE C-NU-SUCCESS
  #RESULT :=  NUTCP.TC-RESULT
  #MESSAGE := NUTCP.TC-MESSAGE
  #LINE := NUTCP.TESTCASENAME
  PERFORM ADD-RESULT
END-IF

#L := 0
FTC. FOR #TC 1 *OCCURRENCE(NUTCP.TEST)
  IF NUTCP.TEST(#TC) EQ ' '
      OR NUTCP.TEST-RESULT(#TC) EQ C-NU-SUCCESS
    ESCAPE TOP
  END-IF

  #RESULT := NUTCP.TEST-RESULT(#TC)
  #MESSAGE := NUTCP.TEST-MESSAGE(#TC)
  RESET #LINE
  IF NUTCP.TEST-DATA-PARAM(#TC) NE ' '
    COMPRESS '(' NUTCP.TEST-DATA-PARAM(#TC) ')' INTO #LINE LEAVING NO
  END-IF
  COMPRESS NUTCP.TEST(#TC) #LINE INTO #LINE
  PERFORM ADD-RESULT
END-FOR

/***********************************************************************
DEFINE SUBROUTINE ADD-RESULT
/***********************************************************************

DECIDE ON FIRST VALUE OF #RESULT
  VALUE C-NU-FAILURE
    COMPRESS '(F) ' #LINE INTO #LINE
  VALUE C-NU-ERROR
    COMPRESS '(E) ' #LINE INTO #LINE
  VALUE C-NU-SKIPPED
    COMPRESS '(S) ' #LINE INTO #LINE
  NONE
    ESCAPE ROUTINE
END-DECIDE

COMPRESS #LINE #MESSAGE INTO #LINE
ADD 1 TO #L
EXPAND ARRAY P-PROBLEMS TO (1:#L)
P-PROBLEMS(#L) := #LINE

END-SUBROUTINE
/***********************************************************************

END-SUBROUTINE
/***********************************************************************

END

