CLASS zcl_crud_md DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
**********************************************************************
*  Type Declaration
**********************************************************************
    TYPES:
      tt_mapped_header     TYPE RESPONSE FOR MAPPED EARLY zi08r_md_header,               "Mapped
      tt_failed_header     TYPE RESPONSE FOR FAILED EARLY zi08r_md_header,               "Failed
      tt_reported_header   TYPE RESPONSE FOR REPORTED EARLY zi08r_md_header,             "Reported
      tt_result_header     TYPE TABLE FOR READ RESULT zi08r_md_header\\header,           "Result
      tt_entities_cheader  TYPE TABLE FOR CREATE zi08r_md_header\\header,                "Create
      tt_entities_uheader  TYPE TABLE FOR UPDATE zi08r_md_header\\header,                "Update
      tt_keys_dheader      TYPE TABLE FOR DELETE zi08r_md_header\\header,                "Delete
      tt_keys_rheader      TYPE TABLE FOR READ IMPORT zi08r_md_header\\header,           "Read
      tt_keys_lheader      TYPE TABLE FOR KEY OF zi08r_md_header\\header,                "lock
      tt_keys_rba          TYPE TABLE FOR READ IMPORT zi08r_md_header\\header\_item,     "Read by association
      tt_result_rba        TYPE TABLE FOR READ RESULT zi08r_md_header\\header\_item,     "Result Read by association
      tt_association_links TYPE TABLE FOR READ LINK zi08r_md_header\\header\_item,       "Association links
      tt_entities_cba      TYPE TABLE FOR CREATE zi08r_md_header\\header\_item,          "Create by association
      tt_mapped_late       TYPE RESPONSE FOR MAPPED LATE zi08r_md_header,                "Mapped late
      tt_reported_late     TYPE RESPONSE FOR REPORTED LATE zi08r_md_header.              "Reported late

**********************************************************************
*   Method Declaration
**********************************************************************
    CLASS-METHODS factory RETURNING VALUE(ro_api) TYPE REF TO zcl_crud_md.

    METHODS:Create
      IMPORTING entities TYPE tt_entities_cheader
      CHANGING  mapped   TYPE tt_mapped_header
                failed   TYPE tt_failed_header
                reported TYPE tt_reported_header.

    METHODS:update
      IMPORTING entities TYPE tt_entities_uheader
      CHANGING  mapped   TYPE tt_mapped_header
                failed   TYPE tt_failed_header
                reported TYPE tt_reported_header.

    METHODS:delete
      IMPORTING keys     TYPE tt_keys_dheader
      CHANGING  mapped   TYPE tt_mapped_header
                failed   TYPE tt_failed_header
                reported TYPE tt_reported_header.

    METHODS:read
      IMPORTING keys     TYPE tt_keys_rheader
      CHANGING  result   TYPE tt_result_header
                failed   TYPE tt_failed_header
                reported TYPE tt_reported_header.

    METHODS:lock
      IMPORTING keys     TYPE tt_keys_lheader
      CHANGING  failed   TYPE tt_failed_header
                reported TYPE tt_reported_header.

    METHODS:rba_Item
      IMPORTING keys_rba          TYPE tt_keys_rba
                result_requested  TYPE c
      CHANGING  result            TYPE tt_result_rba
                association_links TYPE tt_association_links
                failed            TYPE tt_failed_header
                reported          TYPE tt_reported_header.

    METHODS:cba_Item
      IMPORTING entities_cba TYPE tt_entities_cba
      CHANGING  mapped       TYPE tt_mapped_header
                failed       TYPE tt_failed_header
                reported     TYPE tt_reported_header.

    METHODS:adjust_numbers
      CHANGING mapped   TYPE tt_mapped_late
               reported TYPE tt_reported_late.

    METHODS:save
      CHANGING reported TYPE tt_reported_late.

  PROTECTED SECTION.
  PRIVATE SECTION.
**********************************************************************
*   Data Declaration
**********************************************************************
    CLASS-DATA :
      lo_api    TYPE REF TO   zcl_crud_md,
      gt_header TYPE TABLE OF z08md_header,
      gt_item   TYPE TABLE OF z08md_item.
ENDCLASS.



