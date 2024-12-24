//************************************************************************
//Copyright     : Innatech Co., Ltd.
//Author        : Jason
//Create Date   : 2024/06/06 
//************************************************************************
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '採購進貨明細表'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.resultSet.sizeCategory: #XS
@ObjectModel.supportedCapabilities: [ #ANALYTICAL_DIMENSION, #CDS_MODELING_ASSOCIATION_TARGET, #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE ]
define root view entity ZZ1_I_ZMM07 
    as select from  I_MaterialDocumentItem_2   as I_MaterialDocumentItem_2   
    association [0..1] to I_Plant as _Plant on  $projection.Plant = _Plant.Plant 
    association [0..1] to I_StorageLocation as _StorageLocation on  $projection.StorageLocation = _StorageLocation.StorageLocation
                                                                     and $projection.Plant           = _StorageLocation.Plant
//    association [0..1] to I_PurchasingDocumentType    as _PurchasingDocumentType    on  _PurchaseOrderAPI01.purchasingdocumentcategory = _PurchasingDocumentType.PurchasingDocumentCategory
//                                                                                    and _PurchaseOrderAPI01.purchasingdocumenttype     = _PurchasingDocumentType.PurchasingDocumentType                                                            
    association [0..1] to I_PurchaseOrderItemAPI01 as _PurchaseOrderItemAPI01   on  $projection.PurchaseOrder = _PurchaseOrderItemAPI01.PurchaseOrder
                                                                                  and $projection.PurchaseOrderItem = _PurchaseOrderItemAPI01.PurchaseOrderItem
    association [0..1] to I_PurchaseOrderAPI01 as _PurchaseOrderAPI01 on  $projection.PurchaseOrder = _PurchaseOrderAPI01.PurchaseOrder       
    association [1..1] to I_PurchaseOrderHistoryAPI01 as _PurchaseOrderHistoryAPI01 on  _PurchaseOrderHistoryAPI01.PurchasingHistoryDocumentYear =  I_MaterialDocumentItem_2.MaterialDocumentYear
                                                                                    and _PurchaseOrderHistoryAPI01.PurchasingHistoryDocument = I_MaterialDocumentItem_2.MaterialDocument
                                                                                    and _PurchaseOrderHistoryAPI01.PurchasingHistoryDocumentItem = I_MaterialDocumentItem_2.MaterialDocumentItem                                                                                    
{
    
      @ObjectModel.foreignKey.association: '_MaterialDocumentYear'
      key I_MaterialDocumentItem_2.MaterialDocumentYear,//mjahr
      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.9,
                    ranking: #HIGH
               }
      @ObjectModel.foreignKey.association: '_MaterialDocumentHeader'
      key I_MaterialDocumentItem_2.MaterialDocument,//mblnr
      key I_MaterialDocumentItem_2.MaterialDocumentItem,//zeile
      I_MaterialDocumentItem_2.PurchaseOrder,//ebeln
      I_MaterialDocumentItem_2.PurchaseOrderItem,//ebelp
      I_MaterialDocumentItem_2.Supplier,//lifnr
      @Semantics.businessDate.at: true
      I_MaterialDocumentItem_2.PostingDate,//budat
      I_MaterialDocumentItem_2.Material,//matnr
      I_MaterialDocumentItem_2.Plant,//werks
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      @DefaultAggregation: #SUM
      I_MaterialDocumentItem_2.TotalGoodsMvtAmtInCCCrcy,//dmbtr
      I_MaterialDocumentItem_2.CompanyCodeCurrency,
      I_MaterialDocumentItem_2._Plant.PlantName,//name1 
      I_MaterialDocumentItem_2.StorageLocation,//lgort
      I_MaterialDocumentItem_2._StorageLocation.StorageLocationName,//lgobe
      I_MaterialDocumentItem_2.Batch,//charg
      @Semantics.quantity.unitOfMeasure: 'EntryUnit'
      @DefaultAggregation: #SUM
      I_MaterialDocumentItem_2.QuantityInEntryUnit,//erfmg
      I_MaterialDocumentItem_2.DebitCreditCode,//shkzg
      I_MaterialDocumentItem_2.EntryUnit,//erfme
      I_MaterialDocumentItem_2.DocumentDate, //bldat
      
   //   I_MaterialDocumentItem_2.PurchaseOrder,//ebeln
   //   I_MaterialDocumentItem_2.PurchaseOrderItem,//ebelp
      _PurchaseOrderItemAPI01.DocumentCurrency,//waers
    //  @Semantics.unitOfMeasure: true
      _PurchaseOrderItemAPI01.PurchaseOrderQuantityUnit,
      @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
      _PurchaseOrderItemAPI01.NetPriceQuantity, //peinh
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      @DefaultAggregation: #NONE
      _PurchaseOrderItemAPI01.NetPriceAmount,//neptr
      I_MaterialDocumentItem_2.GoodsMovementType,//bwart
      I_MaterialDocumentItem_2.GoodsMovementRefDocType,//kzbew
      I_MaterialDocumentItem_2.GoodsReceiptType,//kzzug
      I_MaterialDocumentItem_2.ConsumptionPosting,//kzvbr
      I_MaterialDocumentItem_2.InventoryUsabilityCode,//insmk
      I_MaterialDocumentItem_2.InventorySpecialStockType,//sobkz
      I_MaterialDocumentItem_2.Customer,//kunnr
      I_MaterialDocumentItem_2.SalesOrder,//kdauf
      I_MaterialDocumentItem_2.SalesOrderItem,//kdpos
      I_MaterialDocumentItem_2.ManufacturingOrder,//aufnr
  //    I_MaterialDocumentItem_2.MasterFixedAsset,//anln1 沒開 
  //    I_MaterialDocumentItem_2.FixedAsset,//anln2 沒開
      I_MaterialDocumentItem_2.GLAccount,//sakto  
      I_MaterialDocumentItem_2.CostCenter,//kostl
      I_MaterialDocumentItem_2.ControllingArea,//kokrs
      I_MaterialDocumentItem_2.ReversedMaterialDocumentYear,//sjahr
      I_MaterialDocumentItem_2.ReversedMaterialDocument,//smbln
      I_MaterialDocumentItem_2.ReversedMaterialDocumentItem,//smblp
      I_MaterialDocumentItem_2.CompanyCode,//bukrs'
      @Semantics.quantity.unitOfMeasure: 'OrderPriceUnit'
      @Aggregation.default: #SUM
      I_MaterialDocumentItem_2.QtyInPurchaseOrderPriceUnit,//bpmng            
      I_MaterialDocumentItem_2.OrderPriceUnit,//bprme
      _PurchaseOrderItemAPI01.PurchasingDocumentDeletionCode,//loekz 
      _PurchaseOrderItemAPI01.IsReturnsItem,//retpo
      _PurchaseOrderAPI01.PurchaseOrderDate,//bedat
      _PurchaseOrderAPI01.PurchasingOrganization,//ekorg
      _PurchaseOrderAPI01.PurchasingGroup,//ekgrp
      _PurchaseOrderItemAPI01.Plant as po_plant,//WERKS 
      _PurchaseOrderItemAPI01.SupplierMaterialNumber,//idnlf
      _PurchaseOrderAPI01.PricingDocument,//knumv
      _PurchaseOrderAPI01.CorrespncExternalReference,//ihrez
      _PurchaseOrderAPI01.CorrespncInternalReference,//unsez
      I_MaterialDocumentItem_2._MaterialDocumentHeader.MaterialDocumentHeaderText,//bktxt
      I_MaterialDocumentItem_2.MaterialDocumentItemText,//sgtxt
      I_MaterialDocumentItem_2.AccountAssignmentCategory,//knttp
      @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
      _PurchaseOrderItemAPI01.OrderQuantity,//ekpo-menge
      _PurchaseOrderAPI01.PurchaseOrderType,//Bsart
     // _PurchasingDocumentType.PurchasingDocumentType,//i
      //ekbe 
      @Semantics.amount.currencyCode: 'Currency'
      _PurchaseOrderHistoryAPI01.PurchaseOrderAmount,//wrbtr
   //   @Semantics.currencyCode: true
      _PurchaseOrderHistoryAPI01.Currency, //waers
      @Semantics.amount.currencyCode: 'Currency'
      _PurchaseOrderHistoryAPI01.PurOrdAmountInCompanyCodeCrcy,//dmbtr
      _PurchaseOrderHistoryAPI01.DebitCreditCode as po_DebitCreditCode, //ekbe-shkzg
    /*  case when ReversedMaterialDocument = '' then
        cast ('' as xfeld )
      else 
        cast ('X' as xfeld )
      end as reversedflag, //是否有迴轉過*/
      //association 
      I_MaterialDocumentItem_2._MaterialDocumentYear,
      I_MaterialDocumentItem_2._MaterialDocumentHeader
}where I_MaterialDocumentItem_2.MaterialDocumentParentLine = '000000' and I_MaterialDocumentItem_2._MaterialDocumentHeader.InventoryTransactionType = 'WE'
and I_MaterialDocumentItem_2.GoodsMovementIsCancelled is initial and I_MaterialDocumentItem_2.ReversedMaterialDocument is initial 
and I_MaterialDocumentItem_2.MultipleAccountAssignmentCode is initial
