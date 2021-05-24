//
//  HomeVC.swift
//  TripDiary
//
//  Created by 김동준 on 2021/05/24.
//

import Foundation
import RxViewController
import RxSwift

class HomeVC: BaseViewController {

    lazy var v = HomeView(frame: view.frame)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view = v
    }

}
