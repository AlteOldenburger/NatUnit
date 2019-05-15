* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
/***********************************************************************

/* File: NUGRESRC

/* Returns the source of a Natural resource.

/* Parameters:
/* NURESP.LIBRARYNAME - The library.
/* NURESP.MODULENAME - The resource's name.

/* Returns:
/* NURESP.RC - The return code.
/* NURESP.MESSAGE - The error message if something went wrong.
/* NURESP.LINES - The resource's contents.

/***********************************************************************

DEFINE DATA

PARAMETER USING NURESP

LOCAL USING USR-MSG /* Data for message exchange
LOCAL USING USR-FLD /* Description of the field in error

LOCAL

01 USR4208L
  02 RESOURCE-FUNCTION (A1) /* 'R'ead, 'W'rite
  02 OBJECT-KEY
    03 LIBRARY-NAME (A8)
    03 RESOURCE-NAME (A250)
    03 OBJECT-NAME (A8) /* Mainframe only
  02 OBJECT-LOCATION
    03 LIBRARY-DBID (N5)
    03 LIBRARY-FNR (N5)
    03 LIBRARY-PASSWORD (A8)
    03 LIBRARY-CIPHER (N8)
  02 WRITE-OPTIONS
    03 OPTION-REPLACE (A1)
  02 INPUT-OUTPUTS
    03 RESOURCE-DATA (A) DYNAMIC
    03 RESOURCE-DIRECTORY-DATA (A389)
01 USR4208N
  02 VERSION (I1) INIT <1>
  02 V1-FSEC-DBID (N05) /* Fsec-dbid
  02 V1-FSEC-FNR (N05) /* Fsec-fnr
  02 V1-FSEC-PSW (A08) /* Fsec password
  02 V1-FSEC-CIP (N08) /* Fsec cip
01 REDEFINE USR4208N
  02 EXTENDED-PARMS
    03 EXTENDED-DATA (A1/1:27)

01 #NR-OF-LINES (I4)
01 #I-LINE-BREAK (I4)
01 #LENGTH (I4)
01 #REST (I4)

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE NU-GET-RESOURCE
/***********************************************************************

RESET NURESP.RC NURESP.MESSAGE

LIBRARY-NAME := NURESP.LIBRARYNAME
RESOURCE-NAME := NURESP.RESOURCENAME
RESOURCE-FUNCTION := 'R'

CALLNAT 'USR4208N' USR4208L USR4208N.EXTENDED-DATA(*) NAD-MSG NAD-FLD
IF MSG-NR <> 0
  NURESP.RC := MSG-NR
  NURESP.MESSAGE := MSG
ELSE
  RESET #NR-OF-LINES
  EXAMINE RESOURCE-DATA FOR H'0D' DELETE
  REPEAT
    IF RESOURCE-DATA EQ ' '
      ESCAPE BOTTOM
    END-IF
    EXAMINE RESOURCE-DATA FOR H'0A' GIVING POSITION IN #I-LINE-BREAK
    ADD 1 TO #NR-OF-LINES
    EXPAND ARRAY NURESP.LINES TO (1:#NR-OF-LINES)
    #LENGTH := *LENGTH(RESOURCE-DATA)
    IF #I-LINE-BREAK EQ 0
        OR #I-LINE-BREAK EQ #LENGTH
      NURESP.LINES(#NR-OF-LINES) := RESOURCE-DATA
      RESET RESOURCE-DATA
    ELSE
      #REST := #LENGTH - #I-LINE-BREAK
      NURESP.LINES(#NR-OF-LINES) := SUBSTRING(RESOURCE-DATA, 1, #I-LINE-BREAK)
      ADD 1 TO #I-LINE-BREAK
      RESOURCE-DATA := SUBSTRING(RESOURCE-DATA, #I-LINE-BREAK, #REST)
    END-IF
    EXAMINE NURESP.LINES(#NR-OF-LINES) FOR H'0A' DELETE
  END-REPEAT
END-IF

ON ERROR
  NURESP.RC := *ERROR-NR
  COMPRESS 'Natural error' *ERROR-NR 'in module' *PROGRAM INTO NURESP.MESSAGE
END-ERROR

END-SUBROUTINE
/***********************************************************************

END

