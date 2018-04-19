*----------------------------------------------------------------------*
*       CLASS ZCL_SEPA_XML_CCT DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS zcl_sepa_xml_cct DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        value(i_msgid) TYPE string
        value(i_initgpty_nm) TYPE string
        value(i_pmtinfid) TYPE string
        value(i_pmtmtd) TYPE string DEFAULT 'TRF'
        value(i_btchbookg) TYPE string DEFAULT 'false'
        value(i_pmttpinf_instrprty) TYPE string DEFAULT 'NORM'
        value(i_svclvl_cd) TYPE string DEFAULT 'SEPA'
        value(i_reqdexctndt) TYPE dats
        value(i_dbtr_nm) TYPE string
        value(i_dbtracct_id_iban) TYPE string
        value(i_dbtragt_fininstnid_bic) TYPE string
        value(i_chrgbr) TYPE string DEFAULT 'SLEV' .
    METHODS add_cdttrftxinf
      IMPORTING
        !i_txinf TYPE REF TO zcl_sepa_xml_credittransferinf .
    METHODS create
      IMPORTING
        value(i_filename) TYPE string OPTIONAL
        value(i_path) TYPE string OPTIONAL
        value(i_display) TYPE c DEFAULT abap_true
        value(i_download) TYPE c DEFAULT abap_false
        value(i_save_appl) TYPE c DEFAULT abap_false.
  PROTECTED SECTION.

  PRIVATE SECTION.

    CONSTANTS: con_xmlns TYPE string VALUE 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03',
               con_xmlns_xsi TYPE string VALUE 'http://www.w3.org/2001/XMLSchema-instance',
               con_xsi_schemelocation TYPE string VALUE 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03 pain.001.001.03.xsd',
               con_encoding TYPE string VALUE 'UTF-8'.

    DATA: msgid TYPE string,
          initgpty_nm TYPE string,
          pmtinfid TYPE string,
          pmtmtd TYPE string,
          btchbookg TYPE string,
          pmttpinf_instrprty TYPE string,
          svclvl_cd TYPE string,
          reqdexctndt TYPE dats,
          dbtr_nm TYPE string,
          dbtracct_id_iban TYPE string,
          dbtragt_fininstnid_bic TYPE string,
          chrgbr TYPE string,
          nboftxs TYPE i,
          ctrlsum TYPE f,
          tab_txinf TYPE STANDARD TABLE OF REF TO zcl_sepa_xml_credittransferinf.
ENDCLASS.



