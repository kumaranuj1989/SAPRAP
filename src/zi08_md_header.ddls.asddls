@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MD Header'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zi08_md_header
  as select from z08md_header
{
  key mblnr              as MaterialDocument,
  key mjahr              as DocumentYear,
      xblnr              as ReferenceDocument,
      lifnr              as Supplier,
      gmcode             as GoodsMovementCode,
      rplant             as ReceivingPlant,
      bktxt              as MaterialDocumentHeaderText,
      lastchangedat      as Lastchangedat,
      totallastchangedat as Totallastchangedat
}
