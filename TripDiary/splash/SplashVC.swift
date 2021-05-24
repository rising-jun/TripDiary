//
//  ViewController.swift
//  TripDiary
//
//  Created by 김동준 on 2021/05/24.
//

import UIKit
import RxViewController
import RxSwift

class SplashVC: BaseViewController {

    lazy var v = SplashView(frame: view.frame)
    
    lazy var nav = UINavigationController()
    lazy var homeVC = HomeVC()
    lazy var tripVC = TripVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    private let disposeBag = DisposeBag()
    
    private lazy var input = SplashViewModel
        .Input(viewWillAppear: self.rx.viewWillAppear
                                .map{_ in return ViewLifeState.viewWillAppear},
               readyToMove: after4sec.filter{$0 == .ready})

    private lazy var output = viewModel.transform(input: input)
    private let viewModel = SplashViewModel()
    
    private var animationTimer = Observable<Int>.interval(.seconds(4), scheduler: MainScheduler.instance).take(1)
    private var after4sec = PublishSubject<ReadyState>()
    
    override func bindViewModel() {
        
        super.bindViewModel()
        
        output.preparingView?.filter{$0 == .ready}.drive{ [weak self] _ in
            guard let self = self else { return }
            self.view = self.v
            self.v.animationView.play()
            self.v.animationView.loopMode = .playOnce
            self.animationTimer.bind { val in
                self.after4sec.onNext(.ready)
            }
        }.disposed(by: disposeBag)
    
        
        output.moveToHomeScreen?.filter{$0 == .ready}.drive{ [weak self] _ in
            guard let self = self else { return }
            let tabBar = UITabBarController()
            tabBar.modalPresentationStyle = .fullScreen
            
            tabBar.addChild(self.homeVC)
            
            self.nav.addChild(self.tripVC)
            tabBar.addChild(self.nav)
            
            self.homeVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(), tag: 0)
            self.nav.tabBarItem = UITabBarItem(title: "여행", image: UIImage(), tag: 1)
            self.present(tabBar, animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }


}

