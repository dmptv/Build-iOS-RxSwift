//
//  FirstViewController.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 29.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit
import Material
import Moya
import PopupDialog
import SnapKit
import Kingfisher
import RxCocoa
import RxSwift
import RxDataSources


struct SectionOfCustomData {
    let title: String
    var items: [FlickrPhoto]
}

extension SectionOfCustomData: SectionModelType {
    typealias Item = FlickrPhoto
    
    init(original: SectionOfCustomData, items: [FlickrPhoto]) {
        self = original
        self.items = items
    }
}

extension SectionOfCustomData: AnimatableSectionModelType {
    typealias Identity = String

    var identity: String {
        return title
    }
}

class FirstViewController: UIViewController, Stepper, FABMenuDelegate {

    private(set) var viewModel: FirstVCViewModel
    private let disposeBag = DisposeBag()
    
    var collectionView: UICollectionView!
    
    var data = BehaviorRelay<[SectionOfCustomData]>(value: [
        SectionOfCustomData(title: "", items: [])
        ])
    
    var dataSource: RxCollectionViewSectionedAnimatedDataSource<SectionOfCustomData>?
    
    init(viewModel: FirstVCViewModel) {
        self.viewModel = viewModel
      
        super.init(nibName: nil, bundle: nil)
        
        setupFabMenu()
    }

    private func setupFabMenu() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //FIXME: - size for items, header items - fullfill
        
        viewModel.geiPhotos(search: "NY", page: 1)
   
        setupUI()
        
        data.asDriver()
            .drive(collectionView.rx.items(dataSource: dataSource!))
            .disposed(by: disposeBag)
        
        viewModel.photo.asObservable()
            .filter { $0.count > 0 }
            .subscribe({[weak self] event in
                self?.data.accept([
                    SectionOfCustomData(title: "Section: 0", items: event.element ?? [])
                    ])
            })
            .disposed(by: disposeBag)
    }
    
    private func setupUI() {
        setupCollectionView()
        setupRefreshControl()
        
        setupDataSource()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        
        collectionView.register(Cell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(Header.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header")
    }
    
    private func setupDataSource() {
        dataSource = RxCollectionViewSectionedAnimatedDataSource<SectionOfCustomData>(configureCell: {
            _, cv, indexPath, item in
            
            let cell = cv.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
            cell.titleLabel.text = item.title
            cell.titleLabel.backgroundColor = .yellow
            return cell
            
        }, configureSupplementaryView: { _, cv, kind, indP in
            
            let header = cv.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indP) as! Header
            header.titleLabel.text = "Section \(indP.section)"
            
            header.titleLabel.backgroundColor = .cyan
            
            return header
        }, canMoveItemAtIndexPath: { _, _ in true })
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    private func setupRefreshControl() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let tabVC = parent as? AppTabBarController {
            tabVC.didTapTab = {_ in }
        }
        
    }
    
    // MARK: - Methods
    
    @objc
    private func refreshFeed() { }
    
    private func onUnauthorized() { }
    
    private func setupFABButton() { }
    
    private func setupFABMenuItems() { }
    
    private func setupFABMenuItem(title: String, onTap: @escaping (() -> Void)) -> FABMenuItem {
        
        return FABMenuItem()
    }
    
    private func openQuestionnaire(id: String, loadOnlyStatistics: Bool) { }
    
    // MARK: - FABMenuDelegate
    
    func fabMenuWillOpen(fabMenu: FABMenu) { }
    
    func fabMenuWillClose(fabMenu: FABMenu) { }
    
    func fabMenuDidClose(fabMenu: FABMenu) { }
    
}

extension FirstViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 200, height: 100)
    }
    
}


class Header: UICollectionReusableView {
    var titleLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

class Cell: UICollectionViewCell {
    var titleLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}





























