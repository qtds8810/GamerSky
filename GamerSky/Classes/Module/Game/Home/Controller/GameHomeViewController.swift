//
//  GameViewController.swift
//  GamerSky
//
//  Created by QY on 2018/4/2.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import SwiftNotificationCenter
import RxSwift
import NSObject_Rx
import RxDataSources

class GameHomeViewController: BaseViewController {
    
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .grouped)
        tableView.delegate = self
        tableView.register(cellType: GameHomeRecommendContentCell.self)
        tableView.register(cellType: GameHomeWaitSellContentCell.self)
        tableView.register(cellType: GameHomeRankingContentCell.self)
        tableView.register(cellType: GameTagContentCell.self)
        tableView.register(cellType: GameHomeColumnContentCell.self)
        tableView.register(headerFooterViewType: GameHomeSectionHeader.self)
        tableView.contentInset = UIEdgeInsetsMake(kTopH, 0, 25, 0)
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(kTopH, 0, 25, 0)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.tableHeaderView = headerView
        return tableView
    }()
    
    private lazy var headerView: GameHomeHeaderView = {
        
        let headerView = GameHomeHeaderView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: GameHomeHeaderView.height))
        return headerView
    }()
    
    private lazy var viewModel = GameHomeViewModel()
    
    private lazy var vmOutput: GameHomeViewModel.GameHomeOutput = {
        
        let vmOutput = viewModel.transform(input: GameHomeViewModel.GameHomeInput())
        return vmOutput
    }()
    
    var dataSource : RxTableViewSectionedReloadDataSource<GameHomeSection>!

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        setUpNavi()
        setUpRefresh()
        bindUI()
    }
    
    override func repeatClickTabBar() {
        print("\(self)")
    }
}

extension GameHomeViewController {
    
    private func bindUI() {
        
        dataSource = RxTableViewSectionedReloadDataSource<GameHomeSection>(configureCell: { (ds, tableView, indexPath, item) -> UITableViewCell in
            
            switch ds[indexPath] {
            case let .specialDetailItem(row):
                
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameHomeRecommendContentCell.self)
                cell.gameSpecialDetail = row
                return cell
            case let .hotItem(row, sectionModels):
                
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameHomeWaitSellContentCell.self)
                cell.sectionType = sectionModels[indexPath.section].sectionType
                cell.game = row
                return cell
            case let .specialListItem(row):
                
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameHomeColumnContentCell.self)
                cell.columnGame = row
                return cell
            case let .waitSellItem(row,sectionModels):
                
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameHomeWaitSellContentCell.self)
                cell.sectionType = sectionModels[indexPath.section].sectionType
                cell.game = row
                return cell
            case let .rankingItem(row):
                
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameHomeRankingContentCell.self)
                cell.rankingGame = row
                return cell
            case let .expectedItem(row, sectionModels):
                
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameHomeWaitSellContentCell.self)
                cell.sectionType = sectionModels[indexPath.section].sectionType
                cell.game = row
                return cell
            case let .tagItem(row):
                
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameTagContentCell.self)
                cell.gameTag = row
                return cell
            }
        })
        
        vmOutput.sections
        .drive(tableView.rx.items(dataSource: dataSource))
        .disposed(by: rx.disposeBag)
    }
}

extension GameHomeViewController: Refreshable {
    
    private func setUpRefresh() {
        
        let refreshHeader = initRefreshHeader(tableView) { [weak self] in
            self?.vmOutput.requestCommand.onNext(())
        }
        vmOutput.autoSetRefreshHeaderStatus(header: refreshHeader).disposed(by: rx.disposeBag)
        refreshHeader.beginRefreshing()
    }
}

extension GameHomeViewController {
    
    private func setUpUI() {
        
        view.addSubview(tableView)
    }
    
    // MARK: - 设置导航栏
    private func setUpNavi() {
        
        automaticallyAdjustsScrollViewInsets = false
        let leftItem = BaseLabel(frame: CGRect(x: 10, y: 0, width: 200, height: kNaviBarH))
        leftItem.font = PFM18Font
        leftItem.text = "游戏"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftItem)
    }
}

// MARK: - UITableViewDelegate
extension GameHomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeader = tableView
            .dequeueReusableHeaderFooterView(GameHomeSectionHeader.self)
//        sectionHeader.sectionData = sectionData[section]
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cellHeight = [GameHomeRecommendContentCell.cellHeight, GameHomeWaitSellContentCell.hotHeight, GameHomeColumnContentCell.cellHeight, GameHomeWaitSellContentCell.waitSellingHeight, GameHomeRankingContentCell.cellHeight, GameHomeWaitSellContentCell.hotHeight,GameTagContentCell.cellHeight]
        return cellHeight[indexPath.section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return GameHomeSectionHeader.sectionHeight
    }
}
