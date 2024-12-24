//@AbapCatalog.sqlViewName: 'ZZ1_ZMMM07_RSEG'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '採購資訊明細表用'
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
define root view entity ZZ1_I_ZMM07_rseg as select from I_SuplrInvcItemPurOrdRefAPI01 //RSEG
{
    key SupplierInvoice,//belnr 
    key FiscalYear,//gjahr
    key SupplierInvoiceItem,//BUZEI
    ReferenceDocument,//lfbnr
    ReferenceDocumentFiscalYear,//lfgja
    ReferenceDocumentItem,//lfpos
    DebitCreditCode,//shkzg
    @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
    @DefaultAggregation: #NONE
    QuantityInPurchaseOrderUnit,//menge
   // @Semantics.unitOfMeasure: true
    PurchaseOrderQuantityUnit,//bstme
    @Semantics.amount.currencyCode: 'DocumentCurrency'
    @DefaultAggregation:#NONE
    SupplierInvoiceItemAmount,//wrbtr 
    FreightSupplier,--lifnr
    PurchaseOrder,--採購單
    PurchaseOrderItem,--採購單項目
 //   @Semantics.currencyCode: true
    DocumentCurrency,//rbkp-waers
    _SupplierInvoiceAPI01.ExchangeRate,//kursf RBKP
    _SupplierInvoiceAPI01.DocumentDate,//bldat RBKP
    _SupplierInvoiceAPI01.PostingDate,//budat RBKP
    _SupplierInvoiceAPI01.SupplierInvoiceIDByInvcgParty,//xblnr RBKP
    @Semantics.text: true
    _SupplierInvoiceAPI01.DocumentHeaderText,//bktxt RBKP
    SuplrInvcItmUnplndDelivCost //bnkan  
    //t001 waers rseg-waers
}
