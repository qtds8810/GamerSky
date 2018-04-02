//
//  QYRefreshHeader.swift
//  BookShopkeeper
//
//  Created by engic on 2018/3/30.
//  Copyright © 2018年 dingding. All rights reserved.
//

import MJRefresh

class QYRefreshHeader: MJRefreshGifHeader {
    
    /// 初始化
    override func prepare() {
        super.prepare()

    }
}

class QYRefreshFooter: MJRefreshAutoNormalFooter {
    
    /// 初始化
    override func prepare() {
        
        super.prepare()
        // 设置控件的高度
        mj_h = 50
        setTitle("没有更多数据啦", for: .noMoreData)
    }
}