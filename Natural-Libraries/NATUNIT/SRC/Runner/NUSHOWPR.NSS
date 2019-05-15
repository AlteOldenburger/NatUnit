* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
/***********************************************************************

/*  File: NUSHOWPR

/*  Shows all problems that occured during a test run.

/*  Parameters:
/*    NUTCP - The test results.

/***********************************************************************
DEFINE DATA

PARAMETER USING NUTCP

LOCAL USING NUCONST

LOCAL
01 #PROBLEMS (A/1:*) DYNAMIC
01 #P (I4)

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE NU-SHOW-PROBLEMS
/***********************************************************************

PERFORM NU-GET-PROBLEMS NUTCP #PROBLEMS(*)

FOR #P 1 *OCCURRENCE(#PROBLEMS)
  PERFORM NU-WRITE #PROBLEMS(#P)
END-FOR

END-SUBROUTINE
/***********************************************************************

END