CLASS ZCL_SEPA_XML_CCT IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_SEPA_XML_CCT->ADD_CDTTRFTXINF
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_TXINF                        TYPE REF TO ZCL_SEPA_XML_CREDITTRANSFERINF
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD add_cdttrftxinf.
    IF i_txinf IS BOUND.
      APPEND i_txinf TO me->tab_txinf.
    ENDIF.
  ENDMETHOD.                    "add_CDTTRFTXINF


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_SEPA_XML_CCT->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_MSGID                        TYPE        STRING
* | [--->] I_INITGPTY_NM                  TYPE        STRING
* | [--->] I_PMTINFID                     TYPE        STRING
* | [--->] I_PMTMTD                       TYPE        STRING (default ='TRF')
* | [--->] I_BTCHBOOKG                    TYPE        STRING (default ='false')
* | [--->] I_PMTTPINF_INSTRPRTY           TYPE        STRING (default ='NORM')
* | [--->] I_SVCLVL_CD                    TYPE        STRING (default ='SEPA')
* | [--->] I_REQDEXCTNDT                  TYPE        DATS
* | [--->] I_DBTR_NM                      TYPE        STRING
* | [--->] I_DBTRACCT_ID_IBAN             TYPE        STRING
* | [--->] I_DBTRAGT_FININSTNID_BIC       TYPE        STRING
* | [--->] I_CHRGBR                       TYPE        STRING (default ='SLEV')
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD constructor.
    me->msgid = i_msgid.
    me->initgpty_nm = i_initgpty_nm.
    me->pmtinfid = i_pmtinfid.
    me->pmtmtd = i_pmtmtd.
    me->btchbookg = i_btchbookg.
    me->pmttpinf_instrprty = i_pmttpinf_instrprty.
    me->svclvl_cd = i_svclvl_cd.
    me->reqdexctndt = i_reqdexctndt.
    me->dbtr_nm = i_dbtr_nm.
    me->dbtracct_id_iban = i_dbtracct_id_iban.
    me->dbtragt_fininstnid_bic = i_dbtragt_fininstnid_bic.
    me->chrgbr = i_chrgbr.
    me->nboftxs = 0.
    me->ctrlsum = 0.
  ENDMETHOD.                    "CONSTRUCTOR


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_SEPA_XML_CCT->CREATE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_FILENAME                     TYPE        STRING(optional)
* | [--->] I_PATH                         TYPE        STRING(optional)
* | [--->] I_DISPLAY                      TYPE        C (default =ABAP_TRUE)
* | [--->] I_DOWNLOAD                     TYPE        C (default =ABAP_FALSE)
* | [--->] I_SAVE_APPL                    TYPE        C (default =ABAP_FALSE)
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD create.
    IF tab_txinf IS INITIAL.
      MESSAGE 'Keine Zahlungsinformationen für Überweisungsträger vorhanden.' TYPE 'S' DISPLAY LIKE 'E'.
      EXIT.
    ENDIF.

    IF i_download = abap_true OR i_save_appl = abap_true.
      IF i_path IS INITIAL OR i_filename IS INITIAL.
        MESSAGE 'Bitte Ausgabepfad und Dateinamen angeben.' TYPE 'S' DISPLAY LIKE 'E'.
        EXIT.
      ENDIF.
    ENDIF.

    DATA: lo_ixml TYPE REF TO if_ixml,
          lo_document TYPE REF TO if_ixml_document,
          lo_encoding TYPE REF TO if_ixml_encoding,
          lo_root TYPE REF TO if_ixml_element,
          lo_cstmrcdttrfinitn TYPE REF TO if_ixml_element,
          lo_grphdr TYPE REF TO if_ixml_element,
          lo_msgid TYPE REF TO if_ixml_element,
          lo_credttm TYPE REF TO if_ixml_element,
          lo_nboftxs TYPE REF TO if_ixml_element,
          lo_ctrlsum TYPE REF TO if_ixml_element,
          lo_initgpty TYPE REF TO if_ixml_element,
          lo_initgpty_nm TYPE REF TO if_ixml_element,
          lo_pmtinf TYPE REF TO if_ixml_element,
          lo_pmtinfid TYPE REF TO if_ixml_element,
          lo_pmtmtd TYPE REF TO if_ixml_element,
          lo_btchbookg TYPE REF TO if_ixml_element,
          lo_pmtinf_nboftxs TYPE REF TO if_ixml_element,
          lo_pmtinf_ctrlsum TYPE REF TO if_ixml_element,
          lo_pmttpinf TYPE REF TO if_ixml_element,
          lo_instrprty TYPE REF TO if_ixml_element,
          lo_svclvl TYPE REF TO if_ixml_element,
          lo_svclvl_cd TYPE REF TO if_ixml_element,
          lo_reqdexctndt TYPE REF TO  if_ixml_element,
          lo_dbtr TYPE REF TO if_ixml_element,
          lo_dbtr_nm TYPE REF TO if_ixml_element,
          lo_dbtracct TYPE REF TO if_ixml_element,
          lo_dbtracct_id TYPE REF TO if_ixml_element,
          lo_dbtracct_id_iban TYPE REF TO if_ixml_element,
          lo_dbtragt TYPE REF TO if_ixml_element,
          lo_fininstnid TYPE REF TO if_ixml_element,
          lo_bic TYPE REF TO if_ixml_element,
          lo_chrgbr TYPE REF TO if_ixml_element.

*-->XML Timestamp erzeugen
    DATA: lv_timestamp TYPE rs_timestmp,
          lv_timestamp_string TYPE string,
          lv_xml_date TYPE string,
          lv_xml_time TYPE string.

    GET TIME STAMP FIELD lv_timestamp.

    CALL FUNCTION 'RRBA_CONVERT_TIMESTAMP_TO_STR'
      EXPORTING
        i_timestamp = lv_timestamp
      IMPORTING
        e_output    = lv_timestamp_string.

    CONCATENATE lv_timestamp_string+6(4)
                lv_timestamp_string+3(2)
                lv_timestamp_string+0(2)
      INTO lv_xml_date
      SEPARATED BY '-'.

    CONCATENATE lv_xml_date
                'T'
      INTO lv_xml_date.

    CONCATENATE lv_timestamp_string+11(2)
                lv_timestamp_string+14(2)
                lv_timestamp_string+17(2)
      INTO lv_xml_time
      SEPARATED BY ':'.

    CLEAR lv_timestamp_string.
    CONCATENATE lv_xml_date
                lv_xml_time
      INTO lv_timestamp_string.

