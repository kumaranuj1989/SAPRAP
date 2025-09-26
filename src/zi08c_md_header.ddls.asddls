@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Header Projection'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZI08C_MD_HEADER
  provider contract transactional_query
  as projection on zi08R_md_header
{
      @EndUserText.label: 'Material Document'
  key MaterialDocument,
      @EndUserText.label: 'Document Year'
  key DocumentYear,
      ReferenceDocument,
      Supplier,
      GoodsMovementCode,
      ReceivingPlant,
      MaterialDocumentHeaderText,
      Lastchangedat,
      Totallastchangedat,
      /* Associations */
      _item : redirected to composition child ZI08C_MD_ITEM,
      _serial : redirected to composition child ZI08C_MD_SERIAL
}
