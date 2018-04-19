*----------------------------------------------------------------------*
*       CLASS ZCL_SEPA_XML_CREDITTRANSFERINF DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS zcl_sepa_xml_credittransferinf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
    constructor
      IMPORTING
        value(i_pmtid_endtoendid) TYPE string
        value(i_amt_ccy) TYPE string DEFAULT 'EUR'
        value(i_amt_instdamt) TYPE f
        value(i_cdtragt_fininstnid_bic) TYPE string
        value(i_cdtr_nm) TYPE string
        value(i_cdtracct_id_iban) TYPE string
        value(i_rmtinf_ustrd) TYPE string,
    get_endtoendif
      RETURNING value(_pmtid_endtoendid) TYPE string,
    get_ccy
      RETURNING value(_amt_ccy) TYPE string,
    get_instdamt
      RETURNING value(_amt_instdamt) TYPE f,
    get_bic
      RETURNING value(_cdtragz_fininstnid_bic) TYPE string,
    get_cdtr_nm
      RETURNING value(_cdtr_nm) TYPE string,
    get_iban
      RETURNING value(_cdtracct_id_iban) TYPE string,
    get_rmtinf_ustrd
      RETURNING value(_rmtinf_ustrd) TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
          pmtid_endtoendid TYPE string,
          amt_ccy TYPE string,
          amt_instdamt TYPE f,
          cdtragt_fininstnid_bic TYPE string,
          cdtr_nm TYPE string,
          cdtracct_id_iban TYPE string,
          rmtinf_ustrd TYPE string.
ENDCLASS.



CLASS ZCL_SEPA_XML_CREDITTRANSFERINF IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_SEPA_XML_CREDITTRANSFERINF->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PMTID_ENDTOENDID             TYPE        STRING
* | [--->] I_AMT_CCY                      TYPE        STRING (default ='EUR')
* | [--->] I_AMT_INSTDAMT                 TYPE        F
* | [--->] I_CDTRAGT_FININSTNID_BIC       TYPE        STRING
* | [--->] I_CDTR_NM                      TYPE        STRING
* | [--->] I_CDTRACCT_ID_IBAN             TYPE        STRING
* | [--->] I_RMTINF_USTRD                 TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD constructor.
    me->pmtid_endtoendid = i_pmtid_endtoendid.
    me->amt_ccy = i_amt_ccy.
    me->amt_instdamt = i_amt_instdamt.
    me->cdtragt_fininstnid_bic = i_cdtragt_fininstnid_bic.
    me->cdtr_nm = i_cdtr_nm.
    me->cdtracct_id_iban = i_cdtracct_id_iban.
    me->rmtinf_ustrd = i_rmtinf_ustrd.
  ENDMETHOD.                    "CONSTRUCTOR


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_SEPA_XML_CREDITTRANSFERINF->GET_BIC
* +-------------------------------------------------------------------------------------------------+
* | [<-()] _CDTRAGZ_FININSTNID_BIC        TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_bic.
    _cdtragz_fininstnid_bic = me->cdtragt_fininstnid_bic.
  ENDMETHOD.                    "get_bic


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_SEPA_XML_CREDITTRANSFERINF->GET_CCY
* +-------------------------------------------------------------------------------------------------+
* | [<-()] _AMT_CCY                       TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_ccy.
    _amt_ccy = me->amt_ccy.
  ENDMETHOD.                    "get_ccy


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_SEPA_XML_CREDITTRANSFERINF->GET_CDTR_NM
* +-------------------------------------------------------------------------------------------------+
* | [<-()] _CDTR_NM                       TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_cdtr_nm.
    _cdtr_nm = me->cdtr_nm.
  ENDMETHOD.                    "get_cdtr_nm


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_SEPA_XML_CREDITTRANSFERINF->GET_ENDTOENDIF
* +-------------------------------------------------------------------------------------------------+
* | [<-()] _PMTID_ENDTOENDID              TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_endtoendif.
    _pmtid_endtoendid = me->pmtid_endtoendid.
  ENDMETHOD.                    "get_endtoendif


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_SEPA_XML_CREDITTRANSFERINF->GET_IBAN
* +-------------------------------------------------------------------------------------------------+
* | [<-()] _CDTRACCT_ID_IBAN              TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_iban.
    _cdtracct_id_iban = me->cdtracct_id_iban.
  ENDMETHOD.                    "get_iban


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_SEPA_XML_CREDITTRANSFERINF->GET_INSTDAMT
* +-------------------------------------------------------------------------------------------------+
* | [<-()] _AMT_INSTDAMT                  TYPE        F
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_instdamt.
    _amt_instdamt = me->amt_instdamt.
  ENDMETHOD.                    "get_instdamt


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_SEPA_XML_CREDITTRANSFERINF->GET_RMTINF_USTRD
* +-------------------------------------------------------------------------------------------------+
* | [<-()] _RMTINF_USTRD                  TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_rmtinf_ustrd.
    _rmtinf_ustrd = me->rmtinf_ustrd.
  ENDMETHOD.                    "get_rmtinf_ustrd
ENDCLASS.
