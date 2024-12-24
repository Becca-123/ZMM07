@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '會計文件I_JournalEntry'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZZ1_I_JournalEntry02 as select from I_JournalEntry
{
      //--[ GENERATED:012:29JlHNUf7jY4ip7HtmZN9m
      @Consumption.valueHelpDefinition: [ 
        { entity:  { name:    'I_CompanyCodeStdVH',
                     element: 'CompanyCode' }
        }]
      // ]--GENERATED
@ObjectModel.foreignKey.association: '_CompanyCode'
key CompanyCode,
@ObjectModel.foreignKey.association: '_FiscalYear'
key FiscalYear,
key AccountingDocument,
OriginalReferenceDocument,
_FiscalYear,
_CompanyCode
}
