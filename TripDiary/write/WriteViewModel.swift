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
        let tapAction = BehaviorRelay(value: WriteState.none)
        
        input.viewWillAppear?.filter{$0 == .viewWillAppear}.distinctUntilChanged().subscribe{ _ in
            print("ready")
            preparingViews.accept(ReadyState.ready)
        }.disposed(by: disposeBag)
        
        
        input.addPhotoBtn?.subscribe{ action in
            switch action.element{
            case .addPhotoAction :
                print("add photo Action")
                tapAction.accept(WriteState.chosePhoto)
                break
            case .none:
                print("none")
            case .some(.writeState): break
                
            }
        }.disposed(by: disposeBag)
        
        
        return Output(preparingView: preparingViews.asDriver(),
                      action: tapAction.asDriver())
    }
    
    
    struct Input{
        var viewWillAppear: Observable<ViewLifeState>?
        var addPhotoBtn: Observable<WriteButtonTap>?
        
    }
    
    struct Output{
        var preparingView: Driver<ReadyState>?
        var action: Driver<WriteState>?
    }
    
}