CLASS zcl_crud_md IMPLEMENTATION.
  METHOD factory.       "Create Instance of the class
    lo_api = ro_api = COND #( WHEN lo_api IS BOUND
                             THEN lo_api
                             ELSE NEW #(  ) ).
  ENDMETHOD.

  METHOD Create.        "Create Method
    gt_header = CORRESPONDING #( entities MAPPING mblnr  = MaterialDocument
                                                  mjahr  = DocumentYear
                                                  gmcode = GoodsMovementCode
                                                  bktxt  = MaterialDocumentHeaderText
                                                  rplant = ReceivingPlant
                                                  xblnr  = ReferenceDocument
                                                  lifnr  = Supplier  ).
    IF gt_header IS NOT INITIAL.
      GET TIME STAMP FIELD DATA(ts).
      gt_header[ 1 ]-lastchangedat = ts.
      gt_header[ 1 ]-totallastchangedat = ts.
    ENDIF.
  ENDMETHOD.

  METHOD update.        "Update Method

  ENDMETHOD.

  METHOD delete.        "Delete Method

  ENDMETHOD.

  METHOD read.          "Read Method
    IF keys IS NOT INITIAL.
      DATA : t_header TYPE z08tt_md_header,
             t_item   TYPE z08tt_md_item,
             r_mblnr  TYPE z08ttr_mblnr,
             r_mjahr  TYPE z08ttr_mjahr,
             t_return TYPE z08tt_bapiret2.

      LOOP AT keys INTO DATA(key).
        APPEND VALUE #( sign = 'I' opti = 'EQ' low = key-MaterialDocument ) TO r_mblnr.
        APPEND VALUE #( sign = 'I' opti = 'EQ' low = key-DocumentYear ) TO r_mjahr.
      ENDLOOP.

      CALL FUNCTION 'ZBAPI_GOODS_MVMT_READ'
        EXPORTING
          mblnr  = r_mblnr
          mjahr  = r_mjahr
        IMPORTING
          header = t_header
          item   = t_item
          return = t_return.

      READ TABLE t_return INTO DATA(lw_return) WITH KEY type = 'E'.
      IF sy-subrc IS INITIAL.
        APPEND VALUE #( %tky = keys[ 1 ]-%tky ) TO failed-header.
      ELSE.
        result = CORRESPONDING #( t_header MAPPING MaterialDocument           = mblnr
                                                   DocumentYear               = mjahr
                                                   GoodsMovementCode          = gmcode
                                                   MaterialDocumentHeaderText = bktxt
                                                   ReceivingPlant             = rplant
                                                   ReferenceDocument          = xblnr
                                                   Supplier                   = lifnr ).
      ENDIF.
    ENDIF.
  ENDMETHOD.

  METHOD lock.          "Lock Method

  ENDMETHOD.

  METHOD rba_Item.      "Read by Association Method

  ENDMETHOD.

  METHOD cba_Item.      "Create by Association Method
    READ ENTITIES OF zi08R_md_header
    ENTITY Header
    ALL FIELDS WITH VALUE #( ( %tky-MaterialDocument = entities_cba[ 1 ]-MaterialDocument
                               %tky-DocumentYear = entities_cba[ 1 ]-DocumentYear
                              ) ) RESULT DATA(it_header).

    gt_header = CORRESPONDING #( it_header MAPPING
                                      mblnr = MaterialDocument
                                      mjahr  =   DocumentYear
                                      gmcode =    GoodsMovementCode
                                      bktxt =    MaterialDocumentHeaderText
                                      rplant =    ReceivingPlant
                                      xblnr =    ReferenceDocument
                                      lifnr  =   Supplier
                              ).

    gt_item = VALUE #( FOR ls_entities_cba IN entities_cba
                       FOR ls_item_cba IN ls_entities_cba-%target
                       LET ls_md_item = CORRESPONDING z08md_item( ls_item_cba MAPPING mblnr    = MaterialDocument
                                                                                      mjahr    = DocumentYear
                                                                                      zeile    = DocumentItem
                                                                                      grund    = GoodsMovementReasonCode
                                                                                      gmrdt    = GoodsMovementRefDocType
                                                                                      bwart    = GoodsMovementType
                                                                                      matnr    = Material
                                                                                      splant   = Plant
                                                                                      ebeln    = PurchaseOrder
                                                                                      ebelp    = PurchaseOrderItem
                                                                                      delv_inc = IsCompletelyDelivered
                                                                                      fkimg    = QuantityInEntryUnit
                                                                                      meins    = EntryUnit
                                                                                      lgort    = StorageLocation )
                      IN ( ls_md_item ) ).
  ENDMETHOD.

  METHOD adjust_numbers. "Adjust Numbers Method
    IF mapped IS NOT INITIAL.

    ENDIF.
  ENDMETHOD.

  METHOD save.          "Save Method
    DATA : mblnr  TYPE zmblnr,
           mjahr  TYPE zmjahr,
           return TYPE ztt_bapiret2.
    IF gt_header  IS NOT INITIAL.
      CALL FUNCTION 'ZBAPI_GOODS_MVMT'
        EXPORTING
          header = gt_header
          item   = gt_item
        IMPORTING
          mblnr  = mblnr
          mjahr  = mjahr
          return = return.
    ENDIF.

    APPEND VALUE #( materialdocument = mblnr
                    documentyear = mjahr
                    %msg = lcl_message=>get_instance( )->message(
                             severity = COND #( WHEN return[ 1 ]-type EQ 'E' THEN if_abap_behv_message=>severity-error
                                                ELSE if_abap_behv_message=>severity-success
                                               )
                             text     = return[ 1 ]-message
                           )
                    ) TO reported-header.

  ENDMETHOD.
ENDCLASS.
