*&---------------------------------------------------------------------*
*& Report  Z_SEPA_XML_TEST
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT z_sepa_xml_test.

DATA: cl_sepa TYPE REF TO zcl_sepa_xml_cct,
      cl_tx TYPE REF TO zcl_sepa_xml_credittransferinf.

*-->Instanz einer SEPA-Datei erstellen
CREATE OBJECT cl_sepa
  EXPORTING
    i_msgid                  = '0123456789'
    i_initgpty_nm            = 'Company XY'
    i_pmtinfid               = '0123456789'
    i_reqdexctndt            = sy-datum
    i_dbtr_nm                = 'Company XY'
    i_dbtracct_id_iban       = 'DE56214800000000000052'
    i_dbtragt_fininstnid_bic = 'AACSDE33XXX'
    i_svclvl_cd              = 'URGP'.

*-->Transaktionsdaten erstellen
CREATE OBJECT cl_tx
  EXPORTING
    i_pmtid_endtoendid       = 'Referenz'
    i_amt_ccy                = 'EUR'
    i_amt_instdamt           = '15.99'
    i_cdtragt_fininstnid_bic = 'AACSDE33XXX'
    i_cdtr_nm                = 'Sebastian Jansen'
    i_cdtracct_id_iban       = 'DE02390500000330983560'
    i_rmtinf_ustrd           = 'Testüberweisung'.

*-->Transaktionsdaten hinzufügen
cl_sepa->add_cdttrftxinf( cl_tx ).

*-->Weitere Transaktionsdaten erstellen
CREATE OBJECT cl_tx
  EXPORTING
    i_pmtid_endtoendid       = 'Referenz 2'
    i_amt_ccy                = 'EUR'
    i_amt_instdamt           = '20.99'
    i_cdtragt_fininstnid_bic = 'AACSDE33XXX'
    i_cdtr_nm                = 'Sebastian Jansen'
    i_cdtracct_id_iban       = 'DE02390500000330983560'
    i_rmtinf_ustrd           = 'Testüberweisung 2'.

*-->Weitere Transaktionsdaten hinzufügen
cl_sepa->add_cdttrftxinf( cl_tx ).

*-->Datei erstellen und ausgeben
**-->Beispielausgabe -> Download per Gui
*cl_sepa->create( i_filename = 'test.xml'
*                 i_path = 'C:\Users\username\Desktop\'
*                 i_display = abap_false
*                 i_download = abap_true
*                 i_save_appl = abap_false ).

**-->Beispielausgabe -> Speichern auf dem Applikationsserver
*cl_sepa->create( i_filename = 'test.xml'
*                 i_path = 'D:\usr\sap\de1\interfaces\test\'
*                 i_display = abap_false
*                 i_download = abap_false
*                 i_save_appl = abap_true ).

*-->Beispielausgabe -> Anzeige im Dialog
cl_sepa->create( i_display = abap_true
                 i_download = abap_false
                 i_save_appl = abap_false ).
