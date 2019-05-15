* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
/***********************************************************************

/*  File: NUXML

/*  Creates the NATUNIT result as an XML string in JUnit format.

/*  Parameters:
/*    NUTCP - The test results.
/*    P-XML - The test results as an XML string.

/***********************************************************************
DEFINE DATA

PARAMETER USING NUTCP
PARAMETER
01 P-XML (A) DYNAMIC
01 P-PREFIX (A) DYNAMIC BY VALUE OPTIONAL

LOCAL USING NUCONST
LOCAL USING NUCRSTAP

LOCAL

01 #SIZE-TESTS (I4)
01 #INDEX-TESTS (I4)
01 #T (I4)
01 #OLDDEVICE (I4)
01 #OLDFILENAME (A) DYNAMIC
01 #TIMESTRING (A8)

01 #CLASSNAME (A) DYNAMIC
01 #TESTCASENAME (A) DYNAMIC

01 #INDEX-SUITE (I4)

01 #CNT-TESTS (I4)
01 #CNT-ERROR (I4)
01 #CNT-FAILURE (I4)
01 #CNT-SKIPPED (I4)

01 #REPLACE-NUCT (A6/1:5) INIT<H'26', H'3E', H'3C', H'22', H'27'>
01 #REPLACE-XML (A6/1:5) INIT<'&amp;', '&gt;', '&lt;', '&quot;', '&apos;'>

01 #STARTTIME (A10)
01 REDEFINE #STARTTIME
  02 #ST-HOURS (N2)
  02 #ST-FIRSTP (A1)
  02 #ST-MINS (N2)
  02 #ST-SECP (A1)
  02 #ST-SEC (N2)
  02 #ST-THIRDP (A1)
  02 #ST-MSEC (N1)

01 #ENDTIME (A10)
01 REDEFINE #ENDTIME
  02 #ET-HOURS (N2)
  02 #ET-FIRSTP (A1)
  02 #ET-MINS (N2)
  02 #ET-SECP (A1)
  02 #ET-SEC (N2)
  02 #ET-THIRDP (A1)
  02 #ET-MSEC (N1)

01 #STARTTIMES (N12,1)
01 #ENDTIMES (N12,1)
01 #DIFFTIMES (N12,3)

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE NU-CREATE-XML-OUTPUT
/***********************************************************************

PERFORM NU-CREATE-STATISTICS NUTCP NUCRSTAP

PERFORM CLEAN-RESULTS
PERFORM START-TESTSUITE
PERFORM WRITE-TESTCASES
PERFORM WRITE-SYSTEM-ERR
PERFORM END-TESTSUITE
PERFORM RESTORE-RESULTS

/***********************************************************************
DEFINE SUBROUTINE CLEAN-RESULTS
/***********************************************************************
EXAMINE NUTCP.FIXTURE(*) #REPLACE-NUCT(*) REPLACE #REPLACE-XML(*)
EXAMINE NUTCP.TEST(*) #REPLACE-NUCT(*) REPLACE #REPLACE-XML(*)
EXAMINE NUTCP.TEST-MESSAGE(*) #REPLACE-NUCT(*) REPLACE #REPLACE-XML(*)
END-SUBROUTINE
/***********************************************************************

/***********************************************************************
DEFINE SUBROUTINE RESTORE-RESULTS
/***********************************************************************
EXAMINE NUTCP.FIXTURE(*) #REPLACE-XML(*) REPLACE #REPLACE-NUCT(*)
EXAMINE NUTCP.TEST(*) #REPLACE-XML(*) REPLACE #REPLACE-NUCT(*)
EXAMINE NUTCP.TEST-MESSAGE(*) #REPLACE-XML(*) REPLACE #REPLACE-NUCT(*)
END-SUBROUTINE
/***********************************************************************

/***********************************************************************
DEFINE SUBROUTINE START-TESTSUITE
/***********************************************************************
COMPRESS NUTCP.LIBNAME '.' NUTCP.TESTCASENAME INTO #CLASSNAME LEAVING NO
IF P-PREFIX SPECIFIED
  COMPRESS P-PREFIX '.' #CLASSNAME INTO #CLASSNAME LEAVING NO
END-IF

#STARTTIME := NUTCP.STARTTIME
#ENDTIME := NUTCP.ENDTIME
PERFORM CREATE-TIMESTRING

COMPRESS '<?xml version="1.0" encoding="ISO-8859-1"?>' H'0A'
  '<testsuite name="' #CLASSNAME
  '" tests="' NUCRSTAP.NUM-TESTS
  '" failures="' NUCRSTAP.NUM-TESTS-FAILURE
  '" errors="' NUCRSTAP.NUM-TESTS-ERROR
  '" skipped="' NUCRSTAP.NUM-TESTS-SKIPPED
  '" time="' #TIMESTRING
  '">' H'0A' INTO P-XML LEAVING NO

END-SUBROUTINE
/***********************************************************************

/***********************************************************************
DEFINE SUBROUTINE WRITE-TESTCASES
/***********************************************************************
#SIZE-TESTS := *OCCURRENCE(NUTCP.TEST)

FOR #INDEX-TESTS = 1 TO #SIZE-TESTS
  IF NUTCP.TEST-RESULT(#INDEX-TESTS) EQ C-NU-EMPTY
      OR NUTCP.TEST-RESULT(#INDEX-TESTS) EQ C-NU-SETUP-TESTCASE
      OR NUTCP.TEST-RESULT(#INDEX-TESTS) EQ C-NU-TEARDOWN-TESTCASE
    ESCAPE TOP
  END-IF
  PERFORM WRITE-TESTCASE
END-FOR

END-SUBROUTINE
/***********************************************************************

/***********************************************************************
DEFINE SUBROUTINE WRITE-TESTCASE
/***********************************************************************
#STARTTIME := NUTCP.TEST-STARTTIME(#INDEX-TESTS)
#ENDTIME := NUTCP.TEST-ENDTIME(#INDEX-TESTS)
PERFORM CREATE-TIMESTRING

RESET #TESTCASENAME
IF NUTCP.TEST-DATA-PARAM(#INDEX-TESTS) NE ' '
  COMPRESS '(' NUTCP.TEST-DATA-PARAM(#INDEX-TESTS) ')' INTO #TESTCASENAME LEAVING NO
END-IF
COMPRESS NUTCP.TEST(#INDEX-TESTS) #TESTCASENAME INTO #TESTCASENAME

COMPRESS P-XML
  '<testcase classname="' #CLASSNAME
  '" name="' #TESTCASENAME
  '" time="' #TIMESTRING '"'
  INTO P-XML LEAVING NO

DECIDE ON FIRST VALUE OF NUTCP.TEST-RESULT(#INDEX-TESTS)
  VALUE C-NU-ERROR
    COMPRESS P-XML
      '>' H'0A'
      '<error message="' NUTCP.TEST-MESSAGE(#INDEX-TESTS)
      '"></error>' H'0A'
      '</testcase>' H'0A'
      INTO P-XML LEAVING NO
  VALUE C-NU-FAILURE
    COMPRESS P-XML
      '>' H'0A'
      '<failure message="' NUTCP.TEST-MESSAGE(#INDEX-TESTS)
      '"></failure>' H'0A'
      '</testcase>' H'0A'
      INTO P-XML LEAVING NO
  VALUE C-NU-SKIPPED
    COMPRESS P-XML
      '>' H'0A'
      '<skipped />' H'0A'
      '</testcase>' H'0A'
      INTO P-XML LEAVING NO
  NONE
    COMPRESS P-XML
      ' />' H'0A'
      INTO P-XML LEAVING NO
END-DECIDE

END-SUBROUTINE
/***********************************************************************

/***********************************************************************
DEFINE SUBROUTINE WRITE-SYSTEM-ERR
/***********************************************************************

IF NUTCP.TC-RESULT NE C-NU-SUCCESS
    AND NUTCP.TC-MESSAGE NE ' '
  COMPRESS P-XML '<system-err><![CDATA[' NUTCP.TC-MESSAGE ']]></system-err>' H'0A'
    INTO P-XML LEAVING NO
END-IF

END-SUBROUTINE
/***********************************************************************

/***********************************************************************
DEFINE SUBROUTINE END-TESTSUITE
/***********************************************************************

COMPRESS P-XML '</testsuite>' H'0A' INTO P-XML LEAVING NO

END-SUBROUTINE
/***********************************************************************

/***********************************************************************
DEFINE SUBROUTINE CREATE-TIMESTRING
/***********************************************************************
COMPUTE #STARTTIMES = 60 * 60 * #ST-HOURS + 60 * #ST-MINS + #ST-SEC + #ST-MSEC / 10
COMPUTE #ENDTIMES = 60 * 60 * #ET-HOURS + 60 * #ET-MINS + #ET-SEC + #ET-MSEC / 10
#DIFFTIMES := #ENDTIMES - #STARTTIMES
MOVE EDITED #DIFFTIMES (EM=999,999) TO #TIMESTRING
EXAMINE #TIMESTRING FOR ',' REPLACE '.'
END-SUBROUTINE
/***********************************************************************

/***********************************************************************
ON ERROR
  COMPRESS 'Error in program' *PROGRAM '(' *ERROR-LINE '):' *ERROR-NR INTO P-XML
  ESCAPE MODULE
END-ERROR
/***********************************************************************

END-SUBROUTINE
/***********************************************************************

END

