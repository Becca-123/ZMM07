CLASS zz1_cl_zmm07 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.
    CLASS-METHODS exec_zmm07 FOR TABLE FUNCTION ZZ1_TF_ZMM07_PROCESS.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZZ1_CL_ZMM07 IMPLEMENTATION.


    METHOD exec_zmm07 BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT
                                                OPTIONS READ-ONLY
                                                USING ZZ1_I_ZMM07_INVO
                                                      ZZ1_I_ZMM07
                                                      ZZ1_I_ZMM07_rseg
                                                      zz1_I_CompanyCode
                                                      ZZ1_I_PurOrdItmPricingElement
                                                      ZZ1_I_PurOrdHistDeliveryCost
*                                                      I_PurchaseOrdScheduleLineTP_2
                                                      ZZ1_I_MaterialDocumentItem_2
                                                      ZZ1_I_Customer
                                                      ZZ1_I_currency
                                                      ZZ1_I_JournalEntry02.
                                                   --   ZZ1_I_ZMM07_2.
                                                   --   I_SuplrInvcItemPurOrdRefAPI01.

            declare lt_list table(
                                    client varchar(3),
                                    bukrs  varchar(4),
                                    ebeln  varchar(10),
                                    lifnr  varchar(10),
                                    budat  varchar(8),--?
                                    mblnr  varchar(10),
                                    mkpf_bldat varchar(8),
                                    zeile  varchar(4),
                                    matnr  varchar(40),
                                  -- txz01  : abap.char(20);
                                    werks  varchar(4),
                                    lgort  varchar(4),
                                    charg  varchar(10),
                                    erfmg  decimal(13,3),
                                  --  erfme_ch  : abap.char(20); //單位
                                    waers  varchar(5),--幣別
                                    netpr  decimal(13,2),
                                    peinh  decimal(5),
                                    uprice decimal(13,3),
                                    wrbtr  decimal(13,2),
                                    bwaer  varchar(5),--幣別
                                    dmbtr  decimal(13,2),--物料文件金額
                                    dmbtr_e  decimal(13,2),--預估金額本國幣
                                    dmbtr_z  decimal(13,2),--預估交貨成本
                                    waers_loc  varchar(5),--本國幣
                                    mjahr  varchar(4),--物料文件年度  4 or 8?
                                    gjahr  varchar(4),--發票文件年度 4 or 8?
                                    lwaer  varchar(5),--本國幣
                                    shkzg  varchar(1),--借貸方指示碼
                                   -- ebeln varchar(20),;
                                    ebelp varchar(5),
                                    ekorg varchar(4),--採購組織
                                    bsart varchar(4),--採購文件類型
                                    bedat varchar(8),--採購文件類型
                                    eindt varchar(255),--預計交貨日
                                    loekz varchar(1),--刪除指示碼
                                    retoi varchar(1),--退貨項目
                                    umson varchar(1),--免費項目
                                    menge decimal(13,3),--數量 rseg-menge
                                    --bstme_ch varchar(3),--單位(中文)
                                    rwaer varchar(5),--幣別
                                    rwrbt decimal(13,2),--發票金額
                                    local decimal(13,2), --發票金額本國幣
                                    belnr varchar(255),--發票文件號碼
                                    bldat varchar(255),--發票文件日期
                                    rbudt varchar(255),--發票過帳日期
                                    xblnr varchar(255), -- 參考
                                    bktxt varchar(255),--bkpf 表頭內文
                                    bwart varchar(4),--異動類型
                                    insmk varchar(1),--庫存類型
                                    insmk_txt varchar( 255 ),--庫存類型說明
                                    sobkz varchar(1),--特殊庫存
                                    kdauf varchar(40),--銷售項目
                                    aufnr varchar(12),--訂單號碼
                                    anln1 varchar(12),--資產編號
                                    sakto varchar(10),--總帳科目
                                    kostl varchar(10),--成本中心
                                    cancel varchar(1),--取消碼
                                    sjahr varchar(4),--取消物料文件年度
                                    smbln varchar(10), --取消物料文件
                                    smblp varchar(4),--取消物料文件項目
                                    bkpf_mblnr varchar(10),--會計文件(物料)
                                    bkpf_belnr varchar(255),--會計文件(發票)
                                    idnlf varchar(35),--供應商物料號碼
                                    kbetr decimal(14,3), --原始單價
                                    kwert decimal(13,2), --原始金額
                                    ihrez varchar(30),--您的參考 ekko
                                    unsez varchar(30),--我們的參考 ekko
                                    bpmng decimal(13,3),--數量 mseg-bpmng
                                    mbktx varchar(255),--物料文件表頭內文
                                    sgtxt varchar(255),--物料文件項目內文
                                    waers_s varchar(5),--借方本國幣金額 幣別?
                                    dmbtr_s decimal(13,2),--借方本國幣金額
                                    belnr_s varchar(255),--後續借項發票文件號碼
                                    bldat_s varchar(255),--後續借項發票文件日期
                                    budat_s varchar(255),--後續借項發票過帳日期
                                    gjahr_s VARCHAR( 4 ),--後續借項年度
                                    bkpf_belnr_s varchar(255),--後續借項會計文件號碼
                                    lifnr_s VARCHAR ( 255 ),--後續借項發票供應商
                                    waers_h varchar(5),--參考本國幣(貸項)
                                    dmbtr_h decimal(13,2),--貸項合計
                                    belnr_h varchar(255),--後續貸項發票文件號碼
                                    bldat_h varchar(255),--後續貸項發票文件日期
                                    budat_h varchar(255),--後續貸項發票過帳日期
                                    gjahr_h varchar( 4 ),--後續貸項年度
                                    bkpf_belnr_h varchar(255),--後續貸項會計文件號碼
                                    lifnr_h VARCHAR( 255 ),--後續貸項發票供應商
                                    cn_netpr decimal(13,2), --cn-含稅單價
                                    cn_amt decimal(13,2), --cn-含稅金額
                                    dmbtr_actual decimal(13,2),--實際交貨成本
                                    total_cost decimal(13,2),--總成本
                                    belnr_actual varchar(255),--實際交貨成本物料文件
                                    erfme varchar( 3),
                                    kzbew  varchar(1),
                                    KZZUG varchar( 1),
                                    kzvbr varchar( 1),
                                    kunnr varchar( 46),
                                    kdpos varchar (6),
                                    kokrs varchar (4),
                                    BPRME varchar (3),
                                    retpo varchar (1),
                                    ekgrp varchar (3),
                                    po_werks varchar( 4),
                                    knumv varchar( 10),
                                    menge_po decimal(13,3),
                                    shkzg_e varchar(1),
                                    shkzg_z varchar(1),
                                    mkpf_bladt varchar(8) ,--物料文件日期
                                    bstme varchar( 3),
                                    netpl decimal(13,2),
                                    bkpf_mjahr VARCHAR( 4),
                                    bkpf_gjahr VARCHAR ( 4 ),
                                    act_belnr varchar( 255 ),
                                    act_lifnr varchar( 255 ),
                                    act_bldat varchar( 255 ),
                                    act_budat varchar( 255 ),
                                    act_wrbtr decimal(13,2),
                                    knttp VARCHAR ( 1 ) --科目指派種類
                                                   );
            --紀錄筆數
            DECLARE l_count_main INTEGER;--總筆數
            DECLARE l_count_invo INTEGER;--invo筆數
            DECLARE l_count_rseg INTEGER;--resg筆數
            DECLARE l_count_ekbz INTEGER;--EKBZ迴圈
            DECLARE l_count_eket INTEGER;--EKET
            DECLARE l_count_rbkp INTEGER;-- RBKP、RSEG發票
            DECLARE l_count INTEGER;-- RBKP、RSEG發票
            DECLARE l_count_invo2 INTEGER;
            DECLARE l_shift INTEGER;
            DECLARE l_count_main2 INTEGER;--總筆數
            --index
            DECLARE l_indx_main INTEGER;--迴圈用index
            DECLARE l_indx_invo INTEGER;--迴圈用index
            DECLARE l_indx_rseg INTEGER;--迴圈用index
            DECLARE l_indx_ekbz INTEGER;--迴圈用index
            DECLARE l_indx_eket INTEGER;--迴圈用index
            DECLARE l_indx_rbkp INTEGER;--迴圈用index
            DECLARE l_indx_belnr INTEGER;--迴圈用index
            DECLARE l_indx_invo2 INTEGER;--迴圈用index
            DECLARE l_indx_main2 INTEGER;--迴圈用index
            --變數
            DECLARE l_waers VARCHAR(5);
            DECLARE l_kbetr decimal(11,2);
            DECLARE l_kwert decimal(11,2);
            DECLARE l_kpein decimal(5);
            DECLARE l_ebeln varchar( 10);
            DECLARE l_ebelp varchar( 5);
            DECLARE l_knumv varchar( 10);
            DECLARE l_menge_po decimal(13,3);
            DECLARE l_mjahr varchar( 4);
            DECLARE l_mblnr varchar(10);
            DECLARE l_zeile varchar(4);
            DECLARE l_shkzg_e varchar(1);
            DECLARE l_shkzg_z VARCHAR( 1);
            DECLARE l_sum_dmbtr decimal(11,2);
            DECLARE l_str VARCHAR( 255);
            DECLARE l_str2 VARCHAR( 255);
            DECLARE l_belnr VARCHAR( 255 );
            DECLARE l_bldat VARCHAR( 255);
            DECLARE l_budat VARCHAR( 255 );
            DECLARE l_xblnr VARCHAR( 255 );
            DECLARE l_bktxt VARCHAR( 255 );
            DECLARE l_waers2 VARCHAR( 5 );
            DECLARE l_menge_rbkp decimal(13,3);
            DECLARE l_wrbtr_rbkp decimal(13,2);
            DECLARE l_local_rbkp decimal(13,2);
            DECLARE l_bstme_rbkp VARCHAR(5 );
            DECLARE l_waers_rbkp VARCHAR(5 );
            DECLARE l_gjahr_rbkp VARCHAR(5 );
            DECLARE l_smbln VARCHAR(10 );
            DECLARE l_smblp VARCHAR( 4 );
            DECLARE l_sjahr VARCHAR( 4 );
            DECLARE l_name1_cus varchar(80);
            DECLARE l_kunnr varchar(10);
            DECLARE l_kunnr_str VARCHAR(100);
            DECLARE l_awkey VARCHAR(20);
            DECLARE l_belnr_bkpf VARCHAR(10);
            DECLARE l_gjahr_bkpf VARCHAR( 4);
            DECLARE lt_belnr TABLE (belnr varchar(10));
            DECLARE l_gjahr VARCHAR( 4);
            DECLARE l_gjahr_str VARCHAR( 4 );
            DECLARE l_belnr_str VARCHAR ( 255 );
            DECLARE l_bukrs VARCHAR (4);
            DECLARE l_waers_s VARCHAR( 5);
            DECLARE l_waers_h VARCHAR( 5);
            DECLARE l_bldat_s varchar(8 );
            DECLARE l_bldat_s_str varchar( 255 );
            DECLARE l_budat_s varchar(8 );
            DECLARE l_budat_s_str varchar( 255 );
            DECLARE l_lifnr_s_str VARCHAR ( 255 );
            DECLARE l_bldat_h varchar(8 );
            DECLARE l_bldat_h_str varchar( 255 );
            DECLARE l_budat_h varchar(8 );
            DECLARE l_budat_h_str varchar( 255 );
            DECLARE l_belnr_s_str VARCHAR ( 255 );
            DECLARE l_belnr_h_str VARCHAR ( 255 );
            DECLARE l_lifnr_h_str VARCHAR( 255 );
            DECLARE l_year VARCHAR ( 4 );
            DECLARE l_wrbtr_rseg decimal( 13,2 );
            DECLARE l_sum_s decimal( 13,2 );
            DECLARE l_sum_h decimal( 13,2 );
            DECLARE l_belnr_rseg_str VARCHAR( 255);
            DECLARE l_lifnr_rseg_str VARCHAR ( 255);
            DECLARE l_bldat_rseg_str VARCHAR( 255 );
            DECLARE l_budat_rseg_str VARCHAR( 255 );
            DECLARE l_lwear VARCHAR ( 5 );--公司幣別
            DECLARE l_decimal INTEGER;
            lt_invo = SELECT * FROM zz1_I_zmm07_invo ;
            lt_main = SELECT * FROM zz1_i_zmm07;
            lt_resg = SELECT * FROM zz1_i_zmm07_rseg;
            --lt_main2 = SELECT  MaterialDocumentYear,MaterialDocument,PurchaseOrder ,PurchaseOrderItem,SUM( PurchaseOrderAmount )
            --  FROM ZZ1_I_Zmm07_2 GROUP BY MaterialDocumentYear,MaterialDocument,PurchaseOrder ,PurchaseOrderItem;
          --  SELECT count( * ) INTO l_count_main2 FROM :lt_main2;
            l_count = 1;
            SELECT COUNT (*) INTO l_count_invo FROM :lt_invo;
            SELECT COUNT(*) INTO l_count_main FROM :lt_main;--主要資料迴圈計數器
            --ConditionType = kschl
            FOR l_indx_main IN 1..l_count_main DO
                lt_list.client[l_indx_main] = p_client;
                lt_list.waers_loc[l_indx_main] = :lt_main.CompanyCodeCurrency[l_indx_main];--公司幣別
                lt_list.lifnr [l_indx_main] = :lt_main.Supplier[l_indx_main];--供應商
                lt_list.budat[l_indx_main] = :lt_main.PostingDate[l_indx_main];--過帳日
                lt_list.mblnr[l_indx_main] = :lt_main.MaterialDocument[l_indx_main];--物料文件
                lt_list.mjahr[l_indx_main] = :lt_main.MaterialDocumentYear[l_indx_main];--物料文件年度
                lt_list.zeile[l_indx_main] = :lt_main.MaterialDocumentItem[l_indx_main];--物料文件項目
                lt_list.matnr[l_indx_main] = :lt_main.Material[l_indx_main];--物料
                lt_list.werks[l_indx_main] = :lt_main.Plant[l_indx_main];--工廠
                lt_list.dmbtr[l_indx_main] = :lt_main.TotalGoodsMvtAmtInCCCrcy[l_indx_main];--金額〈本國貨幣) 物料文件
                lt_list.lgort[l_indx_main] = :lt_main.StorageLocation[l_indx_main];--儲存地點
                lt_list.charg[l_indx_main] = :lt_main.Batch[l_indx_main];--批次 ( 物料文件)
                lt_list.erfmg[l_indx_main] = :lt_main.QuantityInEntryUnit[l_indx_main];--以輸入單位表示的數量 ( 物料文件)
                lt_list.shkzg[l_indx_main] = :lt_main.DebitCreditCode[l_indx_main];--借/貸方指示碼 物料文件
                lt_list.erfme[l_indx_main] = :lt_main.EntryUnit[l_indx_main];--輸入單位 物料文件
                lt_list.waers[l_indx_main] = :lt_main.DocumentCurrency[l_indx_main];--採購單幣別
                lt_list.netpr[l_indx_main] = :lt_main.NetPriceAmount[l_indx_main];--NEPTR 採購單明細 淨值 ( 文件幣別)
                lt_list.peinh[l_indx_main] = :lt_main.NetPriceQuantity[l_indx_main];--peinh 價格單位 每 採購單明細
                lt_list.wrbtr[l_indx_main] = :lt_main.PurchaseOrderAmount[l_indx_main];--wrbtr 採購歷史紀錄 金額
                lt_list.bwaer[l_indx_main] = :lt_main.Currency[l_indx_main];--採購歷史紀錄幣別
                lt_list.ebeln[l_indx_main] = :lt_main.PurchaseOrder[l_indx_main];--採購單號
                lt_list.ebelp[l_indx_main] = :lt_main.PurchaseOrderItem[l_indx_main];--採購單
                lt_list.bwart[l_indx_main] = :lt_main.GoodsMovementType[l_indx_main];--異動類型 物料文件明細
                lt_list.kzbew[l_indx_main] = :lt_main.GoodsMovementRefDocType[l_indx_main];--異動指示碼 物料文件明戲
                lt_list.KZZUG[l_indx_main] = :lt_main.GoodsReceiptType[l_indx_main];--收貨指示碼 物料文件明戲
                lt_list.kzvbr[l_indx_main] = :lt_main.ConsumptionPosting[l_indx_main];--耗用過帳 物料文件明細
                lt_list.insmk[l_indx_main] = :lt_main.InventoryUsabilityCode[l_indx_main];--庫存類型  物料文件明細
                lt_list.sobkz[l_indx_main] = :lt_main.InventorySpecialStockType[l_indx_main];--特殊庫存指示碼 物料文件明細
                lt_list.kunnr[l_indx_main] = :lt_main.Customer[l_indx_main];--客戶 物料文件明細
                lt_list.kdauf[l_indx_main] = :lt_main.SalesOrder[l_indx_main];--銷售訂單號碼 物料文件明細
                lt_list.kdpos[l_indx_main] = :lt_main.SalesOrderItem[l_indx_main];--銷售訂單中的項目號碼 物料文件明細
                lt_list.aufnr[l_indx_main] = :lt_main.ManufacturingOrder[l_indx_main];--訂單號碼 物料文件明細
                lt_list.sakto[l_indx_main] = :lt_main.GLAccount[l_indx_main];--sakto 總帳科目號碼 物料文件明細
                lt_list.kostl[l_indx_main] = :lt_main.CostCenter[l_indx_main];--成本中心 物料文件明細
                lt_list.kokrs[l_indx_main] = :lt_main.ControllingArea[l_indx_main];--成本控制範圍 物料文件明細
                lt_list.sjahr[l_indx_main] = :lt_main.ReversedMaterialDocumentYear[l_indx_main];--物料文件年度 ( 迴轉文件) 物料文件明細
                lt_list.SMBLN[l_indx_main] = :lt_main.ReversedMaterialDocument[l_indx_main];--物料文件號碼 ( 迴轉文件) 物料文件明細
                lt_list.SMBLP[l_indx_main] = :lt_main.ReversedMaterialDocumentItem[l_indx_main];--物料文件項目 ( 迴轉文件) 物料文件明細
                lt_list.bukrs[l_indx_main] = :lt_main.CompanyCode[l_indx_main];--公司號碼 物料文件明細
                lt_list.bpmng[l_indx_main] = :lt_main.QtyInPurchaseOrderPriceUnit[l_indx_main];--採購單計價單位的數量 物料文件明細
                lt_list.BPRME[l_indx_main] = :lt_main.OrderPriceUnit[l_indx_main];--採購單的計價單位〈採購〉 物料文件明細
                lt_list.loekz[l_indx_main] = :lt_main.PurchasingDocumentDeletionCode[l_indx_main];--刪除指示碼 採購單明細
                lt_list.retpo[l_indx_main] = :lt_main.IsReturnsItem[l_indx_main];--退貨項目 採購單明細
                lt_list.BEDAT[l_indx_main] = :lt_main.PurchaseOrderDate[l_indx_main];--採購文件日期 採購單表頭
                lt_list.ekorg[l_indx_main] = :lt_main.PurchasingOrganization[l_indx_main];--採購組織 採購單表頭
                lt_list.ekgrp[l_indx_main] = :lt_main.PurchasingGroup[l_indx_main];--採購群組 採購單表頭
                lt_list.bsart[l_indx_main] = :lt_main.PurchaseOrderType[l_indx_main];--採購文件類型 採購單表頭
                lt_list.po_werks[l_indx_main] = :lt_main.po_plant[l_indx_main];--採購單工廠 採購單明細
                lt_list.idnlf[l_indx_main] = :lt_main.SupplierMaterialNumber[l_indx_main];--供應商所使用的物料號碼 採購單明細
                lt_list.knumv[l_indx_main] = :lt_main.PricingDocument[l_indx_main];--文件條件號碼 採購單表頭
                lt_list.ihrez[l_indx_main] = :lt_main.CorrespncExternalReference[l_indx_main];--您的參考 採購單表頭
                lt_list.unsez[l_indx_main] = :lt_main.CorrespncInternalReference[l_indx_main];--我們的參考 採購單表頭
                lt_list.mbktx[l_indx_main] = :lt_main.MaterialDocumentHeaderText[l_indx_main];--文件表頭內文 物料文件表頭
                lt_list.sgtxt[l_indx_main] = :lt_main.MaterialDocumentItemText[l_indx_main];--物料文件明細內文 物料文件明細
                lt_list.menge_po[l_indx_main] = :lt_main.OrderQuantity[l_indx_main];--採購單數量 採購單明細
                lt_list.dmbtr_e[l_indx_main] = :lt_main.PurOrdAmountInCompanyCodeCrcy[l_indx_main];--採購歷史紀錄 金額
                lt_list.shkzg_e[l_indx_main] = :lt_main.po_DebitCreditCode[l_indx_main];--借/貸方指示碼 採購歷史紀錄
                lt_list.mkpf_bldat[l_indx_main] = :lt_main.DocumentDate[l_indx_main];--物料文件日期
                lt_list.bktxt[l_indx_main] = :lt_main.MaterialDocumentHeaderText[l_indx_main];
                lt_list.ekgrp[l_indx_main] = :lt_main.PurchasingGroup[l_indx_main];--採購群組
                lt_list.knttp[ l_indx_main ] = :lt_main.AccountAssignmentCategory[l_indx_main];--科目指派種類
                l_ebeln = :lt_list.ebeln[l_indx_main];
                l_ebelp = :lt_list.ebelp[l_indx_main];
                l_knumv = :lt_list.knumv[l_indx_main];
                l_mjahr = :lt_list.mjahr[l_indx_main];
                l_mblnr = :lt_list.mblnr[l_indx_main];
                l_zeile = :lt_list.zeile[l_indx_main];
                l_shkzg_e = :lt_list.shkzg_e[l_indx_main];
                l_shkzg_z = :lt_list.shkzg_z[l_indx_main];
                l_smbln = :lt_list.smbln[l_indx_main];
                l_smblp = :lt_list.smblp[l_indx_main];
                l_sjahr = :lt_list.sjahr[l_indx_main];
                l_kunnr = :lt_list.kunnr[l_indx_main];

                --原始單價&金額
                IF EXISTS( SELECT * FROM  ZZ1_I_PurOrdItmPricingElement WHERE PurchaseOrder = l_ebeln
                    AND PurchaseOrderItem = l_ebelp AND PricingDocument = l_knumv  AND ConditionType = 'PPR0'  ) THEN
                    SELECT TOP 1 ConditionRateValue,ConditionCurrency,ConditionQuantity,ConditionAmount
                     INTO l_kbetr , l_waers , l_kpein,l_kwert
                     FROM ZZ1_I_PurOrdItmPricingElement
                      WHERE PurchaseOrder = l_ebeln AND PurchaseOrderItem = l_ebelp
                      AND PricingDocument = l_knumv AND ConditionType = 'PPR0';
                     lt_list.kbetr[l_indx_main] = l_kbetr / l_kpein;--原始單價
                     lt_list.kwert[l_indx_main] = :lt_list.kbetr[l_indx_main] * :lt_list.bpmng[l_indx_main];--原始金額

                ELSE
                    IF EXISTS( SELECT * FROM  ZZ1_I_PurOrdItmPricingElement WHERE PurchaseOrder = l_ebeln
                        AND PurchaseOrderItem = l_ebelp AND PricingDocument = l_knumv  AND ConditionType = 'PPR0'  ) THEN
                        SELECT TOP 1 ConditionRateValue,ConditionCurrency,ConditionQuantity,ConditionAmount
                          INTO l_kbetr , l_waers , l_kpein,l_kwert
                          FROM ZZ1_I_PurOrdItmPricingElement
                          WHERE PurchaseOrder = l_ebeln AND PurchaseOrderItem = l_ebelp
                          AND PricingDocument = l_knumv AND ConditionType = 'PPR0';
                        if l_kpein IS NOT NULL AND l_kbetr IS NOT NULL THEN
                          lt_list.kbetr[l_indx_main] = l_kbetr / l_kpein;--原始單價
                          lt_list.kwert[l_indx_main] = :lt_list.kbetr[l_indx_main] * :lt_list.bpmng[l_indx_main];
                        ELSE
                          --lt_list.kbetr[l_indx_main] = 0 ;
                          --lt_list.kwert[l_indx_main] = 0 ;
                        END IF;
                    END IF;
                END IF;
                l_menge_po = :lt_list.menge_po[l_indx_main];
                IF l_menge_po IS NOT NULL AND l_menge_po != '0' THEN
                    lt_list.cn_netpr[l_indx_main] = l_kwert / l_menge_po ;--CN含稅單價
                ELSE
                    lt_list.cn_netpr[l_indx_main] = l_kwert ;--konv.kwert CN-原始金額
                END IF;
                --單價一率轉正
                IF :lt_list.cn_netpr[l_indx_main] < 0 AND :lt_list.cn_netpr[l_indx_main] IS NOT NULL THEN
                    lt_list.cn_netpr[l_indx_main] = :lt_list.cn_netpr[l_indx_main] * -1;
                END IF;
              --  SELECT TOP 1 ValuationClass INTO l_bklas FROM I_ProductValuationBasic WHERE
                IF :lt_list.cn_netpr[l_indx_main] IS NOT NULL AND :lt_list.erfmg[l_indx_main] IS NOT NULL THEN --CN-含稅金額
                    lt_list.cn_amt[l_indx_main] = :lt_list.cn_netpr[l_indx_main] * :lt_list.erfmg[l_indx_main];
                END IF;

                --讀去交貨成本資料
                lt_ekbz = SELECT * FROM ZZ1_I_PurOrdHistDeliveryCost
                            WHERE PurchaseOrder = l_ebeln AND PurchaseOrderItem = l_ebelp
                            AND PurchasingHistoryDocumentYear = l_mjahr AND PurchasingHistoryDocument = l_mblnr
                            AND PurchasingHistoryDocumentItem = l_zeile AND  PurchasingHistoryDocumentType = '1';
                IF EXISTS(  SELECT * FROM ZZ1_I_PurOrdHistDeliveryCost--是否讀的到資料
                              WHERE PurchaseOrder = l_ebeln AND PurchaseOrderItem = l_ebelp
                              AND PurchasingHistoryDocumentYear = l_mjahr AND PurchasingHistoryDocument = l_mblnr
                              AND PurchasingHistoryDocumentItem = l_zeile AND  PurchasingHistoryDocumentType = '1' ) then
                    SELECT TOP 1 DebitCreditCode INTO l_shkzg_z
                        FROM ZZ1_I_PurOrdHistDeliveryCost
                        WHERE PurchaseOrder = l_ebeln AND PurchaseOrderItem = l_ebelp
                        AND PurchasingHistoryDocumentYear = l_mjahr AND PurchasingHistoryDocument = l_mblnr
                        AND PurchasingHistoryDocumentItem = l_zeile AND  PurchasingHistoryDocumentType = '1';
                END IF ;
                SELECT COUNT(*) INTO l_count_ekbz FROM :lt_ekbz ;--交貨成本
                --計算交貨成本
                FOR l_indx_ekbz IN 1..l_count_ekbz DO
                    l_sum_dmbtr = l_sum_dmbtr + :lt_ekbz.PurOrdAmountInCompanyCodeCrcy[l_indx_ekbz ];
                END FOR;
                --借貸項正負號
                IF l_sum_dmbtr IS NOT NULL  AND l_shkzg_z = 'S' THEN
                    l_sum_dmbtr = l_sum_dmbtr * -1;
                    lt_list.dmbtr_z[l_indx_main] = l_sum_dmbtr;
                END IF;
                --借貸項正負號
                IF :lt_list.dmbtr_e[l_indx_main] IS NOT NULL AND :lt_list.shkzg_e[l_indx_main] = 'H' THEN
                    lt_list.dmbtr_e[l_indx_main] = :lt_list.dmbtr_e[l_indx_main] * -1;
                END IF;
              --  ScheduleLineDeliveryDate --eindt
