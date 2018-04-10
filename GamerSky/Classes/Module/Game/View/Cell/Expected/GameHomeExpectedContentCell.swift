//
//  GameHomeExpectedContentCell.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/10.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

/// cell 之间间距
private let kItemMargin: CGFloat = 15
/// 左右间距
private let kEdge: CGFloat = 10
/// 每行最大列数
private let kMaxCol: CGFloat = 4
/// cell 宽度
private let kItemW = (ScreenWidth - (2 * kEdge) - ((kMaxCol - 1) * kItemMargin)) / kMaxCol

class GameHomeExpectedContentCell: UITableViewCell, NibReusable {

    static let cellHeight: CGFloat = ScreenHeight * 0.3
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var flowLayout: UICollectionViewFlowLayout!
    
    public var expectedGame = [GameInfo]() {
        
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - inital
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpCollectionView()
    }
    
    // MARK: - setUpCollectionView
    func setUpCollectionView() {
        
        flowLayout.itemSize = CGSize(width: kItemW, height: GameHomeHotContentCell.cellHeight)
        flowLayout.sectionInset = UIEdgeInsetsMake(0, kEdge, 0, kEdge)
        flowLayout.minimumLineSpacing = kItemMargin
        collectionView.register(cellType: GameHomePageCell.self)
    }
}

// MARK: - UICollectionViewDataSource
extension GameHomeExpectedContentCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return expectedGame.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: GameHomePageCell.self)
        cell.info = expectedGame[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension GameHomeExpectedContentCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}