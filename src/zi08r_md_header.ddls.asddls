@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Header Composite'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity zi08R_md_header
  as select from zi08_md_header
  composition [1..*] of zi08R_md_item as _item
  composition [1..*] of zi08R_md_serial as _serial
{
  key MaterialDocument,
  key DocumentYear,
      ReferenceDocument,
      Supplier,
      GoodsMovementCode,
      ReceivingPlant,
      MaterialDocumentHeaderText,
      Lastchangedat,
      Totallastchangedat,
      _item, // Make association public
      _serial
}