*                lt_eket = select * FROM I_PurchaseOrdScheduleLineTP_2
*                            WHERE PurchaseOrder = l_ebeln AND PurchaseOrderItem = l_ebelp;
*                SELECT count(*) INTO l_count_eket FROM :lt_eket;
*                --項目交貨日
*                l_str = null;
*                l_str2 = null;
*                FOR l_indx_eket IN 1..l_count_eket DO
*                    IF l_str IS NOT NULL THEN--字串拼接
*                        l_str2 = concat(',',:lt_eket.ScheduleLineDeliveryDate[l_indx_eket] );
*                        l_str = concat( l_str,l_str2);
*                    ELSE
*                        l_str = :lt_eket.ScheduleLineDeliveryDate[l_indx_eket];
*                    END IF;
*                END FOR;
*                lt_list.eindt[l_indx_main] = l_str;
                --單價
                IF :lt_list.peinh[l_indx_main] IS NOT NULL THEN
                    IF :lt_list.peinh[l_indx_main] <> 0 THEN
                        lt_list.uprice[l_indx_main] = :lt_list.netpr[l_indx_main] / :lt_list.peinh[l_indx_main] ;
                    ELSE
                        lt_list.uprice[l_indx_main] = null;
                    END IF;
                END IF;

                --免費項目
                IF :lt_list.netpr[l_indx_main] IS NULL OR :lt_list.netpr[l_indx_main] = 0 THEN
                    lt_list.umson[l_indx_main] = 'X';
                END IF;

                IF :lt_list.wrbtr[l_indx_main] IS NULL AND :lt_list.peinh[l_indx_main] IS NOT NULL THEN
                    IF :lt_list.erfmg[l_indx_main] IS NOT NULL AND :lt_list.netpr[l_indx_main] IS NOT NULL THEN
                        lt_list.wrbtr[l_indx_main] = (  :lt_list.erfmg[l_indx_main] * :lt_list.netpr[l_indx_main] ) / :lt_list.peinh[l_indx_main];
                    END IF;
                END IF;
                IF :lt_list.shkzg[l_indx_main] = 'H' THEN
                    IF :lt_list.erfmg[l_indx_main] IS NOT NULL THEN --正負顛倒
                       lt_list.erfmg[l_indx_main] = 0 - :lt_list.erfmg[l_indx_main];
                    END IF;
                    IF :lt_list.wrbtr[l_indx_main] IS NOT NULL THEN --正負顛倒
                        lt_list.wrbtr[l_indx_main] = 0 - :lt_list.wrbtr[l_indx_main];
                    END IF;
                    IF :lt_list.kwert[l_indx_main] IS NOT NULL THEN --正負顛倒
                        lt_list.kwert[l_indx_main] = 0 - :lt_list.kwert[l_indx_main];--原始金額
                    END IF;
                    IF :lt_list.cn_amt[l_indx_main] IS NOT NULL THEN --正負顛倒
                        lt_list.cn_amt[l_indx_main] = 0 - :lt_list.cn_amt[l_indx_main];--CN-含稅金額
                    END IF;
                END IF;
                lt_rbkp = SELECT * FROM ZZ1_I_ZMM07_rseg
                                    WHERE ReferenceDocument = l_mblnr
                                    AND ReferenceDocumentFiscalYear = l_mjahr
                                    AND ReferenceDocumentItem = l_zeile;
               --改以採購單為核心專取 發票文件
