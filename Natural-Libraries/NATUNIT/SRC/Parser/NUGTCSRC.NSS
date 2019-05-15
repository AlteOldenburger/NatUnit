* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
/***********************************************************************

/* File: NUGTCSRC

/* Returns the source code for the given TestCase.

/* Parameters:
/* NUSRCP.LIBRARYNAME - The library.
/* NUSRCP.MODULENAME - The TestCase's module name.

/* Returns:
/* NUSRCP.RC - The return code.
/* NUSRCP.MESSAGE - The error message if something went wrong.
/* NUSRCP.LINES - The TestCase's source code.

/***********************************************************************

DEFINE DATA

PARAMETER USING NUSRCP

LOCAL USING USR-MSG /* Data for message exchange
LOCAL USING USR-FLD /* Description of the field in error

LOCAL

01 #C-NR-OF-LINES-TO-READ (I4) CONST <100>
01 #C-LINE-LENGTH-TO-READ (I4) CONST <150>

01 #PROGRAM-PATH (A) DYNAMIC
01 #LINE-WITH-NUMBER (A1004)
01 REDEFINE #LINE-WITH-NUMBER
  02 #LINE-NUMBER (A4)
  02 #LINE (A1000)
01 #LINE-COUNTER (N6)

01 #INDEX (I4)

01 #P-FUSER-DBID (N8)
01 #P-FUSER-FNR (N8)

01 USR2013L
  02 #OUTPUTS
    03 #FILENAME (A12/1:50)
    03 #DBID (P5/1:50)
    03 #FNR (P5/1:50)
    03 #DBNAME (A11/1:50)
    03 #AMOUNT (P4)

01 USR6006L
  02 INPUTS
    03 SYSF-DBID (I4)
    03 SYSF-FNR (I4)
  02 OUTPUTS
    03 SYSF-PATH (A253)
    03 RESPONSE-CODE (I4)
    03 INFOTEXT (A65)
  02 EXTENSIONS (A1/1:1)

01 USR1057L
  02 OBJECT-KEY
    03 LIBRARY (A8)
    03 OBJECT-NAME (A32)
    03 OBJECT-TYPE (A2)
  02 INPUTS
    03 OPT-ACCESS (A1)
    03 OPT-UNUSED-1 (L)
    03 OPT-UNUSED-2 (A1)
    03 OPT-LINE-NUM (A1)
    03 OPT-UNUSED-3 (L)
    03 OPT-REDEF-DIR (L)
    03 OPT-UNUSED-4 (A1)
    03 OPT-AMOUNT (I2)
    03 OPT-LINESIZE (I2)
  02 INPUT-OUTPUTS
    03 INT-HANDLE (I4)
    03 NEXT-SEQ (I4)
    03 NEXT-NUM (I2)
  02 OUTPUTS
    03 RETURNED (I2)
    03 SRC-NUM (I2/1:#C-NR-OF-LINES-TO-READ)
    03 SRC-TEXT (A1/1:#C-NR-OF-LINES-TO-READ,1:#C-LINE-LENGTH-TO-READ)
    03 REDEFINE SRC-TEXT
      04 SRC-GROUP (1:#C-NR-OF-LINES-TO-READ)
        05 SRC-LINE (A150) /* #C-LINE-LENGTH-TO-READ
    03 SRC-SEQ (I4/1:#C-NR-OF-LINES-TO-READ)
    03 SRC-LONG (A1/1:#C-NR-OF-LINES-TO-READ)
01 USR1057N
  02 VERSION (I1) INIT <4>
  02 V1-NSC-CKECK (A1)
  02 V2-DBID (N5)
  02 V2-FNR (N4)
  02 V2-PSW (A8)
  02 V2-CIP (N8)
  02 V2-SYSFILE (A1)
  02 V3-EMPTY-BLANK (A1) /* 'Y' = return empty lines on mainframe
  02 V4-FSEC-DBID (N5)
  02 V4-FSEC-FNR (N5)
  02 V4-FSEC-PSW (A8)
  02 V4-FSEC-CIP (N8)
01 REDEFINE USR1057N
  02 EXTENDED-PARMS
    03 EXTENDED-DATA (A1/1:55)

01 #L (I4)
01 #INPUT-OK (L)
01 #NR-OF-LINES (I4)

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE NU-GET-TESTCASE-SOURCE
/***********************************************************************

/* this should work on any platform
PERFORM READ-SOURCE-WITH-USER-EXIT

/* this will only work on Linux
/* PERFORM READ-SOURCE-FROM-FILE-SYSTEM

/***********************************************************************
DEFINE SUBROUTINE READ-SOURCE-WITH-USER-EXIT
/***********************************************************************
RESET NUSRCP.RC NUSRCP.MESSAGE

LIBRARY := NUSRCP.LIBRARYNAME
OBJECT-NAME := NUSRCP.MODULENAME
OPT-LINE-NUM := 'Y'
OPT-AMOUNT := #C-NR-OF-LINES-TO-READ
OPT-LINESIZE := #C-LINE-LENGTH-TO-READ
OPT-ACCESS := 'O'

REPEAT
  CALLNAT 'USR1057N' USR1057L USR1057N.EXTENDED-PARMS NAD-MSG NAD-FLD
  IF OPT-ACCESS = 'O' AND MSG-NR NE 0
    NUSRCP.RC := MSG-NR
    NUSRCP.MESSAGE := MSG
    IF MSG-NR EQ 1006 /* :1:does not exist
      COMPRESS '<' NUSRCP.LIBRARYNAME '.' NUSRCP.MODULENAME '>' INTO NUSRCP.MESSAGE LEAVING NO
      COMPRESS 'TestCase not found:' NUSRCP.MESSAGE INTO NUSRCP.MESSAGE
    END-IF
    ESCAPE ROUTINE
  END-IF
  OPT-ACCESS := 'R'
  FOR #L 1 RETURNED
    #NR-OF-LINES := SRC-NUM(#L)
    IF #NR-OF-LINES GT 0
      EXPAND ARRAY NUSRCP.LINES TO (1:#NR-OF-LINES)
      COMPRESS NUSRCP.LINES(#NR-OF-LINES) SRC-LINE(#L)
        INTO NUSRCP.LINES(#NR-OF-LINES) LEAVING NO
    END-IF
  END-FOR
  IF MSG-NR NE 0
    IF NOT #INPUT-OK AND RETURNED = 0
      ESCAPE BOTTOM
    ELSE
      IF NAD-MSG.MSG-NR NE 100 /* End of data reached
        NUSRCP.RC := MSG-NR
        NUSRCP.MESSAGE := MSG
      END-IF
      ESCAPE ROUTINE
    END-IF
  END-IF
  #INPUT-OK := TRUE
END-REPEAT

OPT-ACCESS := 'C'
CALLNAT 'USR1057N' USR1057L USR1057N.EXTENDED-PARMS NAD-MSG NAD-FLD

END-SUBROUTINE
/***********************************************************************

/***********************************************************************
DEFINE SUBROUTINE READ-SOURCE-FROM-FILE-SYSTEM
/***********************************************************************

PERFORM GET-FUSER-AND-DBID
PERFORM GET-FUSER-PATH
PERFORM CREATE-TESTCASE-FULL-PATH
PERFORM READ-TESTCASE-SOURCE

END-SUBROUTINE
/***********************************************************************

/***********************************************************************
DEFINE SUBROUTINE GET-FUSER-AND-DBID
/***********************************************************************

RESET #P-FUSER-DBID #P-FUSER-FNR

CALLNAT 'USR2013N' USR2013L

FOR #INDEX = 1 TO #AMOUNT
  IF #FILENAME(#INDEX) EQ 'FUSER'
    #P-FUSER-DBID := #DBID(#INDEX)
    #P-FUSER-FNR := #FNR(#INDEX)
  END-IF
END-FOR

END-SUBROUTINE
/***********************************************************************

/***********************************************************************
DEFINE SUBROUTINE GET-FUSER-PATH
/***********************************************************************

RESET INFOTEXT RESPONSE-CODE
SYSF-DBID := #P-FUSER-DBID
SYSF-FNR := #P-FUSER-FNR

CALLNAT 'USR6006N' USR6006L

END-SUBROUTINE
/***********************************************************************

/***********************************************************************
DEFINE SUBROUTINE CREATE-TESTCASE-FULL-PATH
/***********************************************************************

RESET #PROGRAM-PATH

IF RESPONSE-CODE = 0
  COMPRESS SYSF-PATH '/' LIBRARYNAME '/SRC/' MODULENAME '.NSN' INTO #PROGRAM-PATH LEAVING NO SPACE
END-IF

END-SUBROUTINE
/***********************************************************************

/***********************************************************************
DEFINE SUBROUTINE READ-TESTCASE-SOURCE
/***********************************************************************

REDUCE ARRAY LINES TO 0

DEFINE WORK FILE 25 #PROGRAM-PATH TYPE 'ASCII'
READ WORK 25 #LINE-WITH-NUMBER

  ADD 1 TO #LINE-COUNTER
  EXPAND ARRAY LINES TO (1:#LINE-COUNTER)
  IF #LINE-NUMBER IS (N4)
    COMPRESS #LINE INTO LINES(#LINE-COUNTER)
  ELSE
    COMPRESS #LINE-WITH-NUMBER INTO LINES(#LINE-COUNTER)
  END-IF

END-WORK
CLOSE WORK 25

END-SUBROUTINE
/***********************************************************************

ON ERROR
  NUSRCP.RC := *ERROR-NR
  COMPRESS 'Natural error' *ERROR-NR 'in module' *PROGRAM INTO NUSRCP.MESSAGE
END-ERROR

END-SUBROUTINE
/***********************************************************************

END

