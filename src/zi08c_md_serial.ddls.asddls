@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Serial Projection'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZI08C_MD_SERIAL as projection on zi08R_md_serial
{  
    key MaterialDocument,
    key DocumentYear,
    key DocumentItem,
    key Serial,
    SerialDesc,
    Lastchangedat,
    Totallastchangedat,
    /* Associations */
    _head : redirected to parent ZI08C_MD_HEADER,
    _item : redirected to ZI08C_MD_ITEM
}