*-->IXML Library laden
    lo_ixml = cl_ixml=>create( ).

*-->XML Dokument erstellen
    lo_document = lo_ixml->create_document( ).

*-->Encoding erstellen und zuweisen
    lo_encoding = lo_ixml->create_encoding( character_set = con_encoding
                                            byte_order = 0 ).
    lo_document->set_encoding( encoding = lo_encoding ).

*-->Root Element des Dokuments erzeugen
    lo_root = lo_document->create_simple_element( name = 'Document'
                                                  parent = lo_document ).

*-->Attribute setzen
    lo_root->set_attribute_ns( name = 'xmlns'
                               value = con_xmlns ).
    lo_root->set_attribute_ns( name = 'xsi'
                               prefix = 'xmlns'
                               value = con_xmlns_xsi ).
    lo_root->set_attribute_ns( name = 'schemaLocation'
                               prefix = 'xsi'
                               value = con_xsi_schemelocation ).

*-->Root Element an Dokument anhängen
    lo_document->append_child( lo_root ).

*-->Element <CstmrCdtTrfInitn> erstellen und an das Root-Element anhängen
    lo_cstmrcdttrfinitn = lo_document->create_simple_element( name = 'CstmrCdtTrfInitn'
                                                              parent = lo_root ).
*-->Element <GrpHdr> erstellen und anhängen
    lo_grphdr = lo_document->create_simple_element( name = 'GrpHdr'
                                                    parent = lo_cstmrcdttrfinitn ).

*-->Element <MsgId> erstellen und anhängen
    lo_msgid = lo_document->create_simple_element( name = 'MsgId'
                                                   parent = lo_grphdr
                                                   value = me->msgid ).

*-->Element <CreDtTm> erstellen und anhängen
    lo_credttm = lo_document->create_simple_element( name = 'CreDtTm'
                                                     parent = lo_grphdr
                                                     value = lv_timestamp_string ).

*-->Element <NbOfTxs> erstellen und anhängen
    lo_nboftxs = lo_document->create_simple_element( name = 'NbOfTxs'
                                                     parent = lo_grphdr ).

*-->Element <CtrlSum> erstellen und anhängen
    lo_ctrlsum = lo_document->create_simple_element( name = 'CtrlSum'
                                                     parent = lo_grphdr ).

*-->Element <InitgPty> erstellen und anhängen
    lo_initgpty = lo_document->create_simple_element( name = 'InitgPty'
                                                      parent = lo_grphdr ).

*-->Element <Nm> erstellen und anhängen
    lo_initgpty_nm = lo_document->create_simple_element( name = 'Nm'
                                                         parent = lo_initgpty
                                                         value = me->initgpty_nm ).

*-->Element <PmtInf> erstellen und anhängen
    lo_pmtinf = lo_document->create_simple_element( name = 'PmtInf'
                                                    parent = lo_cstmrcdttrfinitn ).

*-->Element <PmtInfId> erstellen und anhängen
    lo_pmtinfid = lo_document->create_simple_element( name = 'PmtInfId'
                                                    parent = lo_pmtinf
                                                    value = me->pmtinfid ).

*-->Element <PmtMtd> erstellen und anhängen
    lo_pmtmtd = lo_document->create_simple_element( name = 'PmtMtd'
                                                    parent = lo_pmtinf
                                                    value = me->pmtmtd ).

*-->Element <BtchBookg> erstellen und anhängen
    lo_btchbookg = lo_document->create_simple_element( name = 'BtchBookg'
                                                       parent = lo_pmtinf
                                                       value = me->btchbookg ).
*-->Element <NbOfTxs> erstellen und anhängen
    lo_pmtinf_nboftxs = lo_document->create_simple_element( name = 'NbOfTxs'
                                                            parent = lo_pmtinf ).

