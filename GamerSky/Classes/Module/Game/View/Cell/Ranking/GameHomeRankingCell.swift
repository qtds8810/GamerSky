//
//  GameHomeRankingCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/10.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameHomeRankingCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var ratingView: CosmosView!
    @IBOutlet private weak var rankingBtn: UIButton!
    @IBOutlet private weak var percentLabel: BaseLabel!
    @IBOutlet private weak var gameImageView: UIImageView!
    @IBOutlet private weak var gameNameLabel: BaseLabel!
    
    private var rankingImage = [#imageLiteral(resourceName: "common_Icon_Index1_16x18"), #imageLiteral(resourceName: "common_Icon_Index2_16x18"), #imageLiteral(resourceName: "common_Icon_Index3_16x18")]
        
    public var info: GameInfo? {
        
        didSet {
            
            gameNameLabel.text = info?.Title
            gameImageView.qy_setImage(info?.DefaultPicUrl, "")
            percentLabel.text = info?.gsScore
            ratingView.rating = info?.score ?? 0
            
            if tag <= rankingImage.count - 1 {
                
                rankingBtn.setImage(rankingImage[tag], for: .normal)
                return
            }
            rankingBtn.setTitle("\(tag + 1)", for: .normal)
        }
    }
}