* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
/***********************************************************************

/*  File: NUPREFIX

/*  Generates a prefix for TestCase names in the XML output. By default, the
/*  UDB (Adabas database ID) will be used. Can be customized by providing a
/*  subprogram NUPREFIC.

/*  Returns:
/*    P-PREFIX - The prefix for TestCases.

/***********************************************************************
DEFINE DATA

PARAMETER

01 P-PREFIX (A) DYNAMIC

LOCAL

01 USR1040L
  02 #INPUTS
    03 #FUNCTION (A1)
  02 #INPUT-OUTPUTS
    03 #UDB-PARM (N5)
  02 #OUTPUTS
    03 #RESPONSE (I4)

END-DEFINE

DEFINE SUBROUTINE NU-CREATE-PREFIX

CALLNAT 'NUPREFIC' P-PREFIX

ON ERROR
  COMPRESS 'Prefix could not be generated. See' *PROGRAM 'for details.'
    INTO P-PREFIX
  IF *ERROR-NR EQ 82
    #FUNCTION := 'G'
    CALLNAT 'USR1040N' USR1040L
    COMPRESS NUMERIC 'UDB' #UDB-PARM INTO P-PREFIX LEAVING NO
  END-IF
  ESCAPE MODULE
END-ERROR

END-SUBROUTINE

END