*-->Element <CtrlSum> erstellen und anhängen
    lo_pmtinf_ctrlsum = lo_document->create_simple_element( name = 'CtrlSum'
                                                            parent = lo_pmtinf ).

*-->Element <PmtTpInf> erstellen und anhängen
    lo_pmttpinf = lo_document->create_simple_element( name = 'PmtTpInf'
                                                      parent = lo_pmtinf ).

*-->Element <InstrPrty> erstellen und anhängen
    lo_instrprty = lo_document->create_simple_element( name = 'InstrPrty'
                                                       parent = lo_pmttpinf
                                                       value = me->pmttpinf_instrprty ).

*-->Element <SvcLvl> erstellen und anhängen
    lo_svclvl = lo_document->create_simple_element( name = 'SvcLvl'
                                                    parent = lo_pmttpinf ).

*-->Element <Cd> erstellen und anhängen
    lo_svclvl_cd = lo_document->create_simple_element( name = 'Cd'
                                                       parent = lo_svclvl
                                                       value = me->svclvl_cd ).
*-->Datum formatieren
    DATA lv_date TYPE string.
    CONCATENATE me->reqdexctndt+0(4)
                me->reqdexctndt+4(2)
                me->reqdexctndt+6(2)
        INTO lv_date
        SEPARATED BY '-'.

*-->Element <ReqdExctnDt> erstellen und anhängen
    lo_reqdexctndt = lo_document->create_simple_element( name = 'ReqdExctnDt'
                                                         parent = lo_pmtinf
                                                         value = lv_date ).

*-->Element <Dbtr> erstellen und anhängen
    lo_dbtr = lo_document->create_simple_element( name = 'Dbtr'
                                                  parent = lo_pmtinf ).

*-->Element <Nm> erstellen und anhängen
    lo_dbtr_nm = lo_document->create_simple_element( name = 'Nm'
                                                     parent = lo_dbtr
                                                     value = me->dbtr_nm ).

*-->Element <DbtrAcct> erstellen und anhängen
    lo_dbtracct = lo_document->create_simple_element( name = 'DbtrAcct'
                                                      parent = lo_pmtinf ).

*-->Element <Id> erstellen und anhängen
    lo_dbtracct_id = lo_document->create_simple_element( name = 'Id'
                                                         parent = lo_dbtracct ).

*-->Element <IBAN> erstellen und anhängen
    lo_dbtracct_id_iban = lo_document->create_simple_element( name = 'IBAN'
                                                              parent = lo_dbtracct_id
                                                              value = me->dbtracct_id_iban ).

*-->Element <DbtrAgt> erstellen und anhängen
    lo_dbtragt = lo_document->create_simple_element( name = 'DbtrAgt'
                                                     parent = lo_pmtinf ).

*-->Element <FinInstnId> erstellen und anhängen
    lo_fininstnid = lo_document->create_simple_element( name = 'FinInstnId'
                                                        parent = lo_dbtragt ).

*-->Element <BIC> erstellen und anhängen
    lo_bic = lo_document->create_simple_element( name = 'BIC'
                                                 parent = lo_fininstnid
                                                 value = me->dbtragt_fininstnid_bic ).

*-->Element <ChrgBr> erstellen und anhängen
    lo_chrgbr = lo_document->create_simple_element( name = 'ChrgBr'
                                                    parent = lo_pmtinf
                                                    value = me->chrgbr ).

*-->XML-Elemente für eine Transaktionsinformation
    DATA: lo_cdttrftxinf TYPE REF TO if_ixml_element,
          lo_pmtid TYPE REF TO if_ixml_element,
          lo_pmtid_endtoendid TYPE REF TO if_ixml_element,
          lo_amt TYPE REF TO if_ixml_element,
          lo_amt_instdamt TYPE REF TO if_ixml_element,
          lo_cdtragt TYPE REF TO if_ixml_element,
          lo_cdtragt_fininstnid TYPE REF TO if_ixml_element,
          lo_cdtragt_fininstnid_bic TYPE REF TO if_ixml_element,
          lo_cdtr TYPE REF TO if_ixml_element,
          lo_cdtr_nm TYPE REF TO if_ixml_element,
          lo_cdtr_acct TYPE REF TO if_ixml_element,
          lo_cdtr_acct_id TYPE REF TO if_ixml_element,
          lo_cdtr_acct_id_iban TYPE REF TO if_ixml_element,
          lo_rmtinf TYPE REF TO if_ixml_element,
          lo_rmtinf_ustrd TYPE REF TO if_ixml_element,
          lv_amount TYPE f,
          lv_amount_string TYPE string,
          lv_format TYPE p DECIMALS 2.

    FIELD-SYMBOLS: <fs_credittransfer> TYPE REF TO zcl_sepa_xml_credittransferinf.

