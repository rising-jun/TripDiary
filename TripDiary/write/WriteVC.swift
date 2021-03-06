//
//  WriteVC.swift
//  TripDiary
//
//  Created by 김동준 on 2021/05/24.
//

import Foundation
import RxViewController
import RxSwift
import RxGesture

class WriteVC: BaseViewController {
    
    lazy var addItem = UIBarButtonItem()
    lazy var v = WriteView(frame: view.frame)
    
    lazy var imagePickerVC = UIImagePickerController()
    lazy var imagePickerDelegate = CameraDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.popViewController(animated: true)
    }
    
    private let disposeBag = DisposeBag()
    private let viewModel = WriteViewModel()
    
    private lazy var input = WriteViewModel
        .Input(viewWillAppear: self.rx.viewWillAppear
                                .map{_ in return ViewLifeState.viewWillAppear},
               addPhotoBtn: v.addPhotoBtn.rx.tap.map{return WriteButtonTap.addPhotoAction}.asObservable())

    private lazy var output = viewModel.transform(input: input)
    
    
    let categoryDelegate = CategoryCollection()
    
    override func bindViewModel() {
        
        super.bindViewModel()
        output.preparingView?.filter{$0 == .ready}.drive{ [weak self] _ in
            guard let self = self else { return }
            self.view = self.v
            self.addItem.title = "작성"
            self.navigationItem.setRightBarButton(self.addItem, animated: false)
            self.imagePickerVC.delegate = self.imagePickerDelegate
            
            self.v.categorySet.delegate = self.categoryDelegate
            self.v.categorySet.dataSource = self.categoryDelegate
            self.v.categorySet.register(CategoryCell.self, forCellWithReuseIdentifier: "category")
            
        }.disposed(by: disposeBag)
    
        output.action?.drive{ [weak self] state in
            guard let self = self else { return }
            switch state{
            case .chosePhoto:
                self.imagePickerVC.sourceType = .photoLibrary
                
                let imagePublish = PublishSubject<UIImage>()
                self.imagePickerDelegate.imagePublish = imagePublish
                self.present(self.imagePickerVC, animated: true, completion: nil)
                imagePublish.bind { [weak self] image in
                    self?.imagePickerVC.dismiss(animated: true, completion: nil)
                    self?.v.tripImage.image = image
                }.disposed(by: self.disposeBag)
                
                break
            case .none:
                print("none")
            }
            
        }.disposed(by: disposeBag)
        
        
    }
    
}
