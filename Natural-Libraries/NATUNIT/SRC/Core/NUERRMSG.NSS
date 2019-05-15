* >Natural Source Header 000000
* :Mode S
* :CP
* <Natural Source Header
/***********************************************************************

/*  File: NUERRMSG

/*  Returns the short text for the current Natural error.

/*  Returns:
/*    P-ERROR-MSG - The error message.

/***********************************************************************
DEFINE DATA

PARAMETER
01 P-ERROR-MSG (A) DYNAMIC

LOCAL
01 PARM-AREA
  02 TYPE (A01) /* 'U' or 'N' ( User or NATURAL messages )
  02 APPLICATION (A08) /* Must not be blank for type = 'U'
  02 ERROR-NUMBER (N04) /* 1 thru 9999
  02 LANG-NUMB (A01) /* Language number (similar to *LANGUAGE)
  02 REDEFINE LANG-NUMB
    03 LANG-NUMB-I (I1)
  02 RESPONSE (N04) /* Error during execution of USR0020N

01 RETURN-AREA /* Contains the message texts
  02 S-FOUND (L) INIT <FALSE> /* TRUE = 'Short text found'
  02 L-FOUND (L) INIT <FALSE> /* TRUE = 'Long text found'
  02 SHORT-TEXT (A65) INIT <'<<< Short text not found >>>'>
  02 LONG-TEXT (A78/01:20) INIT ALL <'<<< Long text not found >>>'>

END-DEFINE

/***********************************************************************
DEFINE SUBROUTINE NU-GET-CURRENT-ERROR-MESSAGE
/***********************************************************************

MOVE 'N' TO TYPE /* Natural messages
MOVE 'NATUNIT' TO APPLICATION /* Current application
MOVE *ERROR TO ERROR-NUMBER /* Recent error code
MOVE 1 TO LANG-NUMB-I /* Current language code

/* Read any error message from FNAT or FUSER
CALLNAT 'USR0020N' PARM-AREA RETURN-AREA

IF RESPONSE EQ 0
  P-ERROR-MSG := SHORT-TEXT
END-IF

END-SUBROUTINE
/***********************************************************************

END