*-->Jede Transaktionsinformation an das XML-Dokument anhängen
    LOOP AT tab_txinf ASSIGNING <fs_credittransfer>.
      "Summe der Transaktionen anpassen
      me->ctrlsum = me->ctrlsum + <fs_credittransfer>->get_instdamt( ).

      "Anzahl der Transaktionen anpassen
      me->nboftxs = me->nboftxs + 1.

      "-->Element <CdtTrfTxInf> erstellen und anhängen
      lo_cdttrftxinf = lo_document->create_simple_element( name = 'CdtTrfTxInf'
                                                           parent = lo_pmtinf ).

      "-->Element <PmtId> erstellen und anhängen
      lo_pmtid = lo_document->create_simple_element( name = 'PmtId'
                                                     parent = lo_cdttrftxinf ).

      "-->Element <EndToEndId> erstellen und anhängen
      lo_pmtid_endtoendid = lo_document->create_simple_element( name = 'EndToEndId'
                                                                parent = lo_pmtid
                                                                value = <fs_credittransfer>->get_endtoendif( ) ).

      "-->Element <Amt> erstellen und anhängen
      lo_amt = lo_document->create_simple_element( name = 'Amt'
                                                   parent = lo_cdttrftxinf ).

      "Umwandeln von Float in Char für Ausgabe
      lv_amount = <fs_credittransfer>->get_instdamt( ).

      CALL FUNCTION 'CEVA_CONVERT_FLOAT_TO_CHAR'
        EXPORTING
          float_imp  = lv_amount
          format_imp = lv_format
        IMPORTING
          char_exp   = lv_amount_string.

      "Leerzeichen entfernen und Dezimaltrennzeichen ersetzen ("," -> ".")
      lv_amount_string = condense( lv_amount_string ).
      REPLACE ALL OCCURRENCES OF ',' IN lv_amount_string WITH '.'.

      "-->Element <InstdAmt> erstellen und anhängen
      lo_amt_instdamt = lo_document->create_simple_element( name = 'InstdAmt'
                                                            parent = lo_amt
                                                            value = lv_amount_string ).
      "Erstellen des "Ccy" Attributs
      lo_amt_instdamt->set_attribute( name = 'Ccy'
                                      value = <fs_credittransfer>->get_ccy( ) ).

      "-->Element <CdtrAgt> erstellen und anhängen
      lo_cdtragt = lo_document->create_simple_element( name = 'CdtrAgt'
                                                       parent = lo_cdttrftxinf ).

      "-->Element <FinInstnId> erstellen und anhängen
      lo_fininstnid = lo_document->create_simple_element( name = 'FinInstnId'
                                                          parent = lo_cdtragt ).

      "-->Element <BIC> erstellen und anhängen
      lo_cdtragt_fininstnid_bic = lo_document->create_simple_element( name = 'BIC'
                                                                      parent = lo_fininstnid
                                                                      value = <fs_credittransfer>->get_bic( ) ).

      "-->Element <Cdtr> erstellen und anhängen
      lo_cdtr = lo_document->create_simple_element( name = 'Cdtr'
                                                    parent = lo_cdttrftxinf ).

      "-->Element <Nm> erstellen und anhängen
      lo_cdtr_nm = lo_document->create_simple_element( name = 'Nm'
                                                       parent = lo_cdtr
                                                       value = <fs_credittransfer>->get_cdtr_nm( ) ).

      "-->Element <CdtrAcct> erstellen und anhängen
      lo_cdtr_acct = lo_document->create_simple_element( name = 'CdtrAcct'
                                                         parent = lo_cdttrftxinf ).

      "-->Element <Id> erstellen und anhängen
      lo_cdtr_acct_id = lo_document->create_simple_element( name = 'Id'
                                                            parent = lo_cdtr_acct ).

      "-->Element <IBAN> erstellen und anhängen
      lo_cdtr_acct_id_iban = lo_document->create_simple_element( name = 'IBAN'
                                                                 parent = lo_cdtr_acct_id
                                                                 value = <fs_credittransfer>->get_iban( ) ).

      "-->Element <RmtInf> erstellen und anhängen
      lo_rmtinf = lo_document->create_simple_element( name = 'RmtInf'
                                                      parent = lo_cdttrftxinf ).

      "-->Element <Ustrd> erstellen und anhängen
      lo_rmtinf_ustrd = lo_document->create_simple_element( name = 'Ustrd'
                                                            parent = lo_rmtinf
                                                            value = <fs_credittransfer>->get_rmtinf_ustrd( ) ).
    ENDLOOP.

