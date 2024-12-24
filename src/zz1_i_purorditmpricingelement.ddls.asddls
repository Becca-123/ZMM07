@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '採購單 條件ZZ1_I_PurOrdItmPricingElementAPI01'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZZ1_I_PurOrdItmPricingElement as select from I_PurOrdItmPricingElementAPI01 as pricing
{
  key pricing.PurchaseOrder,
  key pricing.PurchaseOrderItem,
  key PricingDocument,
  key PricingDocumentItem,
  key PricingProcedureStep,
  key PricingProcedureCounter,
  
      ConditionApplication,
      ConditionType,
      @Semantics.dateTime: true
      PricingDateTime,
      ConditionCalculationType,
      ConditionBaseValue,
      ConditionRateValue,

   //   @Semantics.currencyCode: true
      ConditionCurrency,
   //   @API.element.releaseState: #DEPRECATED
   //   @API.element.successor:    'AbsltPriceDetnExchangeRate'
  //    PriceDetnExchangeRate,
      AbsltPriceDetnExchangeRate,
      PriceDetnExchRateIsIndrctQtan,      

      @Semantics.quantity.unitOfMeasure: 'ConditionQuantityUnit'
      ConditionQuantity,

   //   @Semantics.unitOfMeasure: true
      ConditionQuantityUnit,
      ConditionToBaseQtyNmrtr,
      ConditionToBaseQtyDnmntr,
      ConditionCategory,
      ConditionIsForStatistics,
      PricingScaleType,
      IsRelevantForAccrual,
    //  @Semantics.booleanIndicator: true
      CndnIsRelevantForInvoiceList,
      ConditionOrigin,
    //  @Semantics.booleanIndicator: true
      IsGroupCondition,
      AccessNumberOfAccessSequence,
      ConditionRecord,
      ConditionSequentialNumber,
      AccountKeyForGLAccount,
      GLAccount,
      TaxCode,
      AcctKeyForAccrualsGLAccount,
      AccrualsGLAccount,
      WithholdingTaxCode,
 
      FreightSupplier,

      @Semantics.amount.currencyCode: 'ConditionCurrency'
      CndnRoundingOffDiffAmount,

      @Semantics.amount.currencyCode: 'ConditionCurrency'
      ConditionAmount,

   //   @Semantics.currencyCode: true
      TransactionCurrency,
      ConditionControl,
      ConditionInactiveReason,
      ConditionClass,
      PrcgProcedureCounterForHeader,
      FactorForConditionBasisValue,
      StructureCondition,
      PeriodFactorForCndnBasisValue,
      PricingScaleBasis,
      ConditionScaleBasisValue,

      ConditionScaleBasisUnit,

    //  @Semantics.currencyCode: true
      ConditionScaleBasisCurrency,

   //   @Semantics.currencyCode: true
      ConditionAlternativeCurrency,

      @Semantics.amount.currencyCode: 'ConditionAlternativeCurrency'
      ConditionAmountInLocalCrcy,
      CndnIsRelevantForIntcoBilling,
      ConditionIsManuallyChanged,
      BillingPriceSource,
      TaxJurisdictionLevel,
      ConditionByteSequence,
      CndnIsRelevantForLimitValue,
      ConditionBasisLimitExceeded,
      ConditionAmountLimitExceeded,
      CumulatedConditionBasisValue,
    
      CustomerRebateRecipient,
      ConditionIsForConfiguration,
      VariantCondition,
      ConditionAcctAssgmtRelevance,
      ConditionMatrixMaintRelevance,
      ConfigblParametersAndFormulas,
      @Semantics.quantity.unitOfMeasure: 'ConditionQuantityUnit'
      ConditionAdjustedQuantity,
      CndnValueZeroProcgCode,
     
      _PurchaseOrder,    
      _PurchaseOrderItem     
}
