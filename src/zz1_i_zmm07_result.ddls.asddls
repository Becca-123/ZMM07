//************************************************************************
//Copyright     : Innatech Co., Ltd.
//Author        : Jason
//Create Date   : 2024/07/02 
//************************************************************************
@EndUserText.label: '採購進貨明細表_資料顯示'
@AbapCatalog.sqlViewName: 'ZZ1_ZMM07_SHOW'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view ZZ1_I_ZMM07_result as select from ZZ1_TF_ZMM07_process (p_client: $session.client ) as zmm07
   left outer join I_UnitOfMeasureText as _UnitOfMeasureText on zmm07.erfme = _UnitOfMeasureText.UnitOfMeasure and _UnitOfMeasureText.Language = $session.system_language //ERFME_CH
   left outer join I_UnitOfMeasureText as _UnitOfMeasureText2 on zmm07.bstme = _UnitOfMeasureText2.UnitOfMeasure and _UnitOfMeasureText2.Language = $session.system_language //bstme_CH 
   left outer join I_UnitOfMeasureText as _UnitOfMeasureText3 on zmm07.BPRME = _UnitOfMeasureText3.UnitOfMeasure and _UnitOfMeasureText3.Language = $session.system_language //BPRME_CH 
   left outer join I_GoodsMovementTypeT  as _GoodsMovementTypeT on zmm07.BWART = _GoodsMovementTypeT.GoodsMovementType and _GoodsMovementTypeT.Language = $session.system_language
   left outer join I_InventorySpecialStockTypeT as _InventorySpecialStockTypeT on zmm07.SOBKZ = _InventorySpecialStockTypeT.InventorySpecialStockType and _InventorySpecialStockTypeT.Language = $session.system_language //sotxt
   left outer join I_CostCenterText as _CostCenterText on zmm07.KOSTL = _CostCenterText.CostCenter and zmm07.kokrs = _CostCenterText.ControllingArea and _CostCenterText.Language =  $session.system_language
   left outer join  I_ProductText as _ProductText on zmm07.matnr = _ProductText.Product and _ProductText.Language = $session.system_language
   left outer join I_Supplier as _supplier on  zmm07.lifnr = _supplier.Supplier
   left outer join I_Plant as _Plant on zmm07.werks = _Plant.Plant
   left outer join I_StorageLocation as _StorageLocation on zmm07.werks = _StorageLocation.Plant and zmm07.lgort = _StorageLocation.StorageLocation 
  // left outer join  I_GoodsMovementTypeT as _GoodsMovementTypeT on zmm07.BWART = _GoodsMovementTypeT.GoodsMovementType
{
    key client,
    @UI: { lineItem:       [ { position: 40, importance: #HIGH } ],
         selectionField: [{ position: 40 }]   
         }
    @EndUserText.label: '物料文件號碼'
    key mblnr,//物料文件
    @UI: { lineItem:       [ { position: 240, importance: #HIGH } ],
         hidden:true
         }
    @EndUserText.label: '物料文件年度'
    key MJAHR,//物料文件年度 MJAHR  : abap.numc(4);//物料文件年度  4 
    @UI: { lineItem:       [ { position: 60, importance: #HIGH } ]
         }
    @EndUserText.label: '物料文件項目'
    key ZEILE,//物料文件項目 ZEILE  : abap.numc(4); //4 
    @UI: { lineItem:       [ { position: 260, importance: #HIGH } ],
         selectionField: [{ position: 260 }]
         }
    @EndUserText.label: '採購單號碼'
    @Consumption.valueHelpDefinition: [ { entity: { name: 'I_PurchaseOrderAPI01', element: 'PurchaseOrder' } }]
    key ebeln,//ebeln  : abap.char(10);--
    @UI: { lineItem:       [ { position: 270, importance: #HIGH } ]
         }
    @EndUserText.label: '採購文件項目'
    key EBELP,//EBELP : abap.numc(5);
    @UI: { lineItem:       [ { position: 10, importance: #HIGH } ],
             selectionField: [{ position: 10 }]
         }
    @EndUserText.label: '供應商帳號'
    @Consumption.valueHelpDefinition: [ { entity: { name: 'I_Supplier', element: 'Supplier' } }]
    lifnr, // lifnr  : abap.char(10);
    @UI: { lineItem:       [ { position: 20, importance: #HIGH } ]
         }
    @EndUserText.label: '供應商名稱'
    _supplier.SupplierName,//lfa1-name1
    @UI: { lineItem:       [ { position: 30, importance: #HIGH } ],
             selectionField: [{ position: 30 }]
         }
    @EndUserText.label: '過帳日期'
    budat,//budat  : abap.dats;
    @UI: { lineItem:       [ { position: 50, importance: #HIGH } ]
         }
    @EndUserText.label: '物料文件日期'
    MKPF_BLDAT,//MKPF_BLDAT : abap.dats;
    @UI: { lineItem:       [ { position: 70, importance: #HIGH } ],
             selectionField: [{ position: 70 }]   
         }
    @EndUserText.label: '物料'
    @Consumption.valueHelpDefinition: [ { entity: { name: 'I_ProductStdVH', element: 'Product' } } ]
    @ObjectModel.text.element: ['ProductName']
    matnr,//matnr  : abap.char(40);
    @UI: { lineItem:       [ { position: 80, importance: #HIGH } ]
         }
    @EndUserText.label: '品名'
    _ProductText.ProductName,
    @UI: { lineItem:       [ { position: 90, importance: #HIGH } ],
            selectionField: [{ position: 90 }]
         }
    @EndUserText.label: '工廠'
    @Consumption.valueHelpDefinition: [ { entity: { name: 'I_PlantStdVH', element: 'Plant' } }]
    @ObjectModel.text.element: ['PlantName']
    werks,//werks  : abap.char(4);
    @UI: { lineItem:       [ { position: 100, importance: #HIGH } ]
         }
    @EndUserText.label: '工廠名稱'
    _Plant.PlantName,
    @UI: { lineItem:       [ { position: 110, importance: #HIGH } ],
           selectionField: [{ position: 110 }]
         }
    @EndUserText.label: '儲存地點'
    @Consumption.valueHelpDefinition: [ { entity: { name: 'I_StorageLocation', element: 'StorageLocation' } }]
    lgort,//lgort  : abap.char(4);
    @UI: { lineItem:       [ { position: 120, importance: #HIGH } ]
         }
    @EndUserText.label: '儲存地點名稱'
    _StorageLocation.StorageLocationName,
    @UI: { lineItem:       [ { position: 130, importance: #HIGH } ],
         hidden:true
         }
    @EndUserText.label: '批次號碼'
    CHARG,//CHARG  : abap.char(20);
    @UI: { lineItem:       [ { position: 140, importance: #HIGH } ]
         }
    @EndUserText.label: '數量'
    @Semantics.quantity.unitOfMeasure: 'ERFME'
    ERFMG,//ERFMG  : abap.dec( 13,3);
    @UI: { 
          hidden:true
         }
    @EndUserText.label: '物料文件單位'
    erfme,//erfme :abap.unit(3);//物料文件單位
    @UI: { lineItem:       [ { position: 150, importance: #HIGH } ]
         }
    @EndUserText.label: '單位'
    _UnitOfMeasureText.UnitOfMeasureCommercialName,--'ERFME_CH'
    @UI: { lineItem:       [ { position: 160, importance: #HIGH } ]
         }
    @EndUserText.label: '幣別'
    WAERS,//WAERS  : abap.cuky(5);//幣別
    @UI: { lineItem:       [ { position: 170, importance: #HIGH } ]
         }
    @EndUserText.label: '淨價'
    @Semantics.amount.currencyCode:'WAERS'
    NETPR,//NETPR  : abap.dec( 13,2);
    @UI: { lineItem:       [ { position: 180, importance: #HIGH } ]
         }
    @EndUserText.label: '價格單位'
    PEINH,//PEINH  : abap.dec(5);
    @UI: { lineItem:       [ { position: 190, importance: #HIGH } ]
         }
    @EndUserText.label: '單價'
    @Semantics.amount.currencyCode:'WAERS'
    UPRICE,//UPRICE  : abap.dec(13,3);
    @UI: { lineItem:       [ { position: 200, importance: #HIGH } ]
         }
    @EndUserText.label: '採購金額'
    @Semantics.amount.currencyCode:'BWAER'
    WRBTR,//WRBTR  : abap.dec(13,2);
    @UI: { lineItem:       [ { position: 200, importance: #HIGH } ],
           hidden : true
         }
    @EndUserText.label: '採購歷史紀錄幣別'
    BWAER,//BWAER  : abap.cuky(5);//採購歷史紀錄幣別
    @UI: { lineItem:       [ { position: 210, importance: #HIGH } ]
         }
    @EndUserText.label: '預估金額本國幣'
    @Semantics.amount.currencyCode:'WAERS_LOC'
    DMBTR_E ,//DMBTR_E  : abap.dec( 13,2);//預估金額本國幣
    @UI: { lineItem:       [ { position: 220, importance: #HIGH } ]
         }
    @EndUserText.label: '預估交貨成本'
    @Semantics.amount.currencyCode:'WAERS_LOC'
    DMBTR_Z,//DMBTR_Z  : abap.dec( 13,2);//預估交貨成本
    @UI: { lineItem:       [ { position: 230, importance: #HIGH } ]
         }
    @EndUserText.label: '本國幣'
    WAERS_LOC ,//WAERS_LOC  : abap.cuky(5);//本國幣
    @UI: { lineItem:       [ { position: 240, importance: #HIGH } ],
         hidden:true
         }
    @EndUserText.label: '發票文件年度'
    GJAHR,//GJAHR  : abap.numc(4);//發票文件年度 4 or 8?
    @UI: { lineItem:       [ { position: 250, importance: #HIGH } ],
         hidden:true
         }
    @EndUserText.label: '本國幣'
    LWAER,//LWAER : abap.cuky(5);//本國幣
    @UI: { lineItem:       [ { position: 280, importance: #HIGH } ],
           selectionField: [{ position: 280 }]
         }
    @EndUserText.label: '採購組織'
    @Consumption.valueHelpDefinition: [ { entity: { name: 'I_PurchasingOrganization', element: 'PurchasingOrganization' } }]
    EKORG,//EKORG : abap.char(4);//採購組織
    @UI: { lineItem:       [ { position: 290, importance: #HIGH } ],
            selectionField: [{ position: 290 }]
         }
    @EndUserText.label: '採購文件類型'
    @Consumption.valueHelpDefinition: [ { entity: { name: 'I_PurchaseOrderType', element: 'PurchaseOrderType' } }]
    bsart,//bsart : abap.char(4);//採購文件類型
    @UI: { lineItem:       [ { position: 300, importance: #HIGH } ]
         }
    @EndUserText.label: '採購單文件日期'
    BEDAT,//BEDAT : abap.dats;//採購文件類型
    @UI: { lineItem:       [ { position: 310, importance: #HIGH } ]
         }
    @EndUserText.label: '預計交貨日'
    EINDT,//EINDT : abap.char(255);//預計交貨日
    @UI: { lineItem:       [ { position: 320, importance: #HIGH } ],
         selectionField: [{ position: 320 }]
         }
    @EndUserText.label: '明細刪除碼'
    LOEKZ,//LOEKZ : abap.char(1);//刪除指示碼
    @UI: { lineItem:       [ { position: 330, importance: #HIGH } ],
           selectionField: [{ position: 330 }]
         }
    @EndUserText.label: '退貨項目'
    RETOI,//RETOI : abap.char(1);//退貨項目 
    @UI: { lineItem:       [ { position: 340, importance: #HIGH } ],
         selectionField: [{ position: 340 }]
         }
    @EndUserText.label: '免費項目'
    UMSON,//UMSON : abap.char(1);//免費項目
    @UI: { lineItem:       [ { position: 350, importance: #HIGH } ]
         
         }
    @EndUserText.label: '已開票數量' 
    @Semantics.quantity.unitOfMeasure: 'BSTME'
    MENGE,//MENGE : abap.quan( 13, 3);//數量 rseg-menge
    @UI: { lineItem:       [ { position: 360, importance: #HIGH } ],
         hidden:true
         }
    @EndUserText.label: '單位' 
    bstme,
    @UI: { lineItem:       [ { position: 370, importance: #HIGH } ]
         }
    @EndUserText.label: '單位' 
    _UnitOfMeasureText2.UnitOfMeasureCommercialName as bstme_ch,//bstme_CH
    
    @UI: { lineItem:       [ { position: 380, importance: #HIGH } ]
         }
    @EndUserText.label: '幣別' 
    RWAER,//RWAER : abap.cuky(5);//幣別
    @UI: { lineItem:       [ { position: 390, importance: #HIGH } ]
         }
    @EndUserText.label: '發票金額' 
    @Semantics.amount.currencyCode:'rwaer'
    RWRBT,//RWRBT : abap.dec( 13,2);//發票金額
    @UI: { lineItem:       [ { position: 400, importance: #HIGH } ]
         }
    @EndUserText.label: '參考本國幣' 
    @Semantics.amount.currencyCode:'LWAER'
    LOCAL as local_money,//LOCAL : abap.dec( 13,2); //參考本國幣
    @UI: { lineItem:       [ { position: 410, importance: #HIGH } ]
         }
    @EndUserText.label: '發票文件號碼' 
    BELNR, // BELNR : abap.char(255);//發票文件號碼
    @UI: { lineItem:       [ { position: 420, importance: #HIGH } ]
         
         }
    @EndUserText.label: '發票文件日期' 
    BLDAT,//BLDAT : abap.char(255);//發票文件日期
    @UI: { lineItem:       [ { position: 430, importance: #HIGH } ]
        // selectionField: [{ position: 430 }]
         }
    @EndUserText.label: '發票過帳日期' 
    RBUDT,//RBUDT : abap.char(255);//發票過帳日期
    @UI: { lineItem:       [ { position: 440, importance: #HIGH } ]
         }
    @EndUserText.label: '參考' 
    XBLNR,//XBLNR : abap.char(255); // 參考
    @UI: { lineItem:       [ { position: 450, importance: #HIGH } ]
         }
    @EndUserText.label: '表頭內文' 
    BKTXT,//BKTXT : abap.char(255);//BKPF 表頭內文
    @UI: { lineItem:       [ { position: 460, importance: #HIGH } ],
         hidden:true
         }
    @EndUserText.label: '異動類型' 
    BWART,//BWART : abap.char(4);//異動類型
    @UI: { lineItem:       [ { position: 470, importance: #HIGH } ],
         hidden:true
         }
    @EndUserText.label: '異動類型說明' 
    _GoodsMovementTypeT.GoodsMovementTypeName,//異動類型說明 //btext
    @UI: { lineItem:       [ { position: 480, importance: #HIGH } ],
         hidden:true
         }
    @EndUserText.label: '庫存類型' 
    INSMK,// INSMK : abap.char(1);//庫存類型
    @UI: { lineItem:       [ { position: 490, importance: #HIGH } ],
         hidden:true
         }
    @EndUserText.label: '庫存類型說明' 
    INSMK_txt,//DDTEXT 庫存類型說明 
    @UI: { lineItem:       [ { position: 500, importance: #HIGH } ],
         hidden:true
         }
    @EndUserText.label: '特殊庫存' 
    SOBKZ,//SOBKZ : abap.char(1);//特殊庫存
    @UI: { lineItem:       [ { position: 510, importance: #HIGH } ],
         hidden:true
         }
    @EndUserText.label: '特殊庫存說明' 
    _InventorySpecialStockTypeT.InventorySpecialStockTypeName,//sotxt
    @UI: { lineItem:       [ { position: 520, importance: #HIGH } ],
         hidden:true
         }
    @EndUserText.label: '客戶' 
    kunnr, //kunnr :abap.char(10);
    @UI: { lineItem:       [ { position: 530, importance: #HIGH } ],
         hidden:true
         }
    @EndUserText.label: '銷售訂單-項目' 
    KDAUF,//KDAUF : abap.char(40);//銷售項目
    @UI: { lineItem:       [ { position: 540, importance: #HIGH } ]
         }
    @EndUserText.label: '訂單號碼' 
    AUFNR,//AUFNR : abap.char(12);//訂單號碼
    //ANLN1 : abap.char(12);//資產編號
    @UI: { lineItem:       [ { position: 550, importance: #HIGH } ]
         }
    @EndUserText.label: '總帳科目' 
    SAKTO,//SAKTO : abap.char(10);//總帳科目
    @UI: { lineItem:       [ { position: 560, importance: #HIGH } ],
         hidden:true
         }
    @EndUserText.label: '成本中心' 
    KOSTL,//KOSTL : abap.char(10);//成本中心
    @UI: { lineItem:       [ { position: 570, importance: #HIGH } ],
         hidden:true
         }
    @EndUserText.label: '成本中心說明' 
    _CostCenterText.CostCenterName,//KTEXT
    @UI: { lineItem:       [ { position: 580, importance: #HIGH } ],
         hidden:true
         }
    @EndUserText.label: '取消碼' 
    CANCEL, //CANCEL : abap.char(1);//取消碼
    @UI: { lineItem:       [ { position: 590, importance: #HIGH } ]
         }
    @EndUserText.label: '取消物料文件年度' 
    SJAHR,//SJAHR : abap.numc(4);//
    @UI: { lineItem:       [ { position: 600, importance: #HIGH } ],
         hidden:true
         }
    @EndUserText.label: '取消物料文件號碼' 
    SMBLN,//SMBLN : abap.char(10); //取消物料文件
    @UI: { lineItem:       [ { position: 610, importance: #HIGH } ],
         hidden:true
         }
    @EndUserText.label: '取消物料文件項目' 
    SMBLP,//SMBLP : abap.numc(4);//取消物料文件項目
    @UI: { lineItem:       [ { position: 620, importance: #HIGH } ],
         hidden:true
         }
    @EndUserText.label: '會計文件(物料)' 
    BKPF_MBLNR, //BKPF_MBLNR : abap.char(10);//會計文件(物料)
    @UI: { lineItem:       [ { position: 630, importance: #HIGH } ],
         hidden:true
         }
    @EndUserText.label: '會計文件(發票)' 
    BKPF_BELNR,//BKPF_BELNR : abap.char(255);//會計文件(發票)
    @UI: { lineItem:       [ { position: 640, importance: #HIGH } ],
         hidden:true
         }
    @EndUserText.label: '供應商物料號碼' 
    IDNLF,//IDNLF :abap.char(35);//供應商物料號碼
    @UI: { lineItem:       [ { position: 650, importance: #HIGH } ]
         }
    @EndUserText.label: '原始單價' 
    @Semantics.amount.currencyCode:'LWAER'
    KBETR,//KBETR :abap.dec( 14,3); //原始單價
    @UI: { lineItem:       [ { position: 650, importance: #HIGH } ]
         }
    @EndUserText.label: '原始金額' 
    @Semantics.amount.currencyCode:'LWAER'
    KWERT,//KWERT :abap.dec( 13,2); //原始金額
    @UI: { lineItem:       [ { position: 660, importance: #HIGH } ]
         }
    @EndUserText.label: '您的參考' 
    IHREZ,//IHREZ :abap.char(12);//您的參考 ekko
    @UI: { lineItem:       [ { position: 670, importance: #HIGH } ]
         }
    @EndUserText.label: '我們的參考' 
    UNSEZ,//UNSEZ :abap.char(12);//我們的參考 ekko    
    @UI: { lineItem:       [ { position: 680, importance: #HIGH } ]
         }
    @EndUserText.label: '計價數量' 
    @Semantics.quantity.unitOfMeasure: 'BSTME'
    BPMNG,//BPMNG : abap.quan( 13, 3);//數量 mseg-BPMNG
    @UI: { lineItem:       [ { position: 690, importance: #HIGH } ],
         hidden:true
         }
    @EndUserText.label: '計價單位' 
    BPRME,
    @UI: { lineItem:       [ { position: 700, importance: #HIGH } ]
         }
    @EndUserText.label: '計價單位' 
    _UnitOfMeasureText3.UnitOfMeasureCommercialName as BPRME_CH,//BPRME_CH
    @UI: { lineItem:       [ { position: 710, importance: #HIGH } ],
         hidden:true
         }
    @EndUserText.label: '物料文件表頭內文' 
    MBKTX,//MBKTX : abap.char(25);//物料文件表頭內文
    @UI: { lineItem:       [ { position: 720, importance: #HIGH } ],
         hidden:true
         }
    @EndUserText.label: '物料文件項目內文' 
    sgtxt,//sgtxt : abap.char(50);//物料文件項目內文
    @UI: { lineItem:       [ { position: 730, importance: #HIGH } ]
         }
    @EndUserText.label: '參考本國幣(借項)' 
    waers_s,//waers_s:abap.cuky(5);//參考本國幣(借項)
    @UI: { lineItem:       [ { position: 740, importance: #HIGH } ]
         }
    @EndUserText.label: '借項合計' 
    @Semantics.amount.currencyCode:'WAERS_S'
    dmbtr_s,//dmbtr_s:abap.dec( 13,2);//借方本國幣金額
    @UI: { lineItem:       [ { position: 750, importance: #HIGH } ]
         }
    @EndUserText.label: '後續借項發票文件號碼' 
    belnr_s,//belnr_s:abap.char(255);//後續借項發票文件號碼
    @UI: { lineItem:       [ { position: 760, importance: #HIGH } ]
         }
    @EndUserText.label: '後續借項發票文件日期' 
    BLDAT_S,// BLDAT_S:abap.dats;//後續借項發票文件日期
    @UI: { lineItem:       [ { position: 770, importance: #HIGH } ]
         }
    @EndUserText.label: '後續借項發票過帳日期' 
    BUDAT_S,//BUDAT_S:abap.dats;//後續借項發票過帳日期
    @UI: { lineItem:       [ { position: 780, importance: #HIGH } ]
         }
    @EndUserText.label: '後續借項會計文件號碼' 
    BKPF_BELNR_S,//BKPF_BELNR_S:abap.char(255);//後續借項會計文件號碼
    @UI: { lineItem:       [ { position: 790, importance: #HIGH } ]
         }
    @EndUserText.label: '後續借項發票供應商' 
    lifnr_s,// lifnr_s :abap.char(255);//後續借項發票供應商
    @UI: { lineItem:       [ { position: 800, importance: #HIGH } ]
         }
    @EndUserText.label: '參考本國幣(貸項)' 
    WAERS_H,//WAERS_H:abap.cuky(5);//參考本國幣(貸項)
    @UI: { lineItem:       [ { position: 810, importance: #HIGH } ]
         }
    @EndUserText.label: '貸項合計' 
    @Semantics.amount.currencyCode:'WAERS_H'
    DMBTR_H,//DMBTR_H:abap.dec( 13,2);//貸項合計
    @UI: { lineItem:       [ { position: 820, importance: #HIGH } ]
         }
    @EndUserText.label: '後續貸項發票文件號碼' 
    BELNR_H,//BELNR_H:abap.char( 255 );//後續貸項發票文件號碼
    @UI: { lineItem:       [ { position: 830, importance: #HIGH } ]
         }
    @EndUserText.label: '後續貸項發票文件日期' 
    BLDAT_H,//BLDAT_H:abap.char( 255 );//後續貸項發票文件日期
    @UI: { lineItem:       [ { position: 840, importance: #HIGH } ]
         }
    @EndUserText.label: '後續貸項發票文件日期' 
    BUDAT_H,//BUDAT_H:abap.char( 255 );//後續貸項發票過帳日期
    @UI: { lineItem:       [ { position: 850, importance: #HIGH } ]
         }
    @EndUserText.label: '後續貸項會計文件號碼' 
    BKPF_BELNR_H,//BKPF_BELNR_H:abap.char(255);//後續貸項會計文件號碼
    @UI: { lineItem:       [ { position: 860, importance: #HIGH } ]
         }
    @EndUserText.label: '後續貸項發票供應商' 
    lifnr_h,//lifnr_h:abap.char(255);//後續貸項發票供應商
    @UI: { lineItem:       [ { position: 870, importance: #HIGH } ]
         }
    @EndUserText.label: 'CN-含稅單價' 
    @Semantics.amount.currencyCode:'WAERS'
    CN_NETPR,//CN_NETPR:abap.dec( 13,2); //CN-含稅單價
    @UI: { lineItem:       [ { position: 880, importance: #HIGH } ]
         }
    @EndUserText.label: 'CN-含稅金額' 
    @Semantics.amount.currencyCode:'WAERS'
    CN_AMT,//CN_AMT:abap.dec( 13,2); //CN-含稅金額
//    @UI: { lineItem:       [ { position: 890, importance: #HIGH } ]
//         }
//    @EndUserText.label: '實際交貨發票' 
//    act_belnr,//act_belnr:abap.char( 255 );--實際交貨發票
//    @UI: { lineItem:       [ { position: 900, importance: #HIGH } ]
//         }
//    @EndUserText.label: '實際交貨發票文件日' 
//    act_bldat,// act_bldat:abap.char( 255 );--實際交貨發票文件日
//    @UI: { lineItem:       [ { position: 910, importance: #HIGH } ]
//         }
//    @EndUserText.label: '實際交貨發票過帳日' 
//    act_budat,//act_budat:abap.char( 255 );--實際交貨發票過帳日
//    @UI: { lineItem:       [ { position: 920, importance: #HIGH } ]
//         }
//    @EndUserText.label: '實際交貨發票供應商' 
//    act_lifnr,//act_lifnr:abap.char( 255 );--實際交貨發票供應商
//    @UI: { lineItem:       [ { position: 930, importance: #HIGH } ]
//         }
//    @EndUserText.label: '實際交貨發票合計' 
//     @Semantics.amount.currencyCode:'WAERS_LOC'
//    act_wrbtr,
    @UI: { lineItem:       [ { position: 940, importance: #HIGH ,hidden:true} ],
         selectionField: [{ position: 940 }]
    //     hidden:true    
         }
    @EndUserText.label: '科目指派種類' 
    knttp,
    @UI: { lineItem:       [ { position: 950, importance: #HIGH,hidden:true } ],
         selectionField: [{ position: 950 }]
      //   hidden:true
         }
    @EndUserText.label: '採購群組' --
    @Consumption.valueHelpDefinition: [ { entity: { name: 'I_PurchasingGroup', element: 'PurchasingGroup' } }]
    ekgrp //ekgrp :abap.char(3);
    //act_wrbtr:abap.dec(13,2);--實際交貨發票合計
    //DMBTR_ACTUAL,//DMBTR_ACTUAL:abap.dec( 13,2);//實際交貨成本
  //  TOTAL_COST:abap.dec( 13,2);//總成本
   // belnr_actual:abap.char(255);//實際交貨成本物料文件
    
   /* dmbtr  : abap.dec( 13,2);//物料文件金額 
    shkzg : abap.char(1);//借貸方指示碼 物料文件        
    //gjahr_s:abap.dats;*/
    
   
   // gjahr_h:abap.dats;

  /*  DMBTR_ACTUAL:abap.dec( 13,2);//實際交貨成本
    TOTAL_COST:abap.dec( 13,2);//總成本
    belnr_actual:abap.char(255);//實際交貨成本物料文件
    erfme :abap.unit(3);//物料文件單位
    kzbew :abap.char(1);
    KZZUG :abap.char(1);
    kzvbr :abap.char(1);
    
    kdpos :abap.numc(6);
    kokrs :abap.char(4);
    BPRME :abap.unit(3);//物料文件單位
    retpo :abap.char(1);
    
    po_werks:abap.char(4);
    knumv :abap.char(10);
    menge_po:abap.quan( 13, 3);//數量 
    shkzg_e:abap.char(1);
    shkzg_z:abap.char(1);
    mkpf_bladt: abap.dats; --物料文件日期
    bstme:abap.unit(3);--發票計量單位
    netpl:abap.dec(13,2);
    bkpf_mjahr:abap.dats;
    bkpf_gjahr:abap.dats;*/

}

