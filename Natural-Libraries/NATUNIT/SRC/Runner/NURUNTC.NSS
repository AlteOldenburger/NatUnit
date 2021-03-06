* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
/***********************************************************************

/*  File: NURUNTC

/*  Executes a single TestCase.

/*  Parameters:
/*    NUPARSEP - The parsed TestCase.

/*  Returns:
/*    NUTCP - The result of the TestCase's execution.

/***********************************************************************
DEFINE DATA

PARAMETER USING NUPARSEP
PARAMETER USING NUTCP

LOCAL USING NUTESTP
LOCAL USING NUCONST

LOCAL
01 #I (I4)
01 #J (I4)

01 #TEST-DATA-COUNTER (I4)
01 #TEST-COUNTER (I4)

01 #START-TIME (A10)
01 #END-TIME (A10)

01 #NUMBER-OF-TESTS (I4)

01 #N (I4)
01 #NEW-N (I4)
01 #N-MINUS-1 (I4)
01 #NUM-SORT-OBJECTS-PLUS-1 (I4)
01 #RAND1 (F8)
01 #RAND2 (F8)
01 #ACTION (I4)
01 #FROM (I4)
01 #TO (I4)
01 #TESTCASE (A8)
01 #TEST-INDEX (I4)
01 #FIRST-TEST-INDEX-IN-TESTCASE (I4)
01 #LAST-TEST-INDEX-IN-TESTCASE (I4)
01 #CALLING-TESTCASE (L)

END-DEFINE

DEFINE SUBROUTINE NU-RUN-TESTCASE

#NUMBER-OF-TESTS := *OCC(NUPARSEP.TEST)
IF #NUMBER-OF-TESTS EQ 0
  NUTCP.TC-RESULT := C-NU-ERROR
  NUTCP.TC-MESSAGE := 'No tests were given'
  ESCAPE MODULE
END-IF

RESET NUTCP.TC-RESULT NUTCP.TC-MESSAGE
REDUCE ARRAY NUTCP.TESTS TO 0
NUTCP.STARTTIME := *TIME

IF NOT NUPARSEP.RUN-IN-ORDER(*)
  PERFORM RANDOMIZE-TEST-EXECUTION
END-IF
PERFORM CORRECT-SETUP-TEARDOWN

FOR #I 1 #NUMBER-OF-TESTS
  RESET NUTESTP
  NUTCP.LIBNAME := NUPARSEP.TESTLIB(#I)
  NUTCP.TESTCASENAME := NUPARSEP.TESTCASE(#I)
  NUTESTP.TESTLIB := NUPARSEP.TESTLIB(#I)
  NUTESTP.TESTCASE := NUPARSEP.TESTCASE(#I)
  NUTESTP.FIXTURE := NUPARSEP.FIXTURE(#I)
  NUTESTP.TEST := NUPARSEP.TEST(#I)
  NUTESTP.TEST-DATA-PARAM := NUPARSEP.TEST-DATA-PARAM(#I)
  NUTESTP.HAS-SETUP := NUPARSEP.HAS-SETUP(#I)
  NUTESTP.HAS-TEARDOWN := NUPARSEP.HAS-TEARDOWN(#I)
  NUTESTP.RUN-SETUP-TESTCASE := NUPARSEP.HAS-SETUP-TESTCASE(#I)
  NUTESTP.RUN-TEARDOWN-TESTCASE := NUPARSEP.HAS-TEARDOWN-TESTCASE(#I)
  PERFORM EXECUTE-TEST
END-FOR

/***********************************************************************
DEFINE SUBROUTINE EXECUTE-TEST
/***********************************************************************
SET CONTROL 'N'
#START-TIME := *TIME
IF NUTESTP.RUN-SETUP-TESTCASE AND NUTESTP.RUN-TEARDOWN-TESTCASE
  PERFORM RUN-TEST
  NUTESTP.RUN-SETUP-TESTCASE := FALSE
  NUTESTP.RUN-TEARDOWN-TESTCASE := FALSE
  PERFORM RUN-TEST
  NUTESTP.RUN-TEARDOWN-TESTCASE := TRUE
  PERFORM RUN-TEST
  ESCAPE ROUTINE
END-IF

IF NUTESTP.RUN-SETUP-TESTCASE
  PERFORM RUN-TEST
  NUTESTP.RUN-SETUP-TESTCASE := FALSE
  PERFORM RUN-TEST
  ESCAPE ROUTINE
END-IF

IF NUTESTP.RUN-TEARDOWN-TESTCASE
  NUTESTP.RUN-TEARDOWN-TESTCASE := FALSE
  PERFORM RUN-TEST
  NUTESTP.RUN-TEARDOWN-TESTCASE := TRUE
  PERFORM RUN-TEST
  ESCAPE ROUTINE
END-IF

PERFORM RUN-TEST

SET CONTROL 'N'
INPUT ' '

END-SUBROUTINE
/***********************************************************************

/***********************************************************************
DEFINE SUBROUTINE RUN-TEST
/***********************************************************************

#CALLING-TESTCASE := TRUE
CALLNAT NUTESTP.TESTCASE NUTESTP
#CALLING-TESTCASE := FALSE

/* set result to skipped, if Test was skipped (0 assertions and result SUCCESS)
IF NUTESTP.NUM-ASSERTS = 0
    AND (NUTESTP.RESULT = C-NU-EMPTY
    OR NUTESTP.RESULT = C-NU-SUCCESS)
  IF NOT NUTESTP.RUN-SETUP-TESTCASE
      AND NOT NUTESTP.RUN-TEARDOWN-TESTCASE
    NUTESTP.RESULT := C-NU-SKIPPED
  ELSE
    IF NUTESTP.RUN-SETUP-TESTCASE
      NUTESTP.RESULT := C-NU-SETUP-TESTCASE
    ELSE
      IF NUTESTP.RUN-TEARDOWN-TESTCASE
        NUTESTP.RESULT := C-NU-TEARDOWN-TESTCASE
      END-IF
    END-IF
  END-IF
END-IF

PERFORM UPDATE-TEST-RESULT
PERFORM ADD-TEST-RESULT

END-SUBROUTINE
/***********************************************************************

/***********************************************************************
DEFINE SUBROUTINE ADD-TEST-RESULT
/***********************************************************************

#END-TIME := *TIME

ADD 1 TO #TEST-COUNTER
EXPAND ARRAY NUTCP.TESTS TO (1:#TEST-COUNTER)

NUTCP.TESTLIB(#TEST-COUNTER) := NUTESTP.TESTLIB
NUTCP.TESTCASE(#TEST-COUNTER) := NUTESTP.TESTCASE
NUTCP.FIXTURE(#TEST-COUNTER) := NUTESTP.FIXTURE
NUTCP.TEST(#TEST-COUNTER) := NUTESTP.TEST
NUTCP.TEST-DATA-PARAM(#TEST-COUNTER) := NUTESTP.TEST-DATA-PARAM
NUTCP.NUM-ASSERTS(#TEST-COUNTER) := NUTESTP.NUM-ASSERTS
NUTCP.TEST-MESSAGE(#TEST-COUNTER) := NUTESTP.MESSAGE
NUTCP.TEST-STARTTIME(#TEST-COUNTER) := #START-TIME
NUTCP.TEST-ENDTIME(#TEST-COUNTER) := #END-TIME
NUTCP.TEST-RESULT(#TEST-COUNTER) := NUTESTP.RESULT

END-SUBROUTINE
/***********************************************************************

/***********************************************************************
DEFINE SUBROUTINE UPDATE-TEST-RESULT
/***********************************************************************

NUTCP.ENDTIME := *TIME

IF NUTESTP.RESULT NE C-NU-SETUP-TESTCASE
    AND NUTESTP.RESULT NE C-NU-TEARDOWN-TESTCASE
  IF NUTESTP.RESULT GT NUTCP.TC-RESULT
    NUTCP.TC-RESULT := NUTESTP.RESULT
  END-IF
  IF NUTESTP.MESSAGE NE ' '
    NUTCP.TC-MESSAGE := NUTESTP.MESSAGE
  END-IF
END-IF

END-SUBROUTINE
/***********************************************************************

/***********************************************************************
DEFINE SUBROUTINE RANDOMIZE-TEST-EXECUTION
/***********************************************************************
#N := #NUMBER-OF-TESTS
#NUM-SORT-OBJECTS-PLUS-1 := #N + 1

EXPAND ARRAY NUPARSEP.TESTS TO (1:#NUM-SORT-OBJECTS-PLUS-1)

FOR #J = 1 TO #NUMBER-OF-TESTS
  #NEW-N := 1
  #N-MINUS-1 := #N - 1

  #RAND1 := NURAND(<>)
  #RAND2 := NURAND(<>)

  FOR #I = 1 TO #N-MINUS-1
    IF NUPARSEP.TESTCASE(#I) > NUPARSEP.TESTCASE(#I + 1)
        OR (NUPARSEP.TESTCASE(#I) EQ NUPARSEP.TESTCASE(#I + 1)
        AND #RAND1 > #RAND2)
      MOVE BY NAME NUPARSEP.TESTS(#I) TO NUPARSEP.TESTS(#NUM-SORT-OBJECTS-PLUS-1)
      MOVE BY NAME NUPARSEP.TESTS(#I + 1) TO NUPARSEP.TESTS(#I)
      MOVE BY NAME NUPARSEP.TESTS(#NUM-SORT-OBJECTS-PLUS-1) TO NUPARSEP.TESTS(#I + 1)
      #NEW-N := #I + 1
    END-IF
  END-FOR

  #N := #NEW-N
  IF (#N <= 1)
    ESCAPE BOTTOM
  END-IF

END-FOR

REDUCE ARRAY NUPARSEP.TESTS TO (1:#NUMBER-OF-TESTS)

END-SUBROUTINE
/***********************************************************************

/***********************************************************************
DEFINE SUBROUTINE CORRECT-SETUP-TEARDOWN
/***********************************************************************
RESET #TESTCASE

IF #NUMBER-OF-TESTS > 0
  #TESTCASE := NUPARSEP.TESTCASE(1)
  #FIRST-TEST-INDEX-IN-TESTCASE := 1
END-IF

FOR #TEST-INDEX = 1 TO #NUMBER-OF-TESTS

  IF NUPARSEP.TESTCASE(#TEST-INDEX) NE #TESTCASE
    PERFORM CORRECT
    #TESTCASE := NUPARSEP.TESTCASE(#TEST-INDEX)
    #FIRST-TEST-INDEX-IN-TESTCASE := #TEST-INDEX
  END-IF

  #LAST-TEST-INDEX-IN-TESTCASE := #TEST-INDEX
END-FOR

PERFORM CORRECT

END-SUBROUTINE
/***********************************************************************

/***********************************************************************
DEFINE SUBROUTINE CORRECT
/***********************************************************************
#ACTION := #LAST-TEST-INDEX-IN-TESTCASE - #FIRST-TEST-INDEX-IN-TESTCASE

IF #ACTION LE 0
  ESCAPE ROUTINE
END-IF

IF #ACTION GE 1
  RESET NUPARSEP.HAS-TEARDOWN-TESTCASE(#FIRST-TEST-INDEX-IN-TESTCASE)
  RESET NUPARSEP.HAS-SETUP-TESTCASE(#LAST-TEST-INDEX-IN-TESTCASE)
END-IF

IF #ACTION > 1
  #FROM := #FIRST-TEST-INDEX-IN-TESTCASE +1
  #TO := #LAST-TEST-INDEX-IN-TESTCASE -1

  RESET NUPARSEP.HAS-TEARDOWN-TESTCASE(#FROM:#TO)
  RESET NUPARSEP.HAS-SETUP-TESTCASE(#FROM:#TO)
END-IF

END-SUBROUTINE
/***********************************************************************

ON ERROR
  NUTESTP.RESULT := C-NU-ERROR
  COMPRESS '<' NUTESTP.TESTLIB '.' NUTESTP.TESTCASE '>' INTO NUTESTP.MESSAGE LEAVING NO
  IF #CALLING-TESTCASE AND *ERROR-NR EQ 82
    COMPRESS 'TestCase not found:' NUTESTP.MESSAGE INTO NUTESTP.MESSAGE
  ELSE
    COMPRESS 'WARNING: Error ' *ERROR-NR 'in line ' *ERROR-LINE 'was propagated to' *PROGRAM
      'while calling TestCase' NUTESTP.MESSAGE INTO NUTESTP.MESSAGE
  END-IF
  PERFORM ADD-TEST-RESULT
  PERFORM UPDATE-TEST-RESULT
  ESCAPE MODULE
END-ERROR

END-SUBROUTINE

END

