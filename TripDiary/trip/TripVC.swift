//
//  TripVC.swift
//  TripDiary
//
//  Created by 김동준 on 2021/05/24.
//

import Foundation
import RxViewController
import RxSwift
import RxCocoa

class TripVC: BaseViewController {

    lazy var v = TripView(frame: view.frame)
    lazy var addItem = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view = self.v
        
        
    }
    private let disposeBag = DisposeBag()
    
    private lazy var input = TripViewModel
        .Input(viewWillAppear: self.rx.viewWillAppear
                                .map{_ in return ViewLifeState.viewWillAppear},
               addDiary: addItem.rx.tap.map{_ in return true})

    private lazy var output = viewModel.transform(input: input)
    private let viewModel = TripViewModel()
    
    override func bindViewModel() {
        
        super.bindViewModel()
        output.preparingView?.filter{$0 == .ready}.drive{ [weak self] _ in
            guard let self = self else { return }
            self.addItem.title = "작성하기"
            self.navigationItem.setRightBarButton(self.addItem, animated: false)
        }.disposed(by: disposeBag)
    
        output.moveToView?.filter{$0 == .writeView}.drive{ [weak self] _ in
            self?.navigationController?.pushViewController(WriteVC(), animated: true)
            
        }.disposed(by: disposeBag)
        
        
    }
    

    
}
