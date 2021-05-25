//
//  WriteVC.swift
//  TripDiary
//
//  Created by 김동준 on 2021/05/24.
//

import Foundation
import RxViewController
import RxSwift

class WriteVC: BaseViewController {
    
    lazy var addItem = UIBarButtonItem()
    lazy var v = WriteView(frame: view.frame)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        v.addPhotoBtn.rx.tap.bind { _ in
            print("tap")
        }.disposed(by: disposeBag)
        
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.popViewController(animated: true)
    }
    
    private let disposeBag = DisposeBag()
    
    private lazy var input = WriteViewModel
        .Input(viewWillAppear: self.rx.viewWillAppear
                                .map{_ in return ViewLifeState.viewWillAppear},
               addPhotoBtn: v.addPhotoBtn.rx.tap.map{return true})

    private lazy var output = viewModel.transform(input: input)
    private let viewModel = WriteViewModel()
    
    let categoryDelegate = CategoryCollection()
    
    override func bindViewModel() {
        
        super.bindViewModel()
        output.preparingView?.filter{$0 == .ready}.drive{ [weak self] _ in
            guard let self = self else { return }
            self.view = self.v
            self.addItem.title = "작성"
            self.navigationItem.setRightBarButton(self.addItem, animated: false)
            
            self.v.categorySet.delegate = self.categoryDelegate
            self.v.categorySet.dataSource = self.categoryDelegate
            self.v.categorySet.register(CategoryCell.self, forCellWithReuseIdentifier: "category")
            
        }.disposed(by: disposeBag)
    
        output.presentToAddPhoto?.filter{$0 == true}.drive{ [weak self] _ in
            guard let self = self else { return }
            print("present To add Photo")
            
        }.disposed(by: disposeBag)
        
        
    }
    
}