*-->Betrag von Float zu String umwandeln
    lv_amount = me->ctrlsum.

    CALL FUNCTION 'CEVA_CONVERT_FLOAT_TO_CHAR'
      EXPORTING
        float_imp  = lv_amount
        format_imp = lv_format
      IMPORTING
        char_exp   = lv_amount_string.

*-->Leerzeichen entfernen und Dezimaltrennzeichen ersetzen ("," -> ".")
    lv_amount_string = condense( lv_amount_string ).
    REPLACE ALL OCCURRENCES OF ',' IN lv_amount_string WITH '.'.

*-->Anzahl der Transaktionen von Zahl zu String
    DATA: lv_string_nboftxs TYPE string.
    lv_string_nboftxs =  me->nboftxs.
    lv_string_nboftxs = condense( lv_string_nboftxs ).

    lo_nboftxs->set_value( value = lv_string_nboftxs ).
    lo_ctrlsum->set_value( value = lv_amount_string ).
    lo_pmtinf_nboftxs->set_value( value = lv_string_nboftxs ).
    lo_pmtinf_ctrlsum->set_value( value = lv_amount_string ).

*-->Ausgabe
    DATA: xml_xstring TYPE etxml_line_str,
          xml_string TYPE string,
          lo_ostream TYPE REF TO if_ixml_ostream.

    lo_ostream = lo_ixml->create_stream_factory( )->create_ostream_xstring( string = xml_xstring ).
    lo_ostream->set_encoding( encoding = lo_encoding ).
    lo_ostream->set_pretty_print( pretty_print = abap_true ).

    lo_ixml->create_renderer( document = lo_document
                              ostream = lo_ostream )->render( ).

*-->XString zu normalem String
    CALL FUNCTION 'ECATT_CONV_XSTRING_TO_STRING'
      EXPORTING
        im_xstring  = xml_xstring
        im_encoding = 'UTF-8'
      IMPORTING
        ex_string   = xml_string.

*-->Ausgabe als Anzeige
    IF i_display = abap_true.
      cl_demo_output=>write_text( xml_string ).
      cl_demo_output=>display( ).
    ENDIF.

*-->Pfad für Ausgabe in Dateisystem vorbereiten
    IF i_download = abap_true OR i_save_appl = abap_true.
      DATA: lv_file_fullpath TYPE string.

      CONCATENATE i_path
            i_filename
       INTO
            lv_file_fullpath.
    ENDIF.

*-->Speichern auf dem Applikationsserver
    IF i_save_appl = abap_true.
      OPEN DATASET lv_file_fullpath FOR OUTPUT IN TEXT MODE ENCODING UTF-8.
      TRANSFER xml_string TO lv_file_fullpath.
      CLOSE DATASET lv_file_fullpath.
    ENDIF.

*-->Speichern per GUI-Download auf Client
    IF i_download = abap_true.
      DATA: gt_result TYPE TABLE OF string.

      REFRESH gt_result.
      APPEND xml_string TO gt_result.

      CALL METHOD cl_gui_frontend_services=>gui_download
        EXPORTING
          filename         = lv_file_fullpath
          codepage         = '4110'
        CHANGING
          data_tab         = gt_result
        EXCEPTIONS
          file_write_error = 1.
    ENDIF.
  ENDMETHOD.                    "create
ENDCLASS.