*                lt_rbkp = SELECT * FROM ZZ1_I_ZMM07_rseg
*                                    WHERE PurchaseOrder = l_ebeln
*                                    AND PurchaseOrderItem = l_ebelp
*                                    AND FiscalYear = l_mjahr;
                SELECT COUNT(*) INTO l_count_rbkp FROM :lt_rbkp ;
                l_belnr = null;
                l_bldat = null;
                l_budat = null;
                l_menge_rbkp = null;
                l_wrbtr_rbkp = null;
                l_local_rbkp = null;
                FOR l_indx_rbkp IN 1..l_count_rbkp DO
                    lt_belnr.belnr[l_indx_rbkp] =  :lt_rbkp.SupplierInvoice[l_indx_rbkp];
                    IF l_belnr IS NOT NULL THEN
                        l_belnr = concat ( l_belnr ,',');
                        l_belnr = concat ( l_belnr , :lt_rbkp.SupplierInvoice[l_indx_rbkp]);
                    ELSE
                       l_belnr = :lt_rbkp.SupplierInvoice[l_indx_rbkp];
                    END IF ;

                    IF l_bldat IS NOT NULL THEN
                        l_bldat = concat ( l_bldat ,',');
                        l_bldat = concat ( l_bldat , :lt_rbkp.DocumentDate[l_indx_rbkp]);
                    ELSE
                       l_bldat = :lt_rbkp.DocumentDate[l_indx_rbkp];
                    END IF ;
                    IF l_budat IS NOT NULL THEN
                        l_budat = concat ( l_budat ,',');
                        l_budat = concat ( l_budat , :lt_rbkp.PostingDate[l_indx_rbkp]);
                    ELSE
                       l_budat = :lt_rbkp.PostingDate[l_indx_rbkp];
                    END IF ;

                    IF :lt_rbkp.DebitCreditCode[l_indx_rbkp] = 'H' THEN
                        IF l_wrbtr_rbkp  IS NOT NULL THEN
                            l_wrbtr_rbkp = l_wrbtr_rbkp - :lt_rbkp.SupplierInvoiceItemAmount[l_indx_rbkp];
                        ELSE
                            l_wrbtr_rbkp = 0 - :lt_rbkp.SupplierInvoiceItemAmount[l_indx_rbkp];
                        END IF ;
                        IF l_menge_rbkp IS NOT NULL THEN
                            l_menge_rbkp = l_menge_rbkp - :lt_rbkp.QuantityInPurchaseOrderUnit[l_indx_rbkp];
                        ELSE
                            l_menge_rbkp = 0 - :lt_rbkp.QuantityInPurchaseOrderUnit[l_indx_rbkp];
                        END IF ;
                        IF l_local_rbkp IS NOT NULL THEN
                            l_local_rbkp = l_local_rbkp - :lt_rbkp.SupplierInvoiceItemAmount[l_indx_rbkp];
                        ELSE
                            l_local_rbkp = 0 -  :lt_rbkp.SupplierInvoiceItemAmount[l_indx_rbkp];
                        END IF;
                    END IF;
                    IF :lt_rbkp.DebitCreditCode[l_indx_rbkp] = 'S' THEN
                        IF l_wrbtr_rbkp  IS NOT NULL THEN
                            l_wrbtr_rbkp = l_wrbtr_rbkp + :lt_rbkp.SupplierInvoiceItemAmount[l_indx_rbkp];
                        ELSE
                            l_wrbtr_rbkp = :lt_rbkp.SupplierInvoiceItemAmount[l_indx_rbkp];
                        END IF ;
                        IF l_menge_rbkp IS NOT NULL THEN
                            l_menge_rbkp = l_menge_rbkp + :lt_rbkp.QuantityInPurchaseOrderUnit[l_indx_rbkp];
                        ELSE
                            l_menge_rbkp = :lt_rbkp.QuantityInPurchaseOrderUnit[l_indx_rbkp];
                        END IF ;
                        IF l_local_rbkp IS NOT NULL THEN
                            l_local_rbkp = l_local_rbkp + :lt_rbkp.SupplierInvoiceItemAmount[l_indx_rbkp];
                        ELSE
                            l_local_rbkp = :lt_rbkp.SupplierInvoiceItemAmount[l_indx_rbkp];
                        END IF;

                    END IF;

                    l_bstme_rbkp = :lt_rbkp.PurchaseOrderQuantityUnit[l_indx_rbkp];
                    l_gjahr_rbkp = :lt_rbkp.FiscalYear[l_indx_rbkp];
                    l_waers_rbkp = :lt_rbkp.DocumentCurrency[l_indx_rbkp];
                END FOR;
                lt_list.belnr[l_indx_main] = l_belnr;
                lt_list.bldat[l_indx_main] = l_bldat;
                lt_list.rbudt[l_indx_main] = l_budat;
                lt_list.menge[l_indx_main] = l_menge_rbkp;
             -- lt_list.wrbtr[l_indx_main] = l_wrbtr_rbkp;
                lt_list.rwrbt[l_indx_main] = l_wrbtr_rbkp;
                lt_list.bstme[l_indx_main] = l_bstme_rbkp;
                lt_list.gjahr[l_indx_main] = l_gjahr_rbkp;
                lt_list.rwaer[l_indx_main] = l_waers_rbkp;
                lt_list.lwaer[l_indx_main] = l_waers_rbkp;
                lt_list.local[l_indx_main] = l_local_rbkp;
                --原始金額 原始單價 轉換為內部 再參照幣別
                l_lwear = :lt_list.LWAER[l_indx_main];
                l_shift = 0;
                IF :lt_list.kbetr[l_indx_main] IS NOT NULL THEN
                    IF EXISTS( SELECT * FROM ZZ1_I_currency WHERE Currency = l_lwear ) THEN
                        SELECT TOP 1 Decimals INTO l_decimal FROM ZZ1_I_currency WHERE Currency = l_lwear;
                        IF l_decimal IS NOT NULL THEN
                            l_shift = 2 - l_decimal;
                        ELSE
                            l_shift = 2;
                        END IF;
                        lt_list.kbetr[l_indx_main] = :lt_list.kbetr[l_indx_main] / power( 10,l_shift);
                    END IF;
                END IF;
                l_shift = 0;
                IF :lt_list.kwert[l_indx_main] IS NOT NULL THEN
                    IF EXISTS( SELECT * FROM ZZ1_I_currency WHERE Currency = l_lwear ) THEN
                        SELECT TOP 1 Decimals INTO l_decimal FROM ZZ1_I_currency WHERE Currency = l_lwear;
                        IF l_decimal IS NOT NULL THEN
                           l_shift = 2 - l_decimal;
                        ELSE
                           l_shift = 2 ;
                        END IF;
                        lt_list.kwert[l_indx_main] = :lt_list.kwert[l_indx_main] / power( 10,l_shift);
                    END IF;
                END IF;

                IF :lt_list.insmk[l_indx_main] IS NULL OR :lt_list.insmk[l_indx_main] = '' then
                    lt_list.insmk_txt[l_indx_main] = '未限制使用';
                END IF;
                IF :lt_list.insmk[l_indx_main] = 'X' then
                    lt_list.insmk_txt[l_indx_main] = '品質檢驗';
                END IF;
                IF :lt_list.insmk[l_indx_main] = 'S' then
                    lt_list.insmk_txt[l_indx_main] = '凍結庫存';
                END IF;
                IF EXISTS(  SELECT * FROM ZZ1_I_MaterialDocumentItem_2--是否讀的到資料
                              WHERE ReversedMaterialDocumentYear = l_mjahr AND ReversedMaterialDocument = l_mblnr
                              AND ReversedMaterialDocumentItem = l_zeile  ) then
                    lt_list.cancel[l_indx_main] = 'L';
                END IF ;
                IF :lt_list.sobkz[l_indx_main] = 'K' OR :lt_list.sobkz[l_indx_main] = 'M' OR
                   :lt_list.sobkz[l_indx_main] = 'O' THEN
                   --沒有供應商 做不了 缺少EMLIF欄位
                END IF;
                IF :lt_list.sobkz[l_indx_main] = 'V' OR :lt_list.sobkz[l_indx_main] = 'W' THEN --特殊庫存
                   IF EXISTS( SELECT * FROM ZZ1_I_Customer WHERE Customer = l_kunnr ) THEN
                        SELECT TOP 1 OrganizationBPName1 INTO l_name1_cus FROM ZZ1_I_Customer  WHERE Customer = l_kunnr;
                        l_kunnr_str = concat( l_kunnr,l_name1_cus);
                   END IF;
                   lt_list.kunnr[l_indx_main] =  l_kunnr_str;
                END IF;
                IF :lt_list.sobkz[l_indx_main] = 'E' THEN--特殊庫存
                   lt_list.kdauf[l_indx_main] = concat( :lt_list.kdauf[l_indx_main],:lt_list.kdpos[l_indx_main]);
                END IF;
                l_awkey = CONCAT(:lt_list.mblnr[ l_indx_main ] ,:lt_list.mjahr[l_indx_main] );
                IF EXISTS( SELECT * FROM ZZ1_I_JournalEntry02 WHERE OriginalReferenceDocument = l_awkey ) THEN
                     SELECT TOP 1 AccountingDocument,FiscalYear INTO l_belnr_bkpf ,l_gjahr_bkpf FROM ZZ1_I_JournalEntry02   WHERE OriginalReferenceDocument = l_awkey ;
                     lt_list.bkpf_mblnr[l_indx_main] = l_belnr_bkpf ;
                     lt_list.bkpf_mjahr[l_indx_main] = l_gjahr_bkpf;
                END IF;
                l_belnr_str = null;
                l_gjahr_str = null;
                --會計文件(發票)
                FOR l_indx_belnr IN 1..l_count_rbkp DO
                    l_awkey = null ;
                    l_belnr = null;
                    l_gjahr = null;
                    l_awkey = CONCAT( :lt_belnr.belnr[l_indx_belnr] ,:lt_list.gjahr[l_indx_main] );
                    IF EXISTS( SELECT * FROM ZZ1_I_JournalEntry02 WHERE OriginalReferenceDocument = l_awkey ) THEN
                         SELECT TOP 1 AccountingDocument,FiscalYear INTO l_belnr ,l_gjahr FROM ZZ1_I_JournalEntry02   WHERE OriginalReferenceDocument = l_awkey ;
                         IF l_belnr IS NULL  THEN
                                l_belnr_str = l_belnr;
                         ELSE
                            l_belnr_str = concat(  l_belnr_str,',' );
                            l_belnr_str = concat( l_belnr_str ,l_belnr );
                         END IF;
                         if l_gjahr_str IS NULL then
                            l_gjahr_str = l_gjahr;
                         END IF;
                    END IF;
                END FOR;
                lt_list.bkpf_belnr[l_indx_main] = l_belnr_str;
                lt_list.bkpf_gjahr[l_indx_main] = l_gjahr_str;
                --後續借貸項發票資料整
                --l_indx_invo
                l_bldat_s_str = null;
                l_bldat_h_str = null;
                l_budat_s_str = null;
                l_budat_h_str = null;
                l_belnr_s_str = null;
                l_belnr_h_str = null;
                l_lifnr_s_str = null;
                l_lifnr_h_str = null;
                l_sum_s = 0;
                l_sum_h = 0;
                FOR l_indx_invo IN 1..l_count_invo DO
                    IF :lt_invo.PurchaseOrder[l_indx_invo] = :lt_list.ebeln[l_indx_main] and :lt_invo.PurchaseOrderItem[l_indx_invo] = :lt_list.ebelp[l_indx_main]
                        AND :lt_invo.ReferenceDocumentFiscalYear[l_indx_invo] = :lt_list.mjahr[l_indx_main] AND  :lt_invo.ReferenceDocument[l_indx_invo] = :lt_list.mblnr[l_indx_main]
                        AND :lt_invo.ReferenceDocumentItem[l_indx_invo] = :lt_list.zeile[l_indx_main]
                    then
                        l_bukrs = :lt_invo.CompanyCode[l_indx_invo] ;

                        IF :lt_invo.DebitCreditCode[l_indx_invo] = 'S' THEN --借向
                            IF EXISTS ( SELECT * from zz1_I_CompanyCode WHERE CompanyCode = l_bukrs ) THEN
                                 SELECT TOP 1 Currency INTO  l_waers_s FROM zz1_I_CompanyCode WHERE CompanyCode = l_bukrs  ;
                                 lt_list.waers_s[l_indx_main] = l_waers_s;
                            END IF;
                            IF :lt_invo.PurOrdAmountInCompanyCodeCrcy[l_indx_invo] IS NOT NULL then
                                l_sum_s = l_sum_s + :lt_invo.PurOrdAmountInCompanyCodeCrcy[l_indx_invo];
                            END IF;
                            lt_list.gjahr_s[l_indx_main] = :lt_invo.PurchasingHistoryDocumentYear[l_indx_invo];
                            IF l_belnr_s_str IS NULL THEN
                                l_belnr_s_str = :lt_invo.PurchasingHistoryDocument[l_indx_invo];
                            ELSE
                                l_belnr_s_str = concat( l_belnr_s_str,',');
                                l_belnr_s_str = concat ( l_belnr_s_str,:lt_invo.PurchasingHistoryDocument[l_indx_invo] );
                            END IF ;
                            lt_list.belnr_s[l_indx_main] = l_belnr_s_str;
                            IF l_bldat_s_str IS NULL THEN
                                l_bldat_s_str = :lt_invo.DocumentDate[l_indx_invo];
                            ELSE
                                l_bldat_s_str = concat( l_bldat_s_str,',');
                                l_bldat_s_str = concat( l_bldat_s_str,:lt_invo.DocumentDate[l_indx_invo] );
                            END IF;
                            lt_list.bldat_s[l_indx_main] = l_bldat_s_str;
                            IF l_budat_s_str IS NULL THEN
                                l_budat_s_str = :lt_invo.PostingDate[l_indx_invo];
                            ELSE
                                l_budat_s_str = concat( l_budat_s_str,',');
                                l_budat_s_str = concat( l_budat_s_str,:lt_invo.PostingDate[l_indx_invo] );
                            END IF;
                            lt_list.budat_s[l_indx_main] = l_budat_s_str;
                            IF l_lifnr_s_str IS NULL THEN
                                l_lifnr_s_str  = :lt_invo.InvoicingParty[l_indx_invo];
                            ELSE
                                l_lifnr_s_str  = concat( l_lifnr_s_str ,',');
                                l_lifnr_s_str  = concat( l_lifnr_s_str ,:lt_invo.InvoicingParty[l_indx_invo] );
                            END IF ;
                        END IF;
                        IF :lt_invo.DebitCreditCode[l_indx_invo] = 'H' THEN --貸項
                            IF EXISTS ( SELECT * from zz1_I_CompanyCode WHERE CompanyCode = l_bukrs ) THEN
                                 SELECT TOP 1 Currency INTO  l_waers_h FROM zz1_I_CompanyCode WHERE CompanyCode = l_bukrs  ;
                                 lt_list.waers_h[l_indx_main] = l_waers_h;
                            END IF;
                            lt_list.gjahr_h[l_indx_main] = :lt_invo.PurchasingHistoryDocumentYear[l_indx_invo];
                            IF :lt_invo.PurOrdAmountInCompanyCodeCrcy[l_indx_invo] IS NOT NULL then
                                l_sum_h = l_sum_h + :lt_invo.PurOrdAmountInCompanyCodeCrcy[l_indx_invo];
                            END IF;
                         --   lt_list.dmbtr_h[l_indx_main] = :lt_list.dmbtr_h[l_indx_main] + :lt_invo.PurOrdAmountInCompanyCodeCrcy[l_indx_invo];
                            IF l_belnr_h_str IS NULL THEN
                                l_belnr_h_str = :lt_invo.PurchasingHistoryDocument[l_indx_invo];
                            ELSE
                                l_belnr_h_str = concat( l_belnr_h_str,',');
                                l_belnr_h_str = concat ( l_belnr_h_str,:lt_invo.PurchasingHistoryDocument[l_indx_invo] );
                            END IF ;
                            lt_list.belnr_h[l_indx_main] = l_belnr_h_str;
                            IF l_bldat_h_str IS NULL THEN
                                l_bldat_h_str = :lt_invo.DocumentDate[l_indx_invo];
                            ELSE
                                l_bldat_h_str = concat( l_bldat_s_str,',');
                                l_bldat_h_str = concat( l_bldat_s_str,:lt_invo.DocumentDate[l_indx_invo] );
                            END IF;
                            lt_list.bldat_h[l_indx_main] = l_bldat_h_str;
                            IF l_budat_h_str IS NULL THEN
                                l_budat_h_str = :lt_invo.PostingDate[l_indx_invo];
                            ELSE
                                l_budat_h_str = concat( l_budat_h_str,',');
                                l_budat_h_str = concat( l_budat_h_str,:lt_invo.PostingDate[l_indx_invo] );
                            END IF;
                            lt_list.budat_h[l_indx_main] = l_budat_h_str;
                            IF l_lifnr_h_str IS NULL THEN
                                l_lifnr_h_str  = :lt_invo.InvoicingParty[l_indx_invo];
                            ELSE
                                l_lifnr_h_str  = concat( l_lifnr_h_str ,',');
                                l_lifnr_h_str  = concat( l_lifnr_h_str ,:lt_invo.InvoicingParty[l_indx_invo] );
                            END IF ;
                        END IF;
                    END IF;
                END FOR;
                lt_list.dmbtr_s[l_indx_main] = l_sum_s;
                lt_list.belnr_s[l_indx_main] = l_belnr_s_str;
                lt_list.bldat_s[l_indx_main] = l_bldat_s_str;
                lt_list.budat_s[l_indx_main] = l_budat_s_str;
                lt_list.lifnr_s[l_indx_main] = l_lifnr_s_str;
                lt_list.dmbtr_h[l_indx_main] = l_sum_h;
                lt_list.belnr_h[l_indx_main] = l_belnr_h_str;
                lt_list.bldat_h[l_indx_main] = l_bldat_h_str;
                lt_list.budat_h[l_indx_main] = l_budat_h_str;
                lt_list.lifnr_h[l_indx_main] = l_lifnr_h_str;

                --l_conut_invo--
                --發票資料整理END

