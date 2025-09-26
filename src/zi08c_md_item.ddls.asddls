@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Item Projection'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZI08C_MD_ITEM
  as projection on zi08R_md_item
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
      /* Associations */
      _head : redirected to parent ZI08C_MD_HEADER,
      _serial : redirected to ZI08C_MD_SERIAL
}
