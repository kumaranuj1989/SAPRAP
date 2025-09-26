@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MD Serial'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zi08_md_serial
  as select from z08md_serial
{
  key mblnr              as MaterialDocument,
  key mjahr              as DocumentYear,
  key zeile              as DocumentItem,
  key serial             as Serial,
      serial_desc        as SerialDesc,
      lastchangedat      as Lastchangedat,
      totallastchangedat as Totallastchangedat
}
