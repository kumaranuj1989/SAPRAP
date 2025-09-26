CLASS lhc_Header DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Header RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Header RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE Header.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE Header.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE Header.

    METHODS read FOR READ
      IMPORTING keys FOR READ Header RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK Header.

    METHODS rba_Item FOR READ
      IMPORTING keys_rba FOR READ Header\_Item FULL result_requested RESULT result LINK association_links.

    METHODS cba_Item FOR MODIFY
      IMPORTING entities_cba FOR CREATE Header\_Item.
    METHODS rba_Serial FOR READ
      IMPORTING keys_rba FOR READ Header\_Serial FULL result_requested RESULT result LINK association_links.

    METHODS cba_Serial FOR MODIFY
      IMPORTING entities_cba FOR CREATE Header\_Serial.

ENDCLASS.

CLASS lhc_Header IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD create.
    zcl_crud_md=>factory(  )->create(
      EXPORTING
        entities = entities
      CHANGING
        mapped   = mapped
        failed   = failed
        reported = reported
    ).

  ENDMETHOD.

  METHOD update.
    zcl_crud_md=>factory(  )->update(
        EXPORTING
          entities = entities
        CHANGING
          mapped   = mapped
          failed   = failed
          reported = reported
      ).
  ENDMETHOD.

  METHOD delete.
    zcl_crud_md=>factory(  )->delete(
        EXPORTING
          keys     = keys
        CHANGING
          mapped   = mapped
          failed   = failed
          reported = reported
      ).
  ENDMETHOD.

  METHOD read.
    zcl_crud_md=>factory(  )->read(
      EXPORTING
        keys     = keys
      CHANGING
        failed   = failed
        reported = reported
        result   = result
    ).
  ENDMETHOD.

  METHOD lock.
    zcl_crud_md=>factory(  )->lock(
      EXPORTING
        keys     = keys
      CHANGING
        failed   = failed
        reported = reported
    ).
  ENDMETHOD.

  METHOD rba_Item.
    zcl_crud_md=>factory(  )->rba_Item(
      EXPORTING
        keys_rba          = keys_rba
        result_requested  = result_requested
      CHANGING
        result            = result
        association_links = association_links
        failed            = failed
        reported          = reported
    ).
  ENDMETHOD.

  METHOD cba_Item.
    zcl_crud_md=>factory(  )->cba_Item(
      EXPORTING
        entities_cba       = entities_cba
      CHANGING
        mapped             = mapped
        failed             = failed
        reported           = reported ).
  ENDMETHOD.

  METHOD rba_Serial.
  ENDMETHOD.

  METHOD cba_Serial.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_Item DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE Item.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE Item.

    METHODS read FOR READ
      IMPORTING keys FOR READ Item RESULT result.

    METHODS rba_Head FOR READ
      IMPORTING keys_rba FOR READ Item\_Head FULL result_requested RESULT result LINK association_links.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Item RESULT result.

    METHODS rba_Serial FOR READ
      IMPORTING keys_rba FOR READ Item\_Serial FULL result_requested RESULT result LINK association_links.

    METHODS cba_Serial FOR MODIFY
      IMPORTING entities_cba FOR CREATE Item\_Serial.

ENDCLASS.

CLASS lhc_Item IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Head.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD rba_Serial.
  ENDMETHOD.

  METHOD cba_Serial.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_serial DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE Serial.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE Serial.

    METHODS read FOR READ
      IMPORTING keys FOR READ Serial RESULT result.

    METHODS rba_Head FOR READ
      IMPORTING keys_rba FOR READ Serial\_Head FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_serial IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Head.
  ENDMETHOD.


ENDCLASS.

CLASS lsc_ZI08R_MD_HEADER DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS adjust_numbers REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZI08R_MD_HEADER IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD adjust_numbers.
    zcl_crud_md=>factory(  )->adjust_numbers(
      CHANGING
        mapped   = mapped
        reported = reported
    ).
  ENDMETHOD.

  METHOD save.
    zcl_crud_md=>factory(  )->save(
      CHANGING
        reported = reported
    ).
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
