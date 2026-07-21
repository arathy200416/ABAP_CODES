REPORT ZPROJECT_ALV.

INCLUDE ZPROJECT_ALV_TOP.
INCLUDE ZPROJECT_ALV_FORM.

START-OF-SELECTION.

PERFORM GETDATA.
PERFORM FIELDCAT.
PERFORM EVENT.
PERFORM DISPLAY.

*&---------------------------------------------------------------------*
*&  Include           ZPROJECT_ALV_TOP
*&---------------------------------------------------------------------*
TABLES: LFA1, EKKO, EKPO.
TYPE-POOLS: SLIS.

SELECTION-SCREEN: BEGIN OF BLOCK B2 WITH FRAME TITLE TEXT-000.
  SELECT-OPTIONS: A_LIFNR FOR LFA1-LIFNR,
                  A_EBELN FOR EKKO-EBELN.
SELECTION-SCREEN: END OF BLOCK B2.

TYPES: BEGIN OF TY_STR1,
        LIFNR LIKE LFA1-LIFNR,
        NAME1 LIKE LFA1-NAME1,
         EBELN LIKE EKKO-EBELN,
         AEDAT LIKE EKKO-AEDAT,
         EKORG LIKE EKKO-EKORG ,
         WAERS LIKE EKKO-WAERS,
       END OF TY_STR1,

       BEGIN OF TY_STR2,
         EBELP LIKE EKPO-EBELP,
         MATNR LIKE EKPO-MATNR,
         TXZ01 LIKE EKPO-TXZ01,
         MENGE LIKE EKPO-MENGE,
         MEINS LIKE EKPO-MEINS,
         NETPR LIKE EKPO-NETPR,
         WERKS LIKE EKPO-WERKS,
         EBELN LIKE EKPO-EBELN,
         TOTAL LIKE EKPO-NETPR,
         LIGHT TYPE C,
       END OF TY_STR2.

DATA: IT1 TYPE TABLE OF TY_STR1,
      IT2 TYPE TABLE OF TY_STR2,
      WA2 TYPE TY_STR2,

      WAFC1 TYPE SLIS_FIELDCAT_ALV,
      ITFC1 TYPE SLIS_T_FIELDCAT_ALV,
      WAFC2 TYPE SLIS_FIELDCAT_ALV,
      ITFC2 TYPE SLIS_T_FIELDCAT_ALV,

      WAE TYPE SLIS_ALV_EVENT,
      ITE TYPE SLIS_T_EVENT,

      V_EBELN TYPE EBELN .

DATA: IS_LAYOUT TYPE SLIS_LAYOUT_ALV.

*&---------------------------------------------------------------------*
*&  Include           ZPROJECT_ALV_FORM
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  GETDATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM GETDATA .
  SELECT LFA1~LIFNR LFA1~NAME1
         EKKO~EBELN EKKO~AEDAT EKKO~EKORG EKKO~WAERS
    FROM LFA1 INNER JOIN EKKO
    ON LFA1~LIFNR = EKKO~LIFNR
    INTO TABLE IT1
    WHERE LFA1~LIFNR IN A_LIFNR
    AND EKKO~EBELN IN A_EBELN.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  FIELDCAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM FIELDCAT .
  CLEAR WAFC1.
  WAFC1-COL_POS = 1.
  WAFC1-FIELDNAME = 'LIFNR'.
  WAFC1-TABNAME = 'IT1'.
  WAFC1-SELTEXT_M = 'Vendor No'.
  WAFC1-OUTPUTLEN = 15.
  APPEND WAFC1 TO ITFC1.

  CLEAR WAFC1.
  WAFC1-COL_POS = 2.
  WAFC1-FIELDNAME = 'NAME1'.
  WAFC1-TABNAME = 'IT1'.
  WAFC1-SELTEXT_M = 'Vendor Name'.
  WAFC1-OUTPUTLEN = 15.
  APPEND WAFC1 TO ITFC1.

  CLEAR WAFC1.
  WAFC1-COL_POS = 3.
  WAFC1-FIELDNAME = 'EBELN'.
  WAFC1-TABNAME = 'IT1'.
  WAFC1-SELTEXT_M = 'Purchae Order'.
  WAFC1-OUTPUTLEN = 15.
  WAFC1-HOTSPOT = 'X'.
  APPEND WAFC1 TO ITFC1.

  CLEAR WAFC1.
  WAFC1-COL_POS = 4.
  WAFC1-FIELDNAME = 'AEDAT'.
  WAFC1-TABNAME = 'IT1'.
  WAFC1-SELTEXT_M = 'PO Date'.
  WAFC1-OUTPUTLEN = 15.
  APPEND WAFC1 TO ITFC1.

  CLEAR WAFC1.
  WAFC1-COL_POS = 5.
  WAFC1-FIELDNAME = 'EKORG'.
  WAFC1-TABNAME = 'IT1'.
  WAFC1-SELTEXT_M = 'Purch. Org'.
  WAFC1-OUTPUTLEN = 15.
  APPEND WAFC1 TO ITFC1.

  CLEAR WAFC1.
  WAFC1-COL_POS = 6.
  WAFC1-FIELDNAME = 'WAERS'.
  WAFC1-TABNAME = 'IT1'.
  WAFC1-SELTEXT_M = 'Currency'.
  WAFC1-OUTPUTLEN = 15.
  APPEND WAFC1 TO ITFC1.

