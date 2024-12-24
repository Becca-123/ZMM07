@EndUserText.label: '採購資訊紀錄明細表用INVO'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZZ1_I_ZMM07_INVO as select from I_PurchaseOrderHistoryAPI01 as I_PurchaseOrderHistoryAPI01 //ekbe
association [0..1] to I_SuplrInvcItemPurOrdRefAPI01 as _SuplrInvcItemPurOrdRefAPI01 on I_PurchaseOrderHistoryAPI01.PurchasingHistoryDocument = _SuplrInvcItemPurOrdRefAPI01.SupplierInvoice //resg
                                                    and _SuplrInvcItemPurOrdRefAPI01.FiscalYear = I_PurchaseOrderHistoryAPI01.PurchasingHistoryDocumentYear  
                                                    and _SuplrInvcItemPurOrdRefAPI01.PurchaseOrder = I_PurchaseOrderHistoryAPI01.PurchaseOrder 
association [0..1] to I_SupplierInvoiceAPI01 as _SupplierInvoiceAPI01 on _SupplierInvoiceAPI01.SupplierInvoice = I_PurchaseOrderHistoryAPI01.PurchasingHistoryDocument
                                                    and _SupplierInvoiceAPI01.FiscalYear  = I_PurchaseOrderHistoryAPI01.PurchasingHistoryDocumentYear //rbkp
                                                                           
{
    key I_PurchaseOrderHistoryAPI01.PurchasingHistoryDocument,//ekbe-belnr
    key PurchasingHistoryDocumentYear,// ekbe-gjhar
    key PurchasingHistoryDocumentItem,// ekbe-buzei
    ReferenceDocumentFiscalYear,//lfgja
    ReferenceDocument,//lfbnr 
    ReferenceDocumentItem,//lfpos
    PurchasingHistoryDocumentType,--vgabe
   // @Semantics.currencyCode: true
    Currency,//waer
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    PurOrdAmountInCompanyCodeCrcy,
  //  @Semantics.currencyCode: true
    CompanyCodeCurrency, //公司幣別
    _SuplrInvcItemPurOrdRefAPI01.PurchaseOrder, //resg.ebeln
    _SuplrInvcItemPurOrdRefAPI01.PurchaseOrderItem, //resg.ebelp
    _SuplrInvcItemPurOrdRefAPI01.DebitCreditCode, //SHKZG
    _SuplrInvcItemPurOrdRefAPI01.IsSubsequentDebitCredit, --tbtkz
    _SuplrInvcItemPurOrdRefAPI01.FreightSupplier,--lifnr
    @Semantics.businessDate.at: true
    _SupplierInvoiceAPI01.DocumentDate, //rbkp.bldat 
    _SupplierInvoiceAPI01.PostingDate,//rbkp.budat
    _SupplierInvoiceAPI01.CompanyCode, //bukrs  
    _SupplierInvoiceAPI01.InvoicingParty //發票表頭供應商
    
} where _SupplierInvoiceAPI01.ReverseDocument is initial and I_PurchaseOrderHistoryAPI01.PurchasingHistoryDocumentType = '3' and _SuplrInvcItemPurOrdRefAPI01.IsSubsequentDebitCredit = 'X'

//ekbe-vgabe = 3 and rseg-tbtkz = 'X'
