//
//  SplashView.swift
//  TripDiary
//
//  Created by 김동준 on 2021/05/24.
//

import Foundation
import UIKit
import SnapKit
import Lottie

class SplashView: BaseView{
    
    lazy var introLabel = UILabel()

    let animationView = AnimationView(name: "splashicon")
    
    override func setup() {
        super.setup()
        backgroundColor = .systemBlue
        
        addSubViews(introLabel, animationView)
        animationView.contentMode = .scaleAspectFit
        animationView.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(150)
            make.center.equalTo(self)
        }
        
        introLabel.text = "모두의 여행일지"
        introLabel.textColor = .systemGray5
        introLabel.adjustsFontSizeToFitWidth = true
        introLabel.textAlignment = .center
        introLabel.font = UIFont.boldSystemFont(ofSize: 24)
        introLabel.snp.makeConstraints { make in
            make.top.equalTo(animationView.snp.bottom).offset(0)
            make.centerX.equalTo(animationView)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
        
    }
}