*                l_year = :lt_list.mjahr[l_indx_main];
*                l_belnr_rseg_str = NULL;
*                l_lifnr_rseg_str = NULL;
*                l_wrbtr_rseg = NULL;
*                --發票實際交貨成本
*                l_wrbtr_rseg = null;
*                l_belnr_rseg_str = null;
*                l_lifnr_rseg_str = null;
*                l_bldat_rseg_str = null;
*                l_budat_rseg_str = null;
*                lt_invo2 = SELECT * FROM ZZ1_I_ZMM07_rseg WHERE FiscalYear = l_year AND PurchaseOrder = l_ebeln AND PurchaseOrderItem = l_ebelp AND FreightSupplier <> '';
*                SELECT COUNT ( * ) INTO l_count_invo2 FROM :lt_invo2;
*                FOR l_indx_invo2 IN 1..l_count_invo2 DO
*                    IF :lt_invo2.FreightSupplier[l_indx_invo2] IS NOT NULL THEN
*                        IF l_wrbtr_rseg IS NOT NULL THEN
*                            l_wrbtr_rseg = l_wrbtr_rseg + :lt_invo2.SupplierInvoiceItemAmount[l_indx_invo2];
*                        ELSE
*                            l_wrbtr_rseg = :lt_invo2.SupplierInvoiceItemAmount[l_indx_invo2];
*                        END IF;
*                        IF l_belnr_rseg_str IS NOT NULL THEN --發票文件
*                             l_belnr_rseg_str = concat ( l_belnr_rseg_str ,',' );
*                             l_belnr_rseg_str = concat ( l_belnr_rseg_str ,:lt_invo2.SupplierInvoice[l_indx_invo2] );
*                        ELSE
*                             l_belnr_rseg_str  = :lt_invo2.SupplierInvoice[l_indx_invo2];
*                        END IF;
*                        IF l_lifnr_rseg_str IS NOT NULL THEN--供應商
*                            l_lifnr_rseg_str = concat ( l_lifnr_rseg_str ,',' );
*                            l_lifnr_rseg_str = concat( l_lifnr_rseg_str, :lt_invo2.FreightSupplier[l_indx_invo2]);
*                        ELSE
*                            l_lifnr_rseg_str = :lt_invo2.FreightSupplier[l_indx_invo2];
*                        END IF ;
*
*                        IF l_bldat_rseg_str IS NOT NULL THEN--文件日
*                            l_bldat_rseg_str = concat( l_bldat_rseg_str, ',' );
*                            l_bldat_rseg_str = concat ( l_bldat_rseg_str, :lt_invo2.DocumentDate[l_indx_invo2] );
*                        ELSE
*                            l_bldat_rseg_str = :lt_invo2.DocumentDate[l_indx_invo2];
*                        END IF ;
*                        IF l_budat_rseg_str IS NOT NULL THEN --過帳日
*                            l_budat_rseg_str = concat( l_budat_rseg_str, ',' );
*                            l_budat_rseg_str = concat ( l_budat_rseg_str, :lt_invo2.PostingDate[l_indx_invo2] );
*                        ELSE
*                            l_budat_rseg_str = :lt_invo2.PostingDate[l_indx_invo2];
*                        END IF ;
*                    END IF ;
*                END FOR;
*                lt_list.act_wrbtr[l_indx_main] = l_wrbtr_rseg;
*                lt_list.act_belnr[l_indx_main] = l_belnr_rseg_str;
*                lt_list.act_lifnr[l_indx_main] = l_lifnr_rseg_str ;
*                lt_list.act_bldat[l_indx_main] = l_bldat_rseg_str;
*                lt_list.act_budat[l_indx_main] = l_budat_rseg_str;
                --實際交貨發票END
/*
                IF :lt_list.erfmg[l_indx_main] IS NOT NULL THEN
                    IF :lt_list.erfmg[l_indx_main] <> 0 THEN
                        lt_list.netpl[l_indx_main] =
                            ( :lt_list.local[l_indx_main] + :lt_list.dmbtr_s[l_indx_main] - :lt_list.dmbtr_h[l_indx_main] ) / :lt_list.erfmg[l_indx_main];
                    END IF;
                END IF;
*/
            END FOR ;
            RETURN
              :lt_list;
    endmethod.
ENDCLASS.
