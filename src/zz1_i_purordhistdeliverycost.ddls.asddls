@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '採購歷史紀錄I_PurOrdHistDeliveryCostAPI01'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZZ1_I_PurOrdHistDeliveryCost as select from I_PurOrdHistDeliveryCostAPI01
{
  key PurchaseOrder,
  key PurchaseOrderItem,

  key PricingProcedureStep,
  key PricingProcedureCounter,
  key PurchasingHistoryDocumentType,
  key PurchasingHistoryDocumentYear,
  key PurchasingHistoryDocument,
  key PurchasingHistoryDocumentItem,

      PurchasingHistoryCategory,
      PostingDate,

      @Semantics.quantity.unitOfMeasure:'OrderQuantityUnit'
      Quantity,

      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      PurOrdAmountInCompanyCodeCrcy,

      @Semantics.amount.currencyCode: 'Currency'
      PurchaseOrderAmount,

     // @Semantics.currencyCode: true 
      Currency,

      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      GRIRAcctClrgAmtInCoCodeCrcy,

      DebitCreditCode,
      DocumentReferenceID,

      Supplier,

      PurgHistDocumentCreationDate,
      PurgHistDocumentCreationTime,
     
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'  
      InvoiceAmtInCoCodeCrcy,

      @Semantics.amount.currencyCode: 'Currency'
      InvoiceAmountInFrgnCurrency,

      InventoryValuationType,

      ConditionType,

      @Semantics.quantity.unitOfMeasure:'OrderPriceUnit'
      QtyInPurchaseOrderPriceUnit,

      @Semantics.amount.currencyCode: 'Currency'
      GRIRAcctClrgAmtInTransacCrcy,

      CreatedByUser,

      @Semantics.amount.currencyCode: 'DocumentCurrency'
      GRIRAcctClrgAmtInOrdTrnsacCrcy,

      @Semantics.amount.currencyCode: 'DocumentCurrency'
      InvoiceAmtInPurOrdTransacCrcy,

      @Semantics.amount.currencyCode: 'Currency'
      ExchangeRateDifferenceAmount,

      ExchangeRate,

    //  @Semantics.unitOfMeasure: true
      OrderPriceUnit,
     // @Semantics.unitOfMeasure: true
      OrderQuantityUnit,
    //  @Semantics.currencyCode: true
      DocumentCurrency,
   //   @Semantics.currencyCode: true
      CompanyCodeCurrency,

      _PurchaseOrder,
      _PurchaseOrderItem
}
