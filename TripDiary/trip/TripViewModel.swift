//
//  TripViewModel.swift
//  TripDiary
//
//  Created by 김동준 on 2021/05/24.
//

import Foundation
import RxSwift
import RxCocoa

final class TripViewModel: ViewModelType{
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let preparingViews = BehaviorRelay(value: ReadyState.yet)
        let realmState = BehaviorRelay(value: RealmState.none)
        let vcState = BehaviorRelay(value: VCState.tripView)
        
        input.viewWillAppear?.filter{$0 == .viewWillAppear}.take(1).subscribe{
            preparingViews.accept(ReadyState.ready)
            realmState.accept(RealmState.read)
        }.disposed(by: disposeBag)
        
        input.addDiary?.filter{$0 == true}.subscribe(onNext: { touched in
            if touched{
                print("toucehd")
                vcState.accept(VCState.writeView)
            }
        }).disposed(by: disposeBag)
        
        return Output(preparingView: preparingViews.asDriver(),
                      moveToView: vcState.asDriver())
    }
    
    
    struct Input{
        var viewWillAppear: Observable<ViewLifeState>?
        var addDiary: Observable<Bool>?
        
    }
    
    struct Output{
        var preparingView: Driver<ReadyState>?
        var showList: Driver<RealmState>?
        var moveToView: Driver<VCState>?
        
    }
    
}

