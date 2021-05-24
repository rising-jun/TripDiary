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
        
        input.viewWillAppear?.filter{$0 == .viewWillAppear}.take(1).subscribe{
            preparingViews.accept(ReadyState.ready)
        }.disposed(by: disposeBag)
        
        
        return Output(preparingView: preparingViews.asDriver())
    }
    
    
    struct Input{
        var viewWillAppear: Observable<ViewLifeState>?
        
    }
    
    struct Output{
        var preparingView: Driver<ReadyState>?
    }
    
}


