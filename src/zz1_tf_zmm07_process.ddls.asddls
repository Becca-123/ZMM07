@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: '採購進貨明細表資料處理'
define table function ZZ1_TF_ZMM07_process
with parameters 
    @Environment.systemField: #CLIENT
    p_client : abap.clnt
returns {
    client : abap.clnt;
    bukrs  : abap.char(4);
    ebeln  : abap.char(10);
    lifnr  : abap.char(10);
    budat  : abap.dats;
    mblnr  : abap.char(10);
    MKPF_BLDAT : abap.dats;
    ZEILE  : abap.numc(4); //4 or 8?
    matnr  : abap.char(40);
  // TXZ01  : abap.char(20);
    werks  : abap.char(4);
    lgort  : abap.char(4);
    CHARG  : abap.char(20);
    ERFMG  : abap.quan( 13,3 );
  //  ERFME_CH  : abap.char(20); //單位
    WAERS  : abap.cuky(5);//幣別
    NETPR  : abap.curr( 13,2);
    PEINH  : abap.dec(5);
    UPRICE : abap.curr(13,2);
    WRBTR  : abap.curr(13,2);
    BWAER  : abap.cuky(5);//幣別
    dmbtr  : abap.curr( 13,2);//物料文件金額 
    DMBTR_E  : abap.curr( 13,2);//預估金額本國幣
    DMBTR_Z  : abap.curr( 13,2);//預估交貨成本
    WAERS_LOC  : abap.cuky(5);//本國幣
    MJAHR  : abap.numc(4);//物料文件年度  4 or 8?
    GJAHR  : abap.numc(4);//發票文件年度 4 or 8?
    LWAER : abap.cuky(5);//本國幣
    shkzg : abap.char(1);//借貸方指示碼 物料文件
   // EBELN : abap.char(20);
    EBELP : abap.numc(5);
    EKORG : abap.char(4);//採購組織
    bsart : abap.char(4);//採購文件類型
    BEDAT : abap.dats;//採購文件類型
    EINDT : abap.char(255);//預計交貨日
    LOEKZ : abap.char(1);//刪除指示碼
    RETOI : abap.char(1);//退貨項目 
    UMSON : abap.char(1);//免費項目
    MENGE : abap.quan( 13, 3);//數量 resg-menge
    //BSTME_CH :abap.char(3);//單位(中文)
    RWAER : abap.cuky(5);//幣別
    RWRBT : abap.curr( 13,2);//發票金額
    LOCAL : abap.curr( 13,2); //參考本國幣
    BELNR : abap.char(255);//發票文件號碼
    BLDAT : abap.char(255);//發票文件日期
    RBUDT : abap.char(255);//發票過帳日期
    XBLNR : abap.char(255); // 參考
    BKTXT : abap.char(255);//BKPF 表頭內文
    BWART : abap.char(4);//異動類型
    INSMK : abap.char(1);//庫存類型
    INSMK_txt :abap.char(255);//庫存類型說明
    SOBKZ : abap.char(1);//特殊庫存
    KDAUF : abap.char(40);//銷售項目
    AUFNR : abap.char(12);//訂單號碼
    ANLN1 : abap.char(12);//資產編號
    SAKTO : abap.char(10);//總帳科目
    KOSTL : abap.char(10);//成本中心
    CANCEL : abap.char(1);//取消碼
    SJAHR : abap.numc(4);//取消物料文件年度
    SMBLN : abap.char(10); //取消物料文件
    SMBLP : abap.numc(4);//取消物料文件項目
    BKPF_MBLNR : abap.char(10);//會計文件(物料)
    BKPF_BELNR : abap.char(255);//會計文件(發票)
    IDNLF :abap.char(35);//供應商物料號碼
    KBETR :abap.curr( 13,2); //原始單價
    KWERT :abap.curr( 13,2); //原始金額
    IHREZ :abap.char(12);//您的參考 ekko
    UNSEZ :abap.char(12);//我們的參考 ekko
    BPMNG : abap.quan( 13, 3);//數量 mseg-BPMNG
    MBKTX : abap.char(255);//物料文件表頭內文
    sgtxt : abap.char(50);//物料文件項目內文
    waers_s:abap.cuky(5);//借方本國幣金額 幣別?
    dmbtr_s:abap.curr( 13,2);//借方本國幣金額
    belnr_s:abap.char(255);//後續借項發票文件號碼
    BLDAT_S:abap.char(255);//後續借項發票文件日期
    BUDAT_S:abap.char(255);//後續借項發票過帳日期
    gjahr_s:abap.dats;
    BKPF_BELNR_S:abap.char(255);//後續借項會計文件號碼
    lifnr_s :abap.char(255);//後續借項發票供應商
    WAERS_H:abap.cuky(5);//參考本國幣(貸項)
    DMBTR_H:abap.curr( 13,2);//貸項合計
    BELNR_H:abap.char( 255 );//後續貸項發票文件號碼
    BLDAT_H:abap.char( 255 );//後續貸項發票文件日期
    BUDAT_H:abap.char( 255 );//後續貸項發票過帳日期
    gjahr_h:abap.dats;
    BKPF_BELNR_H:abap.char(255);//後續貸項會計文件號碼
    lifnr_h:abap.char(255);//後續貸項發票供應商
    CN_NETPR:abap.curr( 13,2); //CN-含稅單價
    CN_AMT:abap.curr( 13,2); //CN-含稅金額
    DMBTR_ACTUAL:abap.curr( 13,2);//實際交貨成本
    TOTAL_COST:abap.curr( 13,2);//總成本
    belnr_actual:abap.char(255);//實際交貨成本物料文件
    erfme :abap.unit(3);//物料文件單位
    kzbew :abap.char(1);
    KZZUG :abap.char(1);
    kzvbr :abap.char(1);
    kunnr :abap.char(10);
    kdpos :abap.numc(6);
    kokrs :abap.char(4);
    BPRME :abap.unit(3);//物料文件單位
    retpo :abap.char(1);
    ekgrp :abap.char(3);
    po_werks:abap.char(4);
    knumv :abap.char(10);
    menge_po:abap.quan( 13, 3);//數量 
    shkzg_e:abap.char(1);
    shkzg_z:abap.char(1);
    mkpf_bladt: abap.dats; --物料文件日期
    bstme:abap.unit(3);--發票計量單位
    netpl:abap.curr(13,2);
    bkpf_mjahr:abap.dats;
    bkpf_gjahr:abap.dats;
    act_belnr:abap.char( 255 );--實際交貨發票
    act_lifnr:abap.char( 255 );--實際交貨發票供應商
    act_bldat:abap.char( 255 );--實際交貨發票文件日
    act_budat:abap.char( 255 );--實際交貨發票過帳日
    act_wrbtr:abap.curr(13,2);--實際交貨發票合計
    knttp:abap.char(1); --科目指派種類
}
implemented by method zz1_cl_zmm07=>exec_zmm07;