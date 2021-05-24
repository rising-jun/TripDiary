//
//  SplashViewModel.swift
//  TripDiary
//
//  Created by 김동준 on 2021/05/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SplashViewModel: ViewModelType{
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let preparingViews = BehaviorRelay(value: ReadyState.yet)
        let after4sec = BehaviorRelay(value: ReadyState.yet)
        
        input.viewWillAppear?.filter{$0 == .viewWillAppear}.take(1).subscribe{
            preparingViews.accept(ReadyState.ready)
        }.disposed(by: disposeBag)
        
        input.readyToMove?.filter{$0 == .ready}.take(1).subscribe{
            after4sec.accept(ReadyState.ready)
        }.disposed(by: disposeBag)
        
        return Output(preparingView: preparingViews.asDriver(),
                      moveToHomeScreen: after4sec.asDriver())
    }
    
    
    struct Input{
        var viewWillAppear: Observable<ViewLifeState>?
        var readyToMove: Observable<ReadyState>?
    }
    
    struct Output{
        var preparingView: Driver<ReadyState>?
        var moveToHomeScreen: Driver<ReadyState>?
    }
    
}

