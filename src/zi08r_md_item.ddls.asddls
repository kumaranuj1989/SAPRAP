@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Item Composite'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity zi08R_md_item
  as select from zi08_md_item
  association to parent zi08R_md_header as _head on  $projection.MaterialDocument = _head.MaterialDocument
                                                 and $projection.DocumentYear     = _head.DocumentYear
  association[1..*] to zi08R_md_serial as _serial on $projection.MaterialDocument = _serial.MaterialDocument
                                               and $projection.DocumentYear = _serial.DocumentYear    
                                               and $projection.DocumentItem = _serial.DocumentItem
                                                                                          
{
  key MaterialDocument,
  key DocumentYear,
  key DocumentItem,
      Material,
      Plant,
      StorageLocation,
      GoodsMovementType,
      PurchaseOrder,
      PurchaseOrderItem,
      GoodsMovementRefDocType,
      GoodsMovementReasonCode,
      @Semantics.quantity.unitOfMeasure: 'EntryUnit'
      QuantityInEntryUnit,
      EntryUnit,
      IsCompletelyDelivered,
      Lastchangedat,
      Totallastchangedat,
      _head, // Make association public
      _serial
}
