@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '幣別主檔I_currency'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZZ1_I_currency as select from I_Currency
{
    
   // @Semantics.currencyCode: true
    @ObjectModel.text.association: '_Text' 
    Currency,
    _Text,
    
    Decimals,
           
    @Search.defaultSearchElement: true
    @Search.ranking: #HIGH
    @Search.fuzzinessThreshold: 0.8
    CurrencyISOCode,
    AlternativeCurrencyKey,
    IsPrimaryCurrencyForISOCrcy
}
