@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '公司主檔Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zz1_I_CompanyCode as select from I_CompanyCode
{
     @ObjectModel.text.element: ['CompanyCodeName']
   //   @ObjectModel.hierarchy.association: '_CompanyCodeHierNode'
      @Search.defaultSearchElement:true
      @Search.fuzzinessThreshold:0.8
      @Search.ranking:#HIGH
  key CompanyCode,
      @Semantics.text: true
      CompanyCodeName,
      CityName,
      @ObjectModel.foreignKey.association: '_Country'
      Country,
      @ObjectModel.foreignKey.association: '_Currency'
      Currency,
      @ObjectModel.foreignKey.association: '_Language'
      Language,

      ChartOfAccounts,
      @ObjectModel.foreignKey.association: '_FiscalYearVariant'
      FiscalYearVariant,
      Company,
      //--[ GENERATED:012:29JlHNUf7jY4ioM8lnJMdG
      @Consumption.valueHelpDefinition: [ 
        { entity:  { name:    'I_CreditControlAreaStdVH',
                     element: 'CreditControlArea' }
        }]
      @ObjectModel.text.association: '_CreditControlAreaText'
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_CreditControlArea'
      CreditControlArea,
      //--[ GENERATED:012:29JlHNUf7jY4ioM8lnJMdG
//      @Consumption.valueHelpDefinition: [ 
//        { entity:  { name:    'I_ChartOfAccountsStdVH',
//                     element: 'ChartOfAccounts' }
//        }]
//      @ObjectModel.text.association: '_CountryChartOfAccountsText'
//      // ]--GENERATED
//      @ObjectModel.foreignKey.association: '_CountryChartOfAccounts'
      CountryChartOfAccounts,
      FinancialManagementArea,
      @ObjectModel.foreignKey.association: '_OrgAddressDefaultRprstn'
      AddressID,
      TaxableEntity,
      VATRegistration,
      ExtendedWhldgTaxIsActive,
      //--[ GENERATED:012:29JlHNUf7jY4ioM8lnJMdG
      @Consumption.valueHelpDefinition: [ 
        { entity:  { name:    'I_ControllingAreaStdVH',
                     element: 'ControllingArea' }
        }]
      @ObjectModel.text.association: '_ControllingAreaText'
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_ControllingArea'
      ControllingArea,
    //  @ObjectModel.foreignKey.association: '_FieldStatusVariant'
      FieldStatusVariant,
      NonTaxableTransactionTaxCode,
      DocDateIsUsedForTaxDetn,
      TaxRptgDateIsActive,
      CashDiscountBaseAmtIsNetAmt,
      _Currency,
      _Country, 
    //  @VDM.lifecycle.status: #DEPRECATED
    // @VDM.lifecycle.successor: '_OrgAddressDefaultRprstn'
      _Address,
      _OrgAddressDefaultRprstn,
      _Language,
      _ChartOfAccounts,
      _CountryChartOfAccounts,
      _FiscalYearVariant,
      _ControllingArea,
      _CreditControlArea,
      _FieldStatusVariant,
      _GlobalCompany,
      _CompanyCodeHierNode,
      //--[ GENERATED:012:29JlHNUf7jY4ioM8lnJMdG
      @Consumption.hidden: true
      _ChartOfAccountsText,
      @Consumption.hidden: true
      _CountryChartOfAccountsText,
      @Consumption.hidden: true
      _ControllingAreaText,
      @Consumption.hidden: true
      _CreditControlAreaText
      // ]--GENERATED
}
