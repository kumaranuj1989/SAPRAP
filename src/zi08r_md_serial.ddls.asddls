@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MD Serial'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity zi08R_md_serial
  as select from zi08_md_serial
  association        to parent zi08R_md_header as _head on  $projection.MaterialDocument = _head.MaterialDocument
                                                        and $projection.DocumentYear     = _head.DocumentYear
  association [0..1] to zi08R_md_item          as _item on  $projection.MaterialDocument = _item.MaterialDocument
                                                        and $projection.DocumentYear     = _item.DocumentYear
                                                        and $projection.DocumentItem     = _item.DocumentItem
{
  key MaterialDocument,
  key DocumentYear,
  key DocumentItem,
  key Serial,
      SerialDesc,
      Lastchangedat,
      Totallastchangedat,
      _head,
      _item
}