*  **********************************************************

  CLEAR WAFC2.
  WAFC2-COL_POS = 1.
  WAFC2-FIELDNAME = 'EBELP'.
  WAFC2-TABNAME = 'IT2'.
  WAFC2-SELTEXT_M = 'EBELP'.
  WAFC2-OUTPUTLEN = 15.
  APPEND WAFC2 TO ITFC2.

  CLEAR WAFC2.
  WAFC2-COL_POS = 2.
  WAFC2-FIELDNAME = 'MATNR'.
  WAFC2-TABNAME = 'IT2'.
  WAFC2-SELTEXT_M = 'MATNR'.
  WAFC2-OUTPUTLEN = 15.
  APPEND WAFC2 TO ITFC2.

  CLEAR WAFC2.
  WAFC2-COL_POS = 3.
  WAFC2-FIELDNAME = 'TXZ01'.
  WAFC2-TABNAME = 'IT2'.
  WAFC2-SELTEXT_M = 'TXZ01'.
  WAFC2-OUTPUTLEN = 15.
  APPEND WAFC2 TO ITFC2.

  CLEAR WAFC2.
  WAFC2-COL_POS = 4.
  WAFC2-FIELDNAME = 'MENGE'.
  WAFC2-TABNAME = 'IT2'.
  WAFC2-SELTEXT_M = 'MENGE'.
  WAFC2-OUTPUTLEN = 15.
  APPEND WAFC2 TO ITFC2.

  CLEAR WAFC2.
  WAFC2-COL_POS = 5.
  WAFC2-FIELDNAME = 'MEINS'.
  WAFC2-TABNAME = 'IT2'.
  WAFC2-SELTEXT_M = 'MEINS'.
  WAFC2-OUTPUTLEN = 15.
  APPEND WAFC2 TO ITFC2.

  CLEAR WAFC2.
  WAFC2-COL_POS = 6.
  WAFC2-FIELDNAME = 'NETPR'.
  WAFC2-TABNAME = 'IT2'.
  WAFC2-SELTEXT_M = 'NETPR'.
  WAFC2-OUTPUTLEN = 15.
  APPEND WAFC2 TO ITFC2.

  CLEAR WAFC2.
  WAFC2-COL_POS = 7.
  WAFC2-FIELDNAME = 'WERKS'.
  WAFC2-TABNAME = 'IT2'.
  WAFC2-SELTEXT_M = 'WERKS'.
  WAFC2-OUTPUTLEN = 15.
  APPEND WAFC2 TO ITFC2.

  CLEAR WAFC2.
WAFC2-COL_POS = 8.
WAFC2-FIELDNAME = 'TOTAL'.
WAFC2-TABNAME = 'IT2'.
WAFC2-SELTEXT_M = 'TOTAL AMOUNT'.
WAFC2-OUTPUTLEN = 15.
WAFC2-DO_SUM = 'X'.
APPEND WAFC2 TO ITFC2.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  EVENT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM EVENT .
   CLEAR WAE.
   WAE-NAME = 'USER_COMMAND'.
   WAE-FORM = 'INTERACTIVE'.
   APPEND WAE TO ITE.

   CLEAR WAE.
   WAE-NAME = 'TOP_OF_PAGE'.
   WAE-FORM = 'HEADER'.
   APPEND WAE TO ITE.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  DISPLAY
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM DISPLAY .
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
   I_CALLBACK_PROGRAM               = SY-CPROG
   IT_FIELDCAT                       = ITFC1
   IT_EVENTS                         = ITE
   IS_LAYOUT = IS_LAYOUT
  TABLES
    T_OUTTAB                          = IT1.

ENDFORM.

FORM INTERACTIVE USING UCOMM LIKE SY-UCOMM SEL TYPE SLIS_SELFIELD.
  IF SEL-FIELDNAME = 'EBELN'.
    V_EBELN = SEL-VALUE.
    SELECT EBELP MATNR TXZ01 MENGE MEINS NETPR WERKS EBELN
      FROM EKPO INTO TABLE IT2
      WHERE EBELN = V_EBELN.

    LOOP AT IT2 INTO WA2.
      WA2-TOTAL = WA2-MENGE * WA2-NETPR.
      MODIFY IT2 FROM WA2.
    ENDLOOP.

    LOOP AT IT2 INTO WA2.

  WA2-TOTAL = WA2-MENGE * WA2-NETPR.

  IF WA2-TOTAL >= 200000.
    WA2-LIGHT = '3'. "Green
  ELSEIF WA2-TOTAL >= 100000.
    WA2-LIGHT = '2'. "Yellow
  ELSE.
    WA2-LIGHT = '1'. "Red
  ENDIF.

  MODIFY IT2 FROM WA2.

ENDLOOP.

IS_LAYOUT-LIGHTS_FIELDNAME = 'LIGHT'.

   CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
    I_CALLBACK_PROGRAM               = SY-CPROG
   IT_FIELDCAT                       = ITFC2
   IT_EVENTS                         = ITE
   IS_LAYOUT = IS_LAYOUT
  TABLES
    T_OUTTAB                          = IT2.
ENDIF.


ENDFORM.

FORM HEADER.
  DATA: STR TYPE STRING,
        WAL TYPE SLIS_LISTHEADER,
        ITL TYPE SLIS_T_LISTHEADER.

  CLEAR WAL.
  WAL-TYP = 'H'.
  WAL-INFO = 'VENDOR PURCHASE ANALYSIS REPORT'.
  APPEND WAL TO ITL.

  CLEAR WAL.
  WAL-TYP = 'S'.
  WAL-KEY = 'DATE: '.
  CONCATENATE SY-DATUM+6(2) SY-DATUM+4(2) SY-DATUM+0(4) INTO STR SEPARATED BY '.'.
  WAL-INFO = STR.
  APPEND WAL TO ITL.

  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      IT_LIST_COMMENTARY       = ITL.

ENDFORM.
