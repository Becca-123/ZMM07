@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '客戶主檔I_Customer'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZZ1_I_Customer as select from I_Customer
{
     //Key 
  key Customer,
      @Semantics.text:true
      CustomerName,
      CustomerFullName, //KF: different with S4
      OrganizationBPName1
}
