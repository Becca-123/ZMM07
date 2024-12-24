@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '物料文件I_MaterialDocumentItem_2'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZZ1_I_MaterialDocumentItem_2 as select from I_MaterialDocumentItem_2
{
     @ObjectModel.foreignKey.association: '_MaterialDocumentYear'
  key MaterialDocumentYear,
      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.9,
                    ranking: #HIGH
               }
      @ObjectModel.foreignKey.association: '_MaterialDocumentHeader'
  key MaterialDocument,
  key MaterialDocumentItem,

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.7,
                    ranking: #HIGH
               }
      Material,

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.9,
                    ranking: #HIGH
               }
      Plant,
      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.9,
                    ranking: #HIGH
               }
      StorageLocation,
      StorageType,
      StorageBin,

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.8,
                    ranking: #MEDIUM
               }
      Batch,
      ShelfLifeExpirationDate,
      ManufactureDate,

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.8,
                    ranking: #MEDIUM
               }
      Supplier,

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.9,
                    ranking: #MEDIUM
               }
      SalesOrder,
      SalesOrderItem,
      SalesOrderScheduleLine,

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.9,
                    ranking: #MEDIUM
               }

      // casting of the WBSElementInternalID to a NSDM data element to get rid of the conversion exit behind the original data element MAT_PSPNR
      // required for the Reservation RAP object which does associate this view
      WBSElementInternalID,
      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.8,
                    ranking: #MEDIUM
               }
      Customer,
      InventorySpecialStockType,
      InventoryStockType,

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.8,
                    ranking: #MEDIUM
               }
      StockOwner,

      GoodsMovementType,
      DebitCreditCode,
      InventoryUsabilityCode,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @DefaultAggregation: #SUM
      QuantityInBaseUnit,
      MaterialBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'EntryUnit'
      @DefaultAggregation: #SUM
      QuantityInEntryUnit,
      EntryUnit,

      @Semantics.businessDate.at: true
      PostingDate,
      @Semantics.businessDate.at: true
      DocumentDate,
      ReservationItemRecordType,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      @DefaultAggregation: #SUM
      TotalGoodsMvtAmtInCCCrcy,
      CompanyCodeCurrency,

      InventoryValuationType,
      ReservationIsFinallyIssued,

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.9,
                    ranking: #MEDIUM
                }
      PurchaseOrder,
      PurchaseOrderItem,

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.9,
                    ranking: #MEDIUM
               }
      ProjectNetwork,

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.9,
                    ranking: #MEDIUM
               }
      OrderID,
      OrderItem,

      MaintOrderRoutingNumber,
      MaintOrderOperationCounter,

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.9,
                    ranking: #MEDIUM
               }
      Reservation,
      ReservationItem,

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.9,
                    ranking: #MEDIUM
               }
      DeliveryDocument,
      DeliveryDocumentItem,

      ReversedMaterialDocumentYear,

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.9,
                    ranking: #MEDIUM
               }
      ReversedMaterialDocument,
      ReversedMaterialDocumentItem,

      RvslOfGoodsReceiptIsAllowed,

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.7,
                    ranking: #MEDIUM
               }
      GoodsRecipientName,

      GoodsMovementReasonCode,

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.7,
                    ranking: #MEDIUM
               }
      UnloadingPointName,
      CostCenter,
      GLAccount,

      ServicePerformer,
      PersonWorkAgreement,
      AccountAssignmentCategory,
      WorkItem,
      ServicesRenderedDate,

      IssgOrRcvgMaterial,
      IssuingOrReceivingPlant,
      IssuingOrReceivingStorageLoc,
      IssgOrRcvgBatch,
      IssgOrRcvgSpclStockInd,
      IssuingOrReceivingValType,

      CompanyCode,
      BusinessArea,
      ControllingArea,
      @Semantics.fiscal.yearPeriod: true
      FiscalYearPeriod,
      @Semantics.fiscal.yearVariant: true
      FiscalYearVariant,

      GoodsMovementRefDocType,
      IsCompletelyDelivered,
      MaterialDocumentItemText,
     // @Semantics.booleanIndicator
      IsAutomaticallyCreated,

      //@Semantics.booleanIndicator
      SerialNumbersAreCreatedAutomly,

      @Consumption.hidden: true
      GoodsReceiptType,
      @Consumption.hidden: true
      ConsumptionPosting,

      @Consumption.hidden: true
      MultiAcctAssgmtOriglMatlDocItm,
      @Consumption.hidden: true
      MultipleAccountAssignmentCode,
      GoodsMovementIsCancelled,
      IssuingOrReceivingStockType,

      ManufacturingOrder,
      ManufacturingOrderItem,

      MaterialDocumentLine,
      MaterialDocumentParentLine,

      SpecialStockIdfgSalesOrder,
      SpecialStockIdfgSalesOrderItem,

      SpecialStockIdfgWBSElement,
      
      @Semantics.quantity.unitOfMeasure: 'OrderPriceUnit'
      @Aggregation.default: #SUM
      QtyInPurchaseOrderPriceUnit,
      OrderPriceUnit,

      @Semantics.quantity.unitOfMeasure: 'DeliveryQuantityUnit'
      @Aggregation.default: #SUM
      QuantityInDeliveryQtyUnit,
      DeliveryQuantityUnit,

      ProfitCenter,

      ProductStandardID,

      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      GdsMvtExtAmtInCoCodeCrcy,

      --Reference Fields
      ReferenceDocumentFiscalYear,
      InvtryMgmtReferenceDocument,
      InvtryMgmtRefDocumentItem,

      --EWM Fields
      EWMWarehouse,
      EWMStorageBin,

      MaterialDocumentPostingType,
      OriginalMaterialDocumentItem,

      _MaterialDocumentYear,
      //@ObjectModel.association.type:[#TO_COMPOSITION_ROOT, #TO_COMPOSITION_PARENT]
      _MaterialDocumentHeader,

      _Material,
      _IssgOrRcvgMaterial,

      //search model
      _Plant,
      _IssuingOrReceivingPlant,
      _StorageLocation,
      _IssuingOrReceivingStorageLoc,

      _Supplier,
      _Customer,

      @Consumption.hidden: true
      _SupplierCompanyByPlant,
      @Consumption.hidden: true
      _CustomerCompanyByPlant,

      _BPStockOwner,

      _InventorySpecialStockType,
      _IssgOrRcvgSpclStockInd,
      _InventoryStockType,
      _InventoryValuationType,

      _GoodsMovementType,
      _DebitCreditCode,
  //    @API.element.releaseState: #DEPRECATED
    //  @API.element.successor: '_StockType_2'
   //   @VDM.lifecycle.status: #DEPRECATED
     // @VDM.lifecycle.successor: '_StockType_2'
    //  _StockType,
      _StockType_2,

      _MaterialBaseUnit,
      _EntryUnit,

      _GLAccount,
      _CostCenter,

      _BusinessPartner,
      _PersonWorkAgreement,
      _AccountAssignmentCategory,
      _WorkItem,

      _CompanyCode,
      _BusinessArea,
      _ControllingArea,

      _SalesOrder,
      _SalesOrderItem,
      _SalesOrderScheduleLine,
      _WBSElement,

      _PurchaseOrder,
      _PurchaseOrderItem,
      _ProjectNetwork,
      _LogisticsOrder,
      _DeliveryDocument,
      _DeliveryDocumentItem,

      _ReversedMatDoc,
      _ReversedMatDocItem,
      _GoodsMvtTypeBySpclStkIndT,
      _Currency
}
