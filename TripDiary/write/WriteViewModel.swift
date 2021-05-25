//
//  WriteViewModel.swift
//  TripDiary
//
//  Created by 김동준 on 2021/05/24.
//

import Foundation
import RxSwift
import RxCocoa

final class WriteViewModel: ViewModelType{
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let preparingViews = BehaviorRelay(value: ReadyState.yet)
        let tapAddPhoto = BehaviorRelay(value: false)
        input.viewWillAppear?.filter{$0 == .viewWillAppear}.take(1).subscribe{
            preparingViews.accept(ReadyState.ready)
        }.disposed(by: disposeBag)
        
        input.addPhotoBtn?.filter{$0 == true}.subscribe{
            tapAddPhoto.accept(true)
        }.disposed(by: disposeBag)
        
        
        return Output(preparingView: preparingViews.asDriver(),
                      presentToAddPhoto: tapAddPhoto.asDriver())
    }
    
    
    struct Input{
        var viewWillAppear: Observable<ViewLifeState>?
        var addPhotoBtn: Observable<Bool>?
        
    }
    
    struct Output{
        var preparingView: Driver<ReadyState>?
        var presentToAddPhoto: Driver<Bool>?
    }
    
}


